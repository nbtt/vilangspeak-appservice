import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Account } from 'src/entity/account.entity';
import { Repository } from 'typeorm';

@Injectable()
export class AccountService {
    constructor(
        @InjectRepository(Account)
        private accountRepository: Repository<Account>,
    ) {}

    getInfo(id: number): Promise<Account> {
        return this.accountRepository.findOneBy({
            id: id,
        })
    }
}
