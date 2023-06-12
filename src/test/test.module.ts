import { Module } from '@nestjs/common';
import { TestService } from './test.service';
import { TestController } from './test.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Testx } from 'src/entity/testx.entity';
import { TestLog } from 'src/entity/test-log.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Testx, TestLog])],
  providers: [TestService],
  controllers: [TestController]
})
export class TestModule {}
