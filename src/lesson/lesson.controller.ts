import { Body, Controller, Get, HttpException, HttpStatus, Param, Post, Query, UseGuards } from '@nestjs/common';
import { GetAllByIdDTO } from 'src/dto/get-all-by-id.dto';
import { GetAllDTO } from 'src/dto/get-all.dto';
import { QueryByAccountIdDTO, QueryByIdDTO } from 'src/dto/query-by-id.dto';
import { SetLessonProgressDTO } from 'src/dto/progress.dto';
import { LessonService } from './lesson.service';
import { Category } from 'src/entity/category.entity';
import { LoginRole } from 'src/auth/roles/roles.login.decorator';
import { AccountRole } from 'src/entity/account.entity';
import { RolesGuard } from 'src/auth/roles/roles.guard';
import { RolesAccountGuard } from 'src/auth/roles/roles.account.guard';

@LoginRole(AccountRole.USER)
@Controller('/app/lesson')
export class LessonController {
    constructor(private lessonService: LessonService) {}

    @UseGuards(RolesGuard)
    @Get('/all')
    async getAll(
        @Query() query: GetAllDTO
    ) {
        const limit = query.limit || 10;
        const offset = query.offset || 0;

        const lessons = limit == 0 ? [] : await this.lessonService.getAll(limit, offset);
        
        return {
            timestamp: Date.now(),
            data: {
                lessons: lessons,
                total: lessons.length,
            },
        };
    }

    @UseGuards(RolesGuard)
    @Get('/recommend')
    async getRecommend(
        @Query() query: QueryByAccountIdDTO,
    ) {
        const recommendLessons = await this.lessonService.getRecommend(query.account_id);
        const recommendLessonsResponse = recommendLessons.map(lesson => {
            return {
                id: lesson.id,
                name: lesson.name,
                visible: lesson.visible,
                category: (lesson.category instanceof Category) ? lesson.category.id : lesson.category,
            }
        });

        return {
            timestamp: Date.now(),
            data: {
                lessons: recommendLessonsResponse,
                total: recommendLessonsResponse.length,
            }
        }
    }

    @UseGuards(RolesAccountGuard)
    @Get('/:id')
    async getOne (
        @Param() param: QueryByIdDTO,
    ) {
        const lesson = await this.lessonService.getOne(param.id);

        if (lesson == null) {
            throw new HttpException("Lesson not found", HttpStatus.NOT_FOUND);
        }

        const cardsResponse = lesson.cards.map((card) => {
            return {
                id: card.id,
                type: card.type,
                audio_url: card.audioUrl,
                content: card.content,
                translation: card.translation,
                items: card.items,
            }
        });

        const lessonResponse = {
            id: lesson.id,
            name: lesson.name,
            visible: lesson.visible,
            category: lesson.category,
            test: lesson.linkedTest,
            cards: {
                value: cardsResponse,
                total: cardsResponse.length,
            },
        };

        return {
            timestamp: Date.now(),
            data: {
                lesson: lessonResponse,
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

        const lessonProgresses = limit == 0 ? [] : await this.lessonService.getProgressAll(accountId, limit, offset);

        const lessonProgressesResponse = lessonProgresses.map(item => {
            return {
                lesson: item.lesson,
                progress: {
                    value: item.progress,
                    last_date: item.date.valueOf(),
                }
            };
        });
        
        return {
            timestamp: Date.now(),
            data: {
                progresses: lessonProgressesResponse,
                total: lessonProgressesResponse.length,
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

        if (!(await this.lessonService.isLessonExisted(id))) {
            throw new HttpException("Lesson not found", HttpStatus.NOT_FOUND);
        }

        let lessonProgress = await this.lessonService.getProgress(id, accountId);

        if (lessonProgress == null) {
            return {
                timestamp: Date.now(),
                data: {
                    lesson: id,
                    progress: {
                        value: 0,
                        last_date: 0,
                    }
                }
            }
        }
        
        return {
            timestamp: Date.now(),
            data: {
                lesson: lessonProgress.lesson,
                progress: {
                    value: lessonProgress.progress,
                    last_date: lessonProgress.date.valueOf(),
                }
            },
        };
    }

    @UseGuards(RolesAccountGuard)
    @Post('/:id/progress')
    async setProgress(
        @Param() param: QueryByIdDTO,
        @Body() body: SetLessonProgressDTO,
    ) {
        if (!(await this.lessonService.isLessonExisted(param.id))) {
            throw new HttpException("Lesson not found", HttpStatus.NOT_FOUND);
        }

        await this.lessonService.setProgress(param.id, body.account_id, body.value);
        return {
            timestamp: Date.now(),
            status: "SUCCESS",
        }
    }
}
