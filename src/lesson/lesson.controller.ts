import { Controller, Get, Query, Req, ValidationPipe } from '@nestjs/common';
import { Request } from 'express';
import { GetAllDTO } from 'src/dto/get-all.dto';
import { LessonService } from './lesson.service';

@Controller('/app/lesson')
export class LessonController {
    constructor(private lessonService: LessonService) {}

    @Get('/all')
    async getAll(
        @Query(new ValidationPipe({
            transform: true,
            transformOptions: { enableImplicitConversion: true, },
            forbidNonWhitelisted: true,
        })) query: GetAllDTO
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
}
