import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { RolesGuard } from './roles.guard';

// Check if account is authenticated, then
// Check if defined roles match account's role, then
// Verify request ID match account's ID if account's role is user
@Injectable()
export class RolesAccountGuard extends RolesGuard implements CanActivate {
  constructor(protected reflector: Reflector) {
    super(reflector);
  }

  matchRolesAccount(request: any) {
    const user = request.user;
    const requestId = parseInt(request.params['id']);

    // admin role will proceed without any other checks
    if (user.role == 0) {
      return true;
    }

    // for user role, check request ID and user ID

    // ignore check if not specified request ID in param
    if (Number.isNaN(requestId)) {
      return true;
    }

    return requestId == user.sub;
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    // execute RolesGuard
    const isAuthorizedRoles = await super.canActivate(context);

    // not proceed if unauthorized
    if (!isAuthorizedRoles) {
        return false;
    }

    const request = context.switchToHttp().getRequest();
    return this.matchRolesAccount(request);
  }
}
