import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { JwtAuthGuard } from '../jwt/jwt.guard';

// Check if account is authenticated, then
// Check if defined roles by @Roles match account's role
@Injectable()
export class RolesGuard extends JwtAuthGuard implements CanActivate {
  constructor(protected reflector: Reflector) {
    super(reflector);
  }

  matchRoles(request: any, roles: number[]) {
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

    const roles = this.reflector.get<number[]>('roles', context.getHandler());
    // no defined role means match any role
    if (!roles) {
      return true;
    }

    const request = context.switchToHttp().getRequest();
    return this.matchRoles(request, roles);
  }
}
