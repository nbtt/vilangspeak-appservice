import { Controller, Get, Query } from '@nestjs/common';
import { GetAllByIdDTO } from 'src/dto/get-all-by-id.dto';
import { GetAllDTO } from 'src/dto/get-all.dto';
import { LessonService } from './lesson.service';

@Controller('/app/lesson')
export class LessonController {
    constructor(private lessonService: LessonService) {}

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
}
