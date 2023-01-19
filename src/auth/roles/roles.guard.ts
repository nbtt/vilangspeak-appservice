import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AccountRole } from 'src/entity/account.entity';
import { JwtAuthGuard } from '../jwt/jwt.guard';

// Check if account is authenticated, then
// Check if defined roles by @Roles match account's role
@Injectable()
export class RolesGuard extends JwtAuthGuard implements CanActivate {
  constructor(protected reflector: Reflector) {
    super(reflector);
  }

  matchRoles(request: any, roles: AccountRole[]) {
    const user = request.user;

    // match define role
    return roles.includes(user.role);
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    // execute JwtAuthGuard
    const isAuthenticated = await super.canActivate(context);

    // not proceed if not authenticated
    if (!isAuthenticated) {
      return false;
    }
    
    // check if requested role matches defined roles
    const roles = this.reflector.get<AccountRole[]>('roles', context.getHandler());
    // no defined role means match any role
    if (!roles) {
      return true;
    }

    const request = context.switchToHttp().getRequest();
    if (!this.matchRoles(request, roles)) {
      return false;
    }

    // check if current login role equals to login role in token
    const loginRole = this.reflector.get<AccountRole>('loginRole', context.getHandler());
    // perform checking only if defined login Role
    if (loginRole != null) {
      return (loginRole == request.user.login_role);
    }
    
    return true;
  }
}
