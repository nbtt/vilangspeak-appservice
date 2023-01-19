import { SetMetadata } from '@nestjs/common';
import { AccountRole } from 'src/entity/account.entity';

export const LoginRole = (role: AccountRole) => SetMetadata('loginRole', role);