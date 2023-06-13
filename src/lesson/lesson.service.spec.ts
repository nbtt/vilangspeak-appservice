import { Test, TestingModule } from '@nestjs/testing';
import { LessonService } from './lesson.service';
import { CardType } from 'src/entity/card.entity';
import { CardItemType } from 'src/entity/card-item.entity';


const lessons = [{
  id: 1,
  name: 'test',
  visible: true,
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
  }, {
    id: 5,
    name: 'test',
    visible: true,
    category: 1,
    linkedTest: 3,
    cards: [],
  }, {
    id: 6,
    name: 'test',
    visible: true,
    category: 1,
    linkedTest: 3,
    cards: [],
  }, {
    id: 7,
    name: 'test',
    visible: true,
    category: 1,
    linkedTest: 3,
    cards: [],
  }, {
    id: 8,
    name: 'test',
    visible: true,
    category: 1,
    linkedTest: 3,
    cards: [],
  }, {
    id: 9,
    name: 'test',
    visible: true,
    category: 1,
    linkedTest: 3,
    cards: [],
  }, {
    id: 10,
    name: 'test',
    visible: true,
    category: 1,
    linkedTest: 3,
    cards: [],
  }, {
    id: 11,
    name: 'test',
    visible: true,
    category: 1,
    linkedTest: 3,
    cards: [],
  }, {
    id: 12,
    name: 'test',
    visible: true,
    category: 1,
    linkedTest: 3,
    cards: [],
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

describe('LessonService', () => {
  let service: LessonService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        LessonService,
        {
          provide: 'LessonRepository',
          useValue: {
            find: jest.fn().mockImplementation((filter: { take?: number, skip?: number, loadRelationIds?: any }) => {
              return lessons.slice(filter.skip, filter.skip + filter.take);
            }),
            findOne: jest.fn().mockImplementation((filter: { where: { id: number }, loadRelationIds?: any, relations?: any }) => {
              return lessons.find(lesson => lesson.id === filter.where.id);
            }),
          },
        },
        {
          provide: 'LessonLogRepository',
          useValue: {
            find: jest.fn().mockImplementation((filter: { where: { account: { id: number } }, loadRelationIds?: any, relations?: any }) => {
              return lessonsProgress.filter(lesson => lesson.account === filter.where.account.id );
            }),
            findOne: jest.fn().mockImplementation((filter: { where: { account: { id: number }, lesson: { id: number } }, loadRelationIds?: any, relations?: any }) => {
              return lessonsProgress.find(lesson => lesson.id === filter.where.lesson.id && lesson.account === filter.where.account.id);
            }),
          },
        }
      ],
    }).compile();

    service = module.get<LessonService>(LessonService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should return lessons', async () => {
    const result = await service.getAll();
    expect(result).toEqual(lessons.slice(0, 10));
  });

  it('should return lessons with limit and offset', async () => {
    const result = await service.getAll(1, 1);
    expect(result).toEqual(lessons.slice(1, 2));
  });

  it('should return lesson by id', async () => {
    const result = await service.getOne(2);
    expect(result).toEqual(lessons[1]);
  });

  it('should return all lessons progress', async () => {
    const result = await service.getProgressAll(1);
    expect(result).toEqual(lessonsProgress);
  });

  it('should return lesson progress', async () => {
    const result = await service.getProgress(2, 1);
    expect(result).toEqual(lessonsProgress[1]);
  });
});
