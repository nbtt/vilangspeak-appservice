import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule, ConfigService } from '@nestjs/config';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import configuration from './config/configuration';
import { LessonModule } from './lesson/lesson.module';
import { CategoryModule } from './category/category.module';
import { TestxModule } from './testx/testx.module';
import { AccountModule } from './account/account.module';
import { entities } from './entity/entities';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
import { AuthModule } from './auth/auth.module';
import { PrometheusModule, makeSummaryProvider } from '@willsoto/nestjs-prometheus';
import { DurationMiddleWare } from './middleware/duration.middleware';

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
    TestxModule,
    AccountModule,
    AuthModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    makeSummaryProvider({
      name: 'app_request_duration_seconds',
      help: 'Duration of HTTP requests in seconds',
      labelNames: ['service', 'method', 'path', 'status'],
      percentiles: [0.5, 0.9, 0.99, 0.999, 1],
    })
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(DurationMiddleWare).forRoutes('*');
  }
}
