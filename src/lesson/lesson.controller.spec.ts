import { Test, TestingModule } from '@nestjs/testing';
import { LessonController } from './lesson.controller';
import { getSuccessResponse } from 'src/common/util';
import { HttpException, HttpStatus } from '@nestjs/common';
import { LessonService } from './lesson.service';

describe('LessonController', () => {
  let controller: LessonController;
  const lessons = [{
    id: 1,
    name: 'test',
    visible: false,
    category: 1,
  }, {
    id: 2,
    name: 'test2',
    visible: true,
    category: 2,
  }, {
    id: 3,
    name: 'test',
    visible: true,
    category: 1,
  }];
  const lessonsProgress = [{
    id: 1,
    lesson: 1,
    account: 1,
    date: new Date(2023, 1, 1, 1, 1, 1),
    progress: 50,
  }, {
    id: 2,
    lesson: 2,
    account: 1,
    date: new Date(),
    progress: 100,
  }];


  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [LessonController],
      providers: [{ provide: LessonService, useValue: {
        getAll: jest.fn().mockImplementation((limit, offset) => {
          return lessons.slice(offset, offset + limit);
        }),
        getRecommend: jest.fn().mockImplementation((accountId) => {
          return lessons.slice(0, 2);
        }),
        getOne: jest.fn().mockImplementation((id) => {
          return lessons.find((lesson) => lesson.id === id);
        }),
        getProgressAll: jest.fn().mockImplementation((accountId: number, limit: number = 10, offset: number = 0) => {
          return lessonsProgress.slice(offset, offset + limit)
        }),
        getProgress: jest.fn().mockImplementation((id: number, accountId: number) => {
          return lessonsProgress.find((lesson) => lesson.id === id && lesson.account === accountId);
        }),
        setProgress: jest.fn().mockImplementation((id: number, accountId: number, progress: number) => {
          const lessonProgress = lessonsProgress.find((lesson) => lesson.id === id && lesson.account === accountId);
          if (lessonProgress) {
            lessonProgress.progress = progress;
          }
          else {
            throw new HttpException("Not found account or lesson", HttpStatus.NOT_FOUND);
          }
          return lessonProgress;
        }),
        isLessonExisted: jest.fn().mockImplementation((id: number) => {
          return lessons.find((lesson) => lesson.id === id) != null;
        }),
      }}],
    }).compile();

    controller = module.get<LessonController>(LessonController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should return all lessons', async () => {
    const result = await controller.getAll({ limit: 10, offset: 0 });
    expect(result).toEqual({
      timestamp: expect.any(Number),
      data: {
        lessons: lessons,
        total: lessons.length,
      }
    });
  });

  it('should return all lessons with limit and offset', async () => {
    const result = await controller.getAll({ limit: 2, offset: 1 });
    const returnedLessons = lessons.slice(1, 3);
    expect(result).toEqual({
      timestamp: expect.any(Number),
      data: {
        lessons: returnedLessons,
        total: returnedLessons.length,
      }
    });
  });

  it('should return recommended lessons', async () => {
    const result = await controller.getRecommend({ account_id: 1 });
    const returnedLessons = lessons.slice(0, 2);
    expect(result).toEqual({
      timestamp: expect.any(Number),
      data: {
        lessons: returnedLessons,
        total: returnedLessons.length,
      }
    });
  });

  // it('should return a lesson with id', async () => {
  //   const result = await controller.getOne({ id: 1 });
  //   expect(result).toEqual({
  //     timestamp: expect.any(Number),
  //     data: lessons[0],
  //   });
  // });

  it('should return an error with lesson not found', async () => {
    const result = controller.getOne({ id: 4 });
    await expect(result).rejects.toThrowError(new HttpException("Lesson not found", HttpStatus.NOT_FOUND));
  });

  // it('should return all lessons progress with account_id, limit and offset', async () => {
  //   const result = await controller.getProgressAll({ account_id: 1, limit: 1, offset: 1 });
  //   expect(result).toEqual({
  //     timestamp: expect.any(Number),
  //     data: {
  //       progresses: [{
  //         lesson: 2,
  //         progress: {
  //           value: 1,
  //           last_date: lessonsProgress[1].date.valueOf(),
  //         }
  //       }],
  //       total: lessonsProgress.length,
  //     },
  //   });
  // });

  // it('should return a lesson progress with id and account_id', async () => {
  //   const result = await controller.getProgress({ id: 1 }, { account_id: 1 });
  //   expect(result).toEqual({
  //     timestamp: expect.any(Number),
  //     data: {
  //       lesson: 1,
  //       progress: {
  //         value: 1,
  //         last_date: lessonsProgress[0].date.valueOf(),
  //       }
  //     },
  //   });
  // });

  // it('should return an error with lesson progress not found', async () => {
  //   const result = await controller.getProgress({ id: 3 }, { account_id: 1 });
  //   expect(result).toEqual({
  //     timestamp: expect.any(Number),
  //     error: {
  //       code: 404,
  //       message: 'Lesson not found',
  //     },
  //   });
  // });

  // it('should set a lesson progress with id, account_id and value', async () => {
  //   const result = await controller.setProgress({ id: 1 }, { timestamp: (new Date()).getTime(), account_id: 1, value: 70 });
  //   expect(result).toEqual(getSuccessResponse());
  //   expect(lessonsProgress[0].progress).toEqual(70);
  // });

  // it('should return an error when setting progress with lesson not found', async () => {
  //   const result = await controller.setProgress({ id: 3 }, { timestamp: (new Date()).getTime(), account_id: 1, value: 70 });
  //   expect(result).toEqual({
  //     timestamp: expect.any(Number),
  //     error: {
  //       code: 404,
  //       message: 'Not found account or lesson',
  //     },
  //   });
  // });
});
