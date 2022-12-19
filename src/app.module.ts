import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { Category } from './entity/category.entity';
import { Lesson } from './entity/lesson.entity';
import { LessonModule } from './lesson/lesson.module';
import { CategoryModule } from './category/category.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: '127.0.0.1',
      port: 3306,
      username: 'vilangspeak-user',
      password: 'GiLJko1Tf2GfJrJl',
      database: 'vilangspeak_db',
      autoLoadEntities: true,
      synchronize: true,
    }),
    LessonModule,
    CategoryModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
