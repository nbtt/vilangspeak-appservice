import { Module } from '@nestjs/common';
import { TestxService } from './testx.service';
import { TestxController } from './testx.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Testx } from 'src/entity/testx.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Testx])],
  providers: [TestxService],
  controllers: [TestxController]
})
export class TestxModule {}
