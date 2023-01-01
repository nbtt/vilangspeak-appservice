import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { LessonLog } from 'src/entity/lesson-log.entity';
import { Lesson } from 'src/entity/lesson.entity';
import { Repository } from 'typeorm';

@Injectable()
export class LessonService {
    constructor(
        @InjectRepository(Lesson)
        private lessonRepository: Repository<Lesson>,
        
        @InjectRepository(LessonLog)
        private lessonLogRespository: Repository<LessonLog>,
    ) {}

    getAll(limit: number = 10, offset: number = 0): Promise<Lesson[]> {
        return this.lessonRepository.find({
            take: limit,
            skip: offset,
            loadRelationIds: {
                 relations: ['category'],
            },
        });
    }

    getProgressAll(accountId: number, limit: number = 10, offset: number = 0): Promise<LessonLog[]> {
        return this.lessonLogRespository.find({
            take: limit,
            skip: offset,
            where: {
                account: {
                    id: accountId,
                },
            },
            loadRelationIds: {
                relations: ['lesson'],
            },
            relations: {
                account: false,
            }
        })
    }

    getProgress(id: number, accountId: number) {
        return this.lessonLogRespository.findOne({
            where: {
                account: {
                    id: accountId,
                },
                lesson: {
                    id: id,
                }
            },
            loadRelationIds: {
                relations: ['lesson'],
            },
            relations: {
                account: false,
            }
        })
    }

    async isLessonExisted(id: number): Promise<Boolean> {
        const lesson = await this.lessonRepository.findOne({
            where: {
                id: id,
            },
            select: {
                id: true,
            }
        });

        return lesson != null;
    }
}
