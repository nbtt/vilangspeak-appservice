import { Controller, Get, Query } from '@nestjs/common';
import { GetAllDTO } from 'src/dto/get-all.dto';
import { TestxService } from './testx.service';

@Controller('/app/test')
export class TestxController {
    constructor(private testxService: TestxService) {}

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
}
