import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TestLog } from 'src/entity/test-log.entity';
import { Testx } from 'src/entity/testx.entity';
import { LessThan, MoreThan, QueryFailedError, Repository } from 'typeorm';

@Injectable()
export class TestxService {
    constructor(
        @InjectRepository(Testx)
        private testxRepository: Repository<Testx>,
        @InjectRepository(TestLog)
        private testLogRespository: Repository<TestLog>,
    ) {}

    getAll(limit: number = 10, offset: number = 0): Promise<Testx[]> {
        return this.testxRepository.find({
            take: limit,
            skip: offset,
            loadRelationIds: {
                 relations: ['category'],
            },
        });
    }

    async getRecommend(accountId: number) {
        const lastViewTestLog = await this.testLogRespository.findOne({
            where: {
                account: {
                    id: accountId,
                }
            },
            relations: {
                test: {
                    category: true,
                },
                account: false,
            },
            order: {
                date: 'DESC',
            }
        });

        if (lastViewTestLog == null) {
            // not complete any test, return first 2 tests
            return this.testxRepository.find({
                take: 2,
                loadRelationIds: {
                    relations: ['category'],
                },
                order: {
                    id: 'ASC',
                }
            });
        }

        // first recommend test
        const firstRecommendTest = lastViewTestLog.test;

        // try to get next lesson or previous lesson (if next lesson not found)
        const nextTest = await this.testxRepository.findOne({
            where: {
                id: MoreThan(lastViewTestLog.test.id),
            },
            loadRelationIds: {
                relations: ['category'],
            },
            order: {
                id: 'ASC',
            },
        });

        const previousTest = (nextTest == null) ? (await this.testxRepository.findOne({
                where: {
                    id: LessThan(lastViewTestLog.test.id),
                },
                loadRelationIds: {
                    relations: ['category'],
                },
                order: {
                    id: 'DESC',
                }
            }))
            : null;
            
        const secondRecommendTest = nextTest || previousTest;
        if (secondRecommendTest == null) {
            // Last view test is the only test exists
            return [firstRecommendTest];
        }
        
        return [firstRecommendTest, secondRecommendTest];
    }

    getOne(id: number) {
        return this.testxRepository.findOne({
            where: {
                id: id,
            },
            relations: {
                questions: {
                    items: true,
                },
                category: true,
            }
        })
    }

    getProgressAll(accountId: number, limit: number = 10, offset: number = 0): Promise<TestLog[]> {
        return this.testLogRespository.find({
            take: limit,
            skip: offset,
            where: {
                account: {
                    id: accountId,
                },
            },
            loadRelationIds: {
                relations: ['test'],
            },
            relations: {
                account: false,
            }
        })
    }

    getProgress(id: number, accountId: number) {
        return this.testLogRespository.findOne({
            where: {
                account: {
                    id: accountId,
                },
                test: {
                    id: id,
                }
            },
            loadRelationIds: {
                relations: ['test'],
            },
            relations: {
                account: false,
            }
        })
    }

    async setProgress(id: number, accountId: number, score: number) {
        let testLog = await this.getProgress(id, accountId);
        if (testLog == null) {
            await this.testLogRespository.insert({
                date: new Date(),
                scoreSum: score,
                scoreHighest: score,
                scoreLowest: score,
                times: 1,
                account: {
                    id: accountId,
                },
                test: {
                    id: id,
                }
            }).catch(error => {
                if (error instanceof QueryFailedError) {
                    throw new HttpException("Not found account or test", HttpStatus.NOT_FOUND);
                }
            });
        }
        else {
            let updateFields: {[k: string]: any} = {
                date: new Date(),
                times: testLog.times + 1,
                scoreSum: testLog.scoreSum + score,
            }
            if (score > testLog.scoreHighest) {
                updateFields.scoreHighest = score;
            }
            if (score < testLog.scoreLowest) {
                updateFields.scoreLowest = score;
            }

            await this.testLogRespository.update({
                account: {
                    id: accountId,
                },
                test: {
                    id: id,
                }
            }, updateFields).catch(error => {
                if (error instanceof QueryFailedError) {
                    throw new HttpException("Not found account or test", HttpStatus.NOT_FOUND);
                }
            });
        }
    }

    async isTestExisted(id: number): Promise<Boolean> {
        const test = await this.testxRepository.findOne({
            where: {
                id: id,
            },
            select: {
                id: true,
            }
        });

        return test != null;
    }
}
