import { Controller, Get, HttpException, HttpStatus, Param, Query } from '@nestjs/common';
import { GetAllDTO } from 'src/dto/get-all.dto';
import { QueryByIdDTO } from 'src/dto/query-by-id.dto';
import { AccountService } from './account.service';

@Controller('/app/account')
export class AccountController {
    constructor(private accountService: AccountService) {}

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

    @Get('/:id/achievement')
    async getAllAchievement(
        @Param() param: QueryByIdDTO,
        @Query() query: GetAllDTO,
    ) {
        const achievements = await this.accountService.getAchievements(param.id);

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
