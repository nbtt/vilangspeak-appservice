import { Injectable, CanActivate, ExecutionContext, Inject, UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Reflector } from '@nestjs/core';
import { JwtService } from '@nestjs/jwt';
import { AuthService } from '../auth.service';
import { RolesGuard } from './roles.guard';

// Check if account is authenticated, then
// Check if defined roles match account's role, then
// Check if refresh token is valid
@Injectable()
export class RolesRefreshGuard extends RolesGuard implements CanActivate {
  constructor(
    protected reflector: Reflector, 
    
    @Inject(JwtService)
    private jwtService: JwtService, 
    
    @Inject(ConfigService)
    private configService: ConfigService,
    
    @Inject(AuthService)
    private authService: AuthService,
    ) {
    super(reflector);
  }

  async checkRefreshTokenValid(request: any) {
    const user = request.user;
    const refreshToken = request.body.refresh_token;

    // verify jwt token
    const payload = this.jwtService.verify(refreshToken, {
        secret: this.configService.get('jwt.secret.refresh'),
        ignoreExpiration: false,
    });

    // check payload
    const result = this.checkRefreshPayload(payload, user) 
      && (await this.authService.checkLoginTime({id: payload.sub}, payload.login_role, payload.iat));
    if (result == false) {
      throw new UnauthorizedException();
    }

    return true;
  }

  checkRefreshPayload(refreshPayload: any, user: any) {
    return refreshPayload.sub == user.sub && refreshPayload.login_role == user.login_role;
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    // execute RolesGuard
    const isAuthorizedRoles = await super.canActivate(context);

    // not proceed if unauthorized
    if (!isAuthorizedRoles) {
        return false;
    }

    const request = context.switchToHttp().getRequest();
    return this.checkRefreshTokenValid(request);
  }
}
