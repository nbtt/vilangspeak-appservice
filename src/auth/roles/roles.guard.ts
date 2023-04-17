import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { getMetadataFromControllerAndHandler } from 'src/common/util';
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

    
    if (user.role == AccountRole.ADMIN) { // skip if admin
      return true;
    }

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
    const roles = getMetadataFromControllerAndHandler<AccountRole[]>(context, this.reflector, 'roles');
    const request = context.switchToHttp().getRequest();
    // check if exists defined roles
    if (roles.length > 0) {
      if (!this.matchRoles(request, roles)) {
        return false;
      }
    }

    // check if current login role equals to login role in token
    const loginRoles = getMetadataFromControllerAndHandler<AccountRole>(context, this.reflector, 'loginRole');
    // perform checking only if defined login Role
    if (loginRoles.length > 0) {
      return (loginRoles.includes(request.user.login_role));
    }
    
    return true;
  }
}
