import { Body, Controller, Get, HttpException, HttpStatus, Param, Post, Query } from '@nestjs/common';
import { GetAllByIdDTO } from 'src/dto/get-all-by-id.dto';
import { GetAllDTO } from 'src/dto/get-all.dto';
import { SetTestProgressDTO } from 'src/dto/progress.dto';
import { QueryByAccountIdDTO, QueryByIdDTO } from 'src/dto/query-by-id.dto';
import { TestxService } from './testx.service';

@Controller('/app/test')
export class TestxController {
    constructor(private testxService: TestxService) {}

    @Get('/all')
    async getAll(
        @Query() query: GetAllDTO
    ) {
        const limit = query.limit || 10;
        const offset = query.offset || 0;

        const tests = limit == 0 ? [] : await this.testxService.getAll(limit, offset);
        
        return {
            timestamp: Date.now(),
            data: {
                tests: tests,
                total: tests.length,
            },
        };
    }

    @Get('/all/progress')
    async getProgressAll(
        @Query() query: GetAllByIdDTO,
    ) {
        const accountId = query.account_id;
        const limit = query.limit || 10;
        const offset = query.offset || 0;

        const testProgresses = limit == 0 ? [] : await this.testxService.getProgressAll(accountId, limit, offset);

        const testProgressesResponse = testProgresses.map(item => {
            return {
                test: item.test,
                progress: {
                    score: item.getScoreAverage(),
                    times: item.times,
                    last_date: item.date.valueOf(),
                }
            };
        });
        
        return {
            timestamp: Date.now(),
            data: {
                progresses: testProgressesResponse,
                total: testProgressesResponse.length,
            },
        };
    }

    @Get('/:id/progress')
    async getProgress(
        @Param() param: QueryByIdDTO,
        @Query() query: QueryByAccountIdDTO,
    ) {
        const accountId = query.account_id;
        const id = param.id;

        if (!(await this.testxService.isTestExisted(id))) {
            throw new HttpException("Test not found", HttpStatus.NOT_FOUND);
        }

        let testProgress = await this.testxService.getProgress(id, accountId);

        if (testProgress == null) {
            return {
                timestamp: Date.now(),
                data: {
                    test: id,
                    progress: {
                        score: {
                            average: 0,
                            highest: 0,
                            lowest: 0,
                        },
                        times: 0,
                        last_date: 0,
                    }
                }
            }
        }
        
        return {
            timestamp: Date.now(),
            data: {
                test: id,
                progress: {
                    score: {
                        average: testProgress.getScoreAverage(),
                        highest: testProgress.scoreHighest,
                        lowest: testProgress.scoreLowest,
                    },
                    times: testProgress.times,
                    last_date: testProgress.date.valueOf(),
                }
            },
        };
    }

    @Post('/:id/progress')
    async setProgress(
        @Param() param: QueryByIdDTO,
        @Body() body: SetTestProgressDTO,
    ) {
        if (!(await this.testxService.isTestExisted(param.id))) {
            throw new HttpException("Test not found", HttpStatus.NOT_FOUND);
        }

        await this.testxService.setProgress(param.id, body.account_id, body.score);
        return {
            timestamp: Date.now(),
            status: "SUCCESS",
        }
    }
}
