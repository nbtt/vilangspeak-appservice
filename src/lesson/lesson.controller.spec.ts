import { Test, TestingModule } from '@nestjs/testing';
import { LessonController } from './lesson.controller';
import { getSuccessResponse } from 'src/common/util';
import { HttpException, HttpStatus } from '@nestjs/common';
import { LessonService } from './lesson.service';
import { CardType } from 'src/entity/card.entity';
import { CardItemType } from 'src/entity/card-item.entity';

describe('LessonController', () => {
  let controller: LessonController;
  const lessons = [{
    id: 1,
    name: 'test',
    visible: false,
    category: 1,
    linkedTest: 1,
    cards: [{
      id: 1,
      type: CardType.WORD,
      audioUrl: '/public/audio/test.wav',
      content: 'test content',
      translation: 'test translation',
      lesson: 1,
      items: [{
        id: 1,
        type: CardItemType.HEADER,
        order: 0,
        content: 'Examples',
        card: 1,
      }, {
        id: 2,
        type: CardItemType.PARAGRAPH,
        order: 1,
        content: 'test',
        card: 1,
      }],
    }],
  }, {
    id: 2,
    name: 'test2',
    visible: true,
    category: 2,
    linkedTest: 2,
    cards: [{
      id: 2,
      type: CardType.WORD,
      audioUrl: '/public/audio/test2.wav',
      content: 'test2 content',
      translation: 'test2 translation',
      lesson: 2,
      items: [{
        id: 3,
        type: CardItemType.HEADER,
        order: 0,
        content: 'Examples',
        card: 2,
      }, {
        id: 4,
        type: CardItemType.PARAGRAPH,
        order: 1,
        content: 'test2',
        card: 2,
      }],
    }],
  }, {
    id: 3,
    name: 'test',
    visible: true,
    category: 1,
    linkedTest: 3,
    cards: [{
      id: 3,
      type: CardType.WORD,
      audioUrl: '/public/audio/test3.wav',
      content: 'test3 content',
      translation: 'test3 translation',
      lesson: 3,
      items: [{
        id: 5,
        type: CardItemType.HEADER,
        order: 0,
        content: 'Examples',
        card: 3,
      }, {
        id: 6,
        type: CardItemType.PARAGRAPH,
        order: 1,
        content: 'test3',
        card: 3,
      }],
    }, {
      id: 4,
      type: CardType.SENTENCE,
      audioUrl: '/public/audioo/test3s.wav',
      content: 'test3s content',
      translation: 'test3s translation',
      lesson: 3,
      items: [{
        id: 7,
        type: CardItemType.PARAGRAPH,
        order: 1,
        content: 'test3s',
        card: 4,
      }],
    }],
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
  const getGeneralLessonInfo = (lesson) => {
    return {            
      id: lesson.id,
      name: lesson.name,
      visible: lesson.visible,
      category: lesson.category,
    }
  };
  const getLessonInfo = (lesson) => {
    return {
      ...getGeneralLessonInfo(lesson),
      test: lesson.linkedTest,
      cards: {
        value: lesson.cards.map((card) => {
          return {
            id: card.id,
            type: card.type,
            audio_url: card.audioUrl,
            content: card.content,
            translation: card.translation,
            items: card.items,
          }
        }),
        total: lesson.cards.length,
      },
    }
  };


  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [LessonController],
      providers: [{ provide: LessonService, useValue: {
        getAll: jest.fn().mockImplementation((limit, offset) => {
          return lessons.slice(offset, offset + limit).map(getGeneralLessonInfo);
        }),
        getRecommend: jest.fn().mockImplementation((accountId) => {
          return lessons.slice(0, 2).map(getGeneralLessonInfo);
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
        lessons: lessons.map(getGeneralLessonInfo),
        total: lessons.length,
      }
    });
  });

  it('should return all lessons with limit and offset', async () => {
    const result = await controller.getAll({ limit: 2, offset: 1 });
    const expectedLessons = lessons.slice(1, 3);
    expect(result).toEqual({
      timestamp: expect.any(Number),
      data: {
        lessons: expectedLessons.map(getGeneralLessonInfo),
        total: expectedLessons.length,
      }
    });
  });

  it('should return recommended lessons', async () => {
    const result = await controller.getRecommend({ account_id: 1 });
    const expectedLessons = lessons.slice(0, 2);
    expect(result).toEqual({
      timestamp: expect.any(Number),
      data: {
        lessons: expectedLessons.map(getGeneralLessonInfo),
        total: expectedLessons.length,
      }
    });
  });

  it('should return a lesson with id', async () => {
    const result = await controller.getOne({ id: 3 });
    expect(result).toEqual({
      timestamp: expect.any(Number),
      data: {
        lesson: getLessonInfo(lessons[2]),
      }
    });
  });

  it('should return an error with lesson not found', async () => {
    const result = controller.getOne({ id: 4 });
    await expect(result).rejects.toThrowError(new HttpException("Lesson not found", HttpStatus.NOT_FOUND));
  });

  it('should return all lessons progress with account_id, limit and offset', async () => {
    const result = await controller.getProgressAll({ account_id: 1, limit: 1, offset: 1 });
    const expectedLessonProgress = lessonsProgress.slice(1, 2);
    expect(result).toEqual({
      timestamp: expect.any(Number),
      data: {
        progresses: expectedLessonProgress.map((lessonProgress) => {
          return {
            lesson: lessonProgress.lesson,
            progress: {
              value: lessonProgress.progress,
              last_date: lessonProgress.date.valueOf(),
            }
          }
        }),
        total: expectedLessonProgress.length,
      },
    });
  });

  it('should return a lesson progress with id and account_id', async () => {
    const result = await controller.getProgress({ id: 1 }, { account_id: 1 });
    expect(result).toEqual({
      timestamp: expect.any(Number),
      data: {
        lesson: 1,
        progress: {
          value: lessonsProgress[0].progress,
          last_date: lessonsProgress[0].date.valueOf(),
        }
      },
    });
  });

  it('should return an empty progress with lesson progress not found', async () => {
    const result = await controller.getProgress({ id: 3 }, { account_id: 1 });
    expect(result).toEqual({
      timestamp: expect.any(Number),
      data: {
        lesson: 3,
        progress: {
          value: 0,
          last_date: 0,
        }
      },
    });
  });

  it('should set a lesson progress with id, account_id and value', async () => {
    const result = await controller.setProgress({ id: 1 }, { timestamp: (new Date()).getTime(), account_id: 1, value: 70 });
    expect(result).toEqual(getSuccessResponse());
    expect(lessonsProgress[0].progress).toEqual(70);
  });

  it('should return an error when setting progress with lesson not found', async () => {
    const result = controller.setProgress({ id: 3 }, { timestamp: (new Date()).getTime(), account_id: 1, value: 70 });
    expect(result).rejects.toThrowError(new HttpException("Not found account or lesson", HttpStatus.NOT_FOUND));
  });
});
