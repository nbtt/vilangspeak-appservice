import { Body, Controller, Get, HttpException, HttpStatus, Param, Patch, Post, Put, Query, UseGuards } from '@nestjs/common';
import { RolesAccountGuard } from 'src/auth/roles/roles.account.guard';
import { LoginRole } from 'src/auth/roles/roles.login.decorator';
import { ChangePasswordDTO, CreateAccountDTO, UpdateAccountDTO } from 'src/dto/account.dto';
import { GetAllDTO } from 'src/dto/get-all.dto';
import { QueryByIdDTO } from 'src/dto/query-by-id.dto';
import { Account, AccountRole } from 'src/entity/account.entity';
import { AccountService } from './account.service';

@LoginRole(AccountRole.USER)
@Controller('/app/account')
export class AccountController {
    constructor(
        private accountService: AccountService,
    ) {}
    
    @Post('/register')
    async create(
        @Body() body: CreateAccountDTO,
    ) {
        const account = await this.accountService.create(body);
        return this.parseAccountToResponse(account);
    }

    @UseGuards(RolesAccountGuard)
    @Patch('/:id/update')
    async updateInfo(
        @Param() param: QueryByIdDTO,
        @Body() body: UpdateAccountDTO,
    ) {
        const account = await this.accountService.updateInfo({id: param.id}, body);
        return this.parseAccountToResponse(account);
    }

    @UseGuards(RolesAccountGuard)
    @Put('/:id/change-password')
    async changePassword (
        @Param() param: QueryByIdDTO,
        @Body() body: ChangePasswordDTO,
    ) {
        return {
            ok: true,
        }        
    }

    @UseGuards(RolesAccountGuard)
    @Get('/:id/info')
    async getInfo(
        @Param() param: QueryByIdDTO,
    ) {
        const account = await this.accountService.getInfo({id: param.id});

        if (account == null) {
            throw new HttpException(`Not found account by id ${param.id}`, HttpStatus.NOT_FOUND);
        }

        return this.parseAccountToResponse(account);
    } 

    @UseGuards(RolesAccountGuard)
    @Get('/:id/achievement')
    async getAllAchievement(
        @Param() param: QueryByIdDTO,
        @Query() query: GetAllDTO,
    ) {
        const limit = query.limit || 10;
        const offset = query.offset || 0;

        const achievements = await this.accountService.getAchievements(param.id, limit, offset);

        const achievementsResponse = achievements.map((item) => {
            return {
                id: item.achievement.id,
                name: item.achievement.name,
                image: item.achievement.image,
                date: item.date.valueOf(),
            }
        });

        return {
            timestamp: Date.now(),
            data: {
                account: param.id,
                achievements: achievementsResponse,
                total: achievementsResponse.length,
            }
        };
    }

    parseAccountToResponse(account: Account) {
        const {password, ...result} = account;
        
        return {
            timestamp: Date.now(),
            data: {
                account: result,
            },
        };
    }
}
