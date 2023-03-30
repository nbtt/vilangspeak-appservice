import { Injectable, CanActivate, ExecutionContext, Inject, UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Reflector } from '@nestjs/core';
import { JwtService } from '@nestjs/jwt';
import { getMetadataFromControllerAndHandler } from 'src/common/util';
import { AccountRole } from 'src/entity/account.entity';
import { AuthService } from '../auth.service';
import { RolesGuard } from './roles.guard';

// Check if refresh token is valid
// - token is valid & not expired
// - login time vs iat
// - defined login role match account login role in decrypted payload
@Injectable()
export class RolesRefreshGuard implements CanActivate {
  constructor(
    protected reflector: Reflector, 
    
    @Inject(JwtService)
    private jwtService: JwtService, 
    
    @Inject(ConfigService)
    private configService: ConfigService,
    
    @Inject(AuthService)
    private authService: AuthService,
    ) {}

  async checkRefreshTokenValid(request: any, loginRoles: AccountRole[]) {
    const refreshToken = request.body.refresh_token;

    // verify jwt token
    let payload: any;
    try {
        payload = this.jwtService.verify(refreshToken, {
          secret: this.configService.get('jwt.secret.refresh'),
          ignoreExpiration: false,
      });
    }
    catch {
      // token is expired
      throw new UnauthorizedException();
    }

    // check payload
    const result = this.checkRefreshPayload(payload, loginRoles) 
      && (await this.authService.checkLoginTime({id: payload.sub}, payload.login_role, payload.iat));
    if (result == false) {
      throw new UnauthorizedException();
    }

    return payload;
  }

  checkRefreshPayload(refreshPayload: any, loginRoles: AccountRole[]) {
    return loginRoles.includes(refreshPayload.login_role);
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    // get defined roles
    const loginRoles = getMetadataFromControllerAndHandler<AccountRole>(context, this.reflector, 'loginRole');

    const request = context.switchToHttp().getRequest();
    const payload = await this.checkRefreshTokenValid(request, loginRoles)
    if (!payload) {
      return false;
    }

    // save payload to request
    request.userRefresh = payload;
    return true;
  }
}
