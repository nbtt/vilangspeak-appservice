import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { LessonLog } from 'src/entity/lesson-log.entity';
import { Lesson } from 'src/entity/lesson.entity';
import { LessonController } from './lesson.controller';
import { LessonService } from './lesson.service';

@Module({
    imports: [TypeOrmModule.forFeature([Lesson, LessonLog])],
    controllers: [LessonController],
    providers: [LessonService],
})
export class LessonModule {}
