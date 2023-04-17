import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { makeHashValue } from 'src/common/util';
import { CreateAccountDTO } from 'src/dto/account.dto';
import { Account } from 'src/entity/account.entity';
import { AchievementLog } from 'src/entity/achievement-log';
import { QueryFailedError, Repository } from 'typeorm';

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

    async create(accountInfo: CreateAccountDTO) {
        let isError = false, isDuplicatedAccount = false;
        let errrorMessage = "";
        const insertResult = await this.accountRepository.insert({
            ...accountInfo,
            password: makeHashValue(accountInfo.password),
            role: 1,
        }).catch((e) => {
            isError = true;
            errrorMessage = e.message;
            if (e instanceof QueryFailedError && 
                e.driverError.code == "ER_DUP_ENTRY" && 
                e.message.match("'[^']*'")[0].slice(1, -1) == accountInfo.username) {
                isDuplicatedAccount = true;
            }
        })

        console.log(JSON.stringify(insertResult));

        if (isDuplicatedAccount) {
            throw new HttpException("Username existed", HttpStatus.CONFLICT);
        }

        if (isError) {
            throw new HttpException(errrorMessage, HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return this.getInfo({username: accountInfo.username})
    }

    async createForced(accountInfo: CreateAccountDTO) {
        await this.accountRepository.upsert({
            ...accountInfo,
            password: makeHashValue(accountInfo.password),
            role: 0,
        }, {
            conflictPaths: {
                username: true,
            }
        })
    }

    getAchievements(id: number, limit: number, offset: number): Promise<AchievementLog[]> {
        return this.achievementLogRepository.find({
            take: limit,
            skip: offset,
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
