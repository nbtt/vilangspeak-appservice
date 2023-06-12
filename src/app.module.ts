import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import configuration from './config/configuration';
import { LessonModule } from './lesson/lesson.module';
import { CategoryModule } from './category/category.module';
import { TestModule } from './test/test.module';
import { AccountModule } from './account/account.module';
import { entities } from './entity/entities';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
import { AuthModule } from './auth/auth.module';
import { PrometheusModule, makeHistogramProvider, makeSummaryProvider } from '@willsoto/nestjs-prometheus';
import { DurationMiddleWare } from './middleware/duration.middleware';
import { WinstonModule } from 'nest-winston';
import * as winston from 'winston';
import { randomBytes } from 'crypto';

@Module({
  imports: [
    WinstonModule.forRoot({
      format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.json(),
      ),
      defaultMeta: { instance: randomBytes(4).toString('hex') },
      transports: [
        new winston.transports.Console(),
        new winston.transports.File({ filename: join(__dirname, '..', 'log', 'info.log'), level: 'info' }),
      ],
    }),
    ConfigModule.forRoot({
      load: [configuration],
      isGlobal: true,
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: configService.get<string>('db.host'),
        port: +configService.get<number>('db.port'),
        username: configService.get<string>('db.username'),
        password: configService.get<string>('db.password'),
        database: configService.get<string>('db.database'),
        entities: entities,
        synchronize: true,
      }),
      inject: [ConfigService],
    }),
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'public'),
      serveRoot: '/public',
    }),
    PrometheusModule.register(),
    LessonModule,
    CategoryModule,
    TestModule,
    AccountModule,
    AuthModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    makeHistogramProvider({
      name: 'app_request_duration_seconds',
      help: 'Duration of HTTP requests in seconds',
      labelNames: ['service', 'method', 'path', 'status'],
      buckets: [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10],
      // buckets: [0.001, 0.005, 0.01, 0.05, 0.1, 0.5, 1],
    })
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(DurationMiddleWare).forRoutes('*');
  }
}
