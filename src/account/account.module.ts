import { Module, OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Account } from 'src/entity/account.entity';
import { AchievementLog } from 'src/entity/achievement-log';
import { AccountController } from './account.controller';
import { AccountService } from './account.service';

@Module({
  imports: [TypeOrmModule.forFeature([Account, AchievementLog])],
  providers: [AccountService, ConfigService],
  controllers: [AccountController],
  exports: [AccountService],
})
export class AccountModule implements OnModuleInit {
  constructor(
    private accountService: AccountService,
    private configService: ConfigService,
  ) {}

  async onModuleInit() {
    const adminAccountInfo = {
        name: this.configService.get("root_account.name"),
        username: this.configService.get("root_account.username"),
        password: this.configService.get("root_account.password"),
        birthday: this.configService.get("root_account.birthday"),
    }
    await this.accountService.createForced(adminAccountInfo);
  }
}
