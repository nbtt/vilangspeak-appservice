import { SetMetadata } from '@nestjs/common';
import { AccountRole } from 'src/entity/account.entity';

export const Roles = (...roles: AccountRole[]) => SetMetadata('roles', roles);