import { CanActivate, ExecutionContext, Injectable } from "@nestjs/common";
import { Reflector } from "@nestjs/core";
import { RolesAccountGuard } from "./roles.account.guard";

@Injectable()
export class RolesAccountBodyGuard extends RolesAccountGuard implements CanActivate {
    constructor(protected reflector: Reflector) {
      super(reflector);
    }

    canActivate(context: ExecutionContext): Promise<boolean> {
        return super.canActivate(context, 'body.account_id');
    }
}