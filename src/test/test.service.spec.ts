import { Test, TestingModule } from '@nestjs/testing';
import { TestService } from './test.service';
import { QuestionType } from 'src/entity/question.entity';
import { CardItemType } from 'src/entity/card-item.entity';

const tests = [{
  id: 1,
  name: 'test',
  visible: true,
  category: 1,
  questions: [{
    id: 1,
    question_type: QuestionType.SINGLE_CHOICE,
    type: CardItemType.PARAGRAPH,
    description: 'test description',
    content: 'test content',
    test: 1,
    items: [{
      id: 1,
      type: CardItemType.PARAGRAPH,
      order: 0,
      content: 'test 1',
      question: 1,
    }, {
      id: 2,
      type: CardItemType.IMAGE,
      order: 1,
      content: 'test 2',
      question: 1,
    }, {
      id: 3,
      type: CardItemType.AUDIO,
      order: 2,
      content: 'test 3',
      question: 1,
    }, {
      id: 4,
      type: CardItemType.PARAGRAPH,
      order: 3,
      content: 'test 4',
      question: 1,
    }],
  }, {
    id: 2,
    question_type: QuestionType.MULTIPLE_CHOICE,
    type: CardItemType.PARAGRAPH,
    description: 'test description 2',
    content: 'test content 2',
    test: 1,
    items: [{
      id: 5,
      type: CardItemType.PARAGRAPH,
      order: 0,
      content: 'test 5',
      question: 2,
    }, {
      id: 6,
      type: CardItemType.PARAGRAPH,
      order: 0,
      content: 'test 6',
      question: 2,
    }, {
      id: 7,
      type: CardItemType.PARAGRAPH,
      order: 0,
      content: 'test 7',
      question: 2,
    }, {
      id: 8,
      type: CardItemType.PARAGRAPH,
      order: 0,
      content: 'test 8',
      question: 2,
    }],
  }],
}, {
  id: 2,
  name: 'test2',
  visible: true,
  category: 2,
  questions: [],
}, {
  id: 3,
  name: 'test3',
  visible: true,
  category: 3,
  questions: [],
}];
const testsProgress = [{
  id: 1,
  test: 1,
  account: 1,
  date: new Date(2023, 1, 1, 1, 1, 1),
  times: 2,
  scoreHighest: 100,
  scoreLowest: 50,
  scoreSum: 150,
  getScoreAverage: () => 75,
}, {
  id: 2,
  test: 2,
  account: 1,
  date: new Date(),
  times: 1,
  scoreHighest: 70,
  scoreLowest: 70,
  scoreSum: 70,
  getScoreAverage: () => 70,
}];

describe('TestService', () => {
  let service: TestService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        TestService,
        {
          provide: 'TestxRepository',
          useValue: {
            find: jest.fn().mockImplementation((filter: { take?: number, skip?: number, loadRelationIds?: any }) => {
              return tests.slice(filter.skip, filter.skip + filter.take);
            }),
            findOne: jest.fn().mockImplementation((filter: { where: { id: number }, relations: any}) => {
              return tests.find(test => test.id == filter.where.id);
            }),
          },            
        },
        {
          provide: 'TestLogRepository',
          useValue: {
            find: jest.fn().mockImplementation((filter: { take?: number, skip?: number, where?: { account: { id: number } }, loadRelationIds?: any, relations?: any }) => {
              return testsProgress.filter(test => test.account == filter.where.account.id).slice(filter.skip, filter.skip + filter.take);
            }),
            findOne: jest.fn().mockImplementation((filter: { where: { account: { id: number }, test: { id: number } }, relations: any}) => {
              return testsProgress.find(test => test.account == filter.where.account.id && test.test == filter.where.test.id);
            }),
          },
        }
      ],
    }).compile();

    service = module.get<TestService>(TestService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should get all tests', async () => {
    const result = await service.getAll();
    expect(result).toEqual(tests);
  });

  it('should get all tests by limit and offset', async () => {
    const result = await service.getAll(1, 1);
    expect(result).toEqual(tests.slice(1, 2));
  });

  it('should get test by id', async () => {
    const result = await service.getOne(2);
    expect(result).toEqual(tests[1]);
  });

  it('should get tests progress by account id', async () => {
    const result = await service.getProgressAll(1);
    expect(result).toEqual(testsProgress);
  });

  it('should get tests progress by account id with limit and offset', async () => {
    const result = await service.getProgressAll(1, 1, 1);
    expect(result).toEqual(testsProgress.slice(1, 2));
  });

  it('should get test progress by account id and test id', async () => {
    const result = await service.getProgress(2, 1);
    expect(result).toEqual(testsProgress[1]);
  });
});
