import { Controller, Get, HttpException, HttpStatus, Param } from '@nestjs/common';
import { GetByIdDTO } from 'src/dto/get-by-id.dto';
import { AccountService } from './account.service';

@Controller('/app/account')
export class AccountController {
    constructor(private accountService: AccountService) {}

    @Get('/:id/info')
    async getInfo(
        @Param() param: GetByIdDTO,
    ) {
        const account = await this.accountService.getInfo(param.id);

        if (account == null) {
            throw new HttpException(`Not found account by id ${param.id}`, HttpStatus.NOT_FOUND);
        }
        
        return {
            timestamp: Date.now(),
            data: {
                account: account,
            },
        };
    } 
}
