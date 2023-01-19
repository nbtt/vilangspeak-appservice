import { Controller, Get, HttpException, HttpStatus, Param, Query, UseGuards } from '@nestjs/common';
import { RolesAccountGuard } from 'src/auth/roles/roles.account.guard';
import { GetAllDTO } from 'src/dto/get-all.dto';
import { QueryByIdDTO } from 'src/dto/query-by-id.dto';
import { AccountService } from './account.service';

@Controller('/app/account')
export class AccountController {
    constructor(private accountService: AccountService) {}

    @UseGuards(RolesAccountGuard)
    @Get('/:id/info')
    async getInfo(
        @Param() param: QueryByIdDTO,
    ) {
        const account = await this.accountService.getInfo({id: param.id});

        if (account == null) {
            throw new HttpException(`Not found account by id ${param.id}`, HttpStatus.NOT_FOUND);
        }

        const {password, ...result} = account;
        
        return {
            timestamp: Date.now(),
            data: {
                account: result,
            },
        };
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
}
