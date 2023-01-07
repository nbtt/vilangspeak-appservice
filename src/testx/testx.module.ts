import { Module } from '@nestjs/common';
import { TestxService } from './testx.service';
import { TestxController } from './testx.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Testx } from 'src/entity/testx.entity';
import { TestLog } from 'src/entity/test-log.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Testx, TestLog])],
  providers: [TestxService],
  controllers: [TestxController]
})
export class TestxModule {}
