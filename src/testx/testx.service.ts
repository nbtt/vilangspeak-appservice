import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Testx } from 'src/entity/testx.entity';
import { Repository } from 'typeorm';

@Injectable()
export class TestxService {
    constructor(
        @InjectRepository(Testx)
        private lessonRepository: Repository<Testx>,
    ) {}

    getAll(limit: number = 10, offset: number = 0): Promise<Testx[]> {
        return this.lessonRepository.find({
            take: limit,
            skip: offset,
            loadRelationIds: {
                 relations: ['category'],
            },
        });
    }
}
