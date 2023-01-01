import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule, ConfigService } from '@nestjs/config';
import configuration from './config/configuration';

import { LessonModule } from './lesson/lesson.module';
import { CategoryModule } from './category/category.module';
import { TestxModule } from './testx/testx.module';
import { AccountModule } from './account/account.module';
import { Account } from './entity/account.entity';
import { Category } from './entity/category.entity';
import { Lesson } from './entity/lesson.entity';
import { Testx } from './entity/testx.entity';
import { Achievement } from './entity/achievement.entity';
import { AchievementLog } from './entity/achievement-log';

@Module({
  imports: [
    ConfigModule.forRoot({
      load: [configuration],
      isGlobal: true,
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: configService.get('db.host'),
        port: +configService.get('db.port'),
        username: configService.get('db.username'),
        password: configService.get('db.password'),
        database: configService.get('db.database'),
        entities: [Account, Category, Lesson, Testx, Achievement, AchievementLog],
        synchronize: true,
      }),
      inject: [ConfigService],
    }),
    LessonModule,
    CategoryModule,
    TestxModule,
    AccountModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
