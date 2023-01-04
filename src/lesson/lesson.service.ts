import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { LessonLog } from 'src/entity/lesson-log.entity';
import { Lesson } from 'src/entity/lesson.entity';
import { LessThan, MoreThan, QueryFailedError, Repository } from 'typeorm';

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

    getOne(id: number) {
        return this.lessonRepository.findOne({
            where: {
                id: id,
            },
            loadRelationIds: {
                relations: ['linkedTest'],
            },
            relations: {
                cards: {
                    items: true,
                },
                category: true,
            }
        })
    }

    async getRecommend(accountId: number) {
        const lastViewLessonLog = await this.lessonLogRespository.findOne({
            where: {
                account: {
                    id: accountId,
                }
            },
            relations: {
                lesson: {
                    category: true,
                },
                account: false,
            },
            order: {
                date: 'DESC',
            }
        });

        if (lastViewLessonLog == null) {
            // not complete any lesson, return first 2 lessons
            return this.lessonRepository.find({
                take: 2,
                relations: {
                    category: true,
                },
                order: {
                    id: 'ASC',
                }
            }).then(lessons => lessons.map(lesson => this.createEmptyLessonLog(lesson)));
        }

        // try to get next lesson or previous lesson (if next lesson not found)
        const nextLesson = await this.lessonRepository.findOne({
            where: {
                id: MoreThan(lastViewLessonLog.lesson.id),
            },
            order: {
                id: 'ASC',
            },
        });

        const previousLesson = (nextLesson == null) ? (await this.lessonRepository.findOne({
                where: {
                    id: LessThan(lastViewLessonLog.lesson.id),
                },
                order: {
                    id: 'DESC',
                }
            }))
            : null;
            
        const secondRecommendLesson = nextLesson || previousLesson;
        if (secondRecommendLesson == null) {
            // Last view lesson is the only lesson exists
            return [lastViewLessonLog];
        }

        // try to get progress of second recommended lesson
        let secondRecommendLessonLog = await this.lessonLogRespository.findOne({
            where: {
                account: {
                    id: accountId,
                },
                lesson: {
                    id: secondRecommendLesson.id,
                }
            },
            relations: {
                lesson: {
                    category: true,
                },
                account: false,
            },
        });
        
        if (secondRecommendLessonLog == null) {
            // no progress found, make default lesson log
            secondRecommendLessonLog = this.createEmptyLessonLog(secondRecommendLesson);
        }
        
        return [lastViewLessonLog, secondRecommendLessonLog];
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

    async setProgress(id: number, accountId: number, progress: number) {
        let lessonLog = await this.getProgress(id, accountId);
        if (lessonLog == null) {
            await this.lessonLogRespository.insert({
                date: new Date(),
                progress: progress,
                account: {
                    id: accountId,
                },
                lesson: {
                    id: id,
                }
            }).catch(error => {
                if (error instanceof QueryFailedError) {
                    throw new HttpException("Not found account or lesson", HttpStatus.NOT_FOUND);
                }
            });
        }
        else {
            await this.lessonLogRespository.update({
                account: {
                    id: accountId,
                },
                lesson: {
                    id: id,
                }
            }, {
                date: new Date(),
                progress: progress,
            }).catch(error => {
                if (error instanceof QueryFailedError) {
                    throw new HttpException("Not found account or lesson", HttpStatus.NOT_FOUND);
                }
            });
        }
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

    createEmptyLessonLog(lesson: Lesson): LessonLog {
        return {
            lesson: lesson,
            account: null,
            id: null,
            date: null,
            progress: null,
        }
    }
}
