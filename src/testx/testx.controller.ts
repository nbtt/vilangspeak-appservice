import { Body, Controller, Get, HttpException, HttpStatus, Param, Post, Query, UseGuards } from '@nestjs/common';
import { RolesAccountGuard } from 'src/auth/roles/roles.account.guard';
import { RolesGuard } from 'src/auth/roles/roles.guard';
import { LoginRole } from 'src/auth/roles/roles.login.decorator';
import { getSuccessResponse } from 'src/common/util';
import { GetAllByIdDTO } from 'src/dto/get-all-by-id.dto';
import { GetAllDTO } from 'src/dto/get-all.dto';
import { SetTestProgressDTO } from 'src/dto/progress.dto';
import { QueryByAccountIdDTO, QueryByIdDTO } from 'src/dto/query-by-id.dto';
import { AccountRole } from 'src/entity/account.entity';
import { Category } from 'src/entity/category.entity';
import { TestxService } from './testx.service';

@LoginRole(AccountRole.USER)
@Controller('/app/test')
export class TestxController {
    constructor(private testxService: TestxService) {}

    @UseGuards(RolesGuard)
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

    @UseGuards(RolesGuard)
    @Get('/recommend')
    async getRecommend(
        @Query() query: QueryByAccountIdDTO,
    ) {
        const recommendTests = await this.testxService.getRecommend(query.account_id);
        const recommendTestsResponse = recommendTests.map(test => {
            return {
                id: test.id,
                name: test.name,
                visible: test.visible,
                category: (test.category instanceof Category) ? test.category.id : test.category,
            }
        });

        return {
            timestamp: Date.now(),
            data: {
                tests: recommendTestsResponse,
                total: recommendTestsResponse.length,
            }
        }
    }

    @UseGuards(RolesAccountGuard)
    @Get('/:id')
    async getOne (
        @Param() param: QueryByIdDTO,
    ) {
        const test = await this.testxService.getOne(param.id);

        if (test == null) {
            throw new HttpException("Test not found", HttpStatus.NOT_FOUND);
        }

        const questionsResponse = test.questions.map((question) => {
            return {
                id: question.id,
                question_type: question.question_type,
                type: question.type,
                content: question.content,
                items: question.items,
            }
        });

        const testResponse = {
            id: test.id,
            name: test.name,
            visible: test.visible,
            category: test.category,
            questions: {
                value: questionsResponse,
                total: questionsResponse.length,
            },
        };

        return {
            timestamp: Date.now(),
            data: {
                test: testResponse,
            }
        }
    }

    @UseGuards(RolesGuard)
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

    @UseGuards(RolesAccountGuard)
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

    @UseGuards(RolesAccountGuard)
    @Post('/:id/progress')
    async setProgress(
        @Param() param: QueryByIdDTO,
        @Body() body: SetTestProgressDTO,
    ) {
        if (!(await this.testxService.isTestExisted(param.id))) {
            throw new HttpException("Test not found", HttpStatus.NOT_FOUND);
        }

        await this.testxService.setProgress(param.id, body.account_id, body.score);
        return getSuccessResponse();
    }
}
