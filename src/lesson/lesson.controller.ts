import { Controller, Get, Req } from '@nestjs/common';
import { Request } from 'express';
import { LessonService } from './lesson.service';

@Controller('/app/lesson')
export class LessonController {
    constructor(private lessonService: LessonService) {}

    @Get('/all')
    async getAll(@Req() req: Request) {
        const lessons = await this.lessonService.getAll(parseInt(req.query['limit'] as string), parseInt(req.query['offset'] as string));
        return {
            timestamp: Date.now(),
            data: {
                lessons: lessons,
                total: lessons.length,
            },
        };
    }
}
