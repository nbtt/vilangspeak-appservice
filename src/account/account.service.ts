import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Account } from 'src/entity/account.entity';
import { AchievementLog } from 'src/entity/achievement-log';
import { Repository } from 'typeorm';

@Injectable()
export class AccountService {
    constructor(
        @InjectRepository(Account)
        private accountRepository: Repository<Account>,
        @InjectRepository(AchievementLog)
        private achievementLogRepository: Repository<AchievementLog>,
    ) {}

    getInfo(filter: {
        id?: number, 
        username?: string
    }): Promise<Account> {
        return this.accountRepository.findOneBy(filter);
    }

    getAchievements(id: number): Promise<AchievementLog[]> {
        return this.achievementLogRepository.find({
            where: {
                account: {
                    id: id,
                }
            },
            relations: {
                achievement: true,
            }
        });
    }
}
