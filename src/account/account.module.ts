import { Module } from '@nestjs/common';
import { AccountService } from './account.service';
import { AccountController } from './account.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Account } from 'src/entity/account.entity';
import { AchievementLog } from 'src/entity/achievement-log';

@Module({
  imports: [TypeOrmModule.forFeature([Account, AchievementLog])],
  providers: [AccountService],
  controllers: [AccountController]
})
export class AccountModule {}
