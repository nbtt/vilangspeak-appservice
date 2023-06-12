import { Test, TestingModule } from '@nestjs/testing';
import { TestController } from './test.controller';
import { QuestionType } from 'src/entity/question.entity';
import { CardItemType } from 'src/entity/card-item.entity';
import { TestService } from './test.service';

describe('TestController', () => {
  let controller: TestController;
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
  const getGeneralTestInfo = (test) => {
    return {
      id: test.id,
      name: test.name,
      visible: test.visible,
      category: test.category,
    };
  };
  const getTestInfo = (test) => {
    return {
      id: test.id,
      name: test.name,
      visible: test.visible,
      category: test.category,
      questions: {
        value: test.questions.map(question => {
          return {
            id: question.id,
            question_type: question.question_type,
            type: question.type,
            description: question.description,
            content: question.content,
            items: question.items,
          };
        }),
        total: test.questions.length,
      }
    };
  };
  const getTestProgressInfo = (progress) => {
    return {
        test: progress.test,
        progress: {
            score: progress.scoreHighest,
            times: progress.times,
            last_date: progress.date.valueOf(),
        }
    };
}
  let counter = testsProgress.length;
  const getNewId = () => {
    return ++counter;
  };


  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [TestController],
      providers: [{
        provide: TestService,
        useValue: {
          getAll: jest.fn().mockImplementation((limit, offset) => {
            return tests.slice(offset, offset + limit).map(getGeneralTestInfo);
          }),
          getRecommend: jest.fn().mockImplementation((accountId) => {
            return tests.slice(0, 2).map(getGeneralTestInfo);
          }),
          getOne: jest.fn().mockImplementation((id) => {
            return tests.find(test => test.id == id);
          }),
          getProgressAll: jest.fn().mockImplementation((accountId, limit, offset) => {
            return testsProgress.slice(offset, offset + limit);
          }),
          getProgress: jest.fn().mockImplementation((id, accountId) => {
            return testsProgress.find(progress => progress.id == id && progress.account == accountId);
          }),
          setProgress: jest.fn().mockImplementation((id, accountId, score) => {
            const testProgress = testsProgress.find(progress => progress.id == id && progress.account == accountId);
            if (testProgress) {
              testProgress.date = new Date();
              testProgress.scoreHighest = Math.max(testProgress.scoreHighest, score);
              testProgress.scoreLowest = Math.min(testProgress.scoreLowest, score);
              testProgress.scoreSum += score;
              testProgress.times++;
              testProgress.getScoreAverage = () => testProgress.scoreSum / testProgress.times;
            } else {
              testsProgress.push({
                id: getNewId(),
                test: id,
                account: accountId,
                date: new Date(),
                times: 1,
                scoreHighest: score,
                scoreLowest: score,
                scoreSum: score,
                getScoreAverage: () => score,
              });
            }
          }),
          isTestExisted: jest.fn().mockImplementation((id) => {
            return tests.find(test => test.id == id) != undefined;
          }),
        },
      }],
    }).compile();

    controller = module.get<TestController>(TestController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should get all tests', async () => {
    const actualTests = await controller.getAll({ limit: null, offset: null });
    expect(actualTests).toEqual({
      timestamp: expect.any(Number),
      data: {
        tests: tests.map(getGeneralTestInfo),
        total: tests.length,
      }
    });
  });

  it('should get all tests with limit and offset', async () => {
    const actualTests = await controller.getAll({ limit: 2, offset: 1 });
    const expectedTests = tests.slice(1, 3).map(getGeneralTestInfo);
    expect(actualTests).toEqual({
      timestamp: expect.any(Number),
      data: {
        tests: expectedTests,
        total: expectedTests.length,
      }
    });
  });

  it('should get recommended tests', async () => {
    const actualTests = await controller.getRecommend({ account_id: 1 });
    const expectedTests = tests.slice(0, 2).map(getGeneralTestInfo);
    expect(actualTests).toEqual({
      timestamp: expect.any(Number),
      data: {
        tests: expectedTests,
        total: expectedTests.length,
      }
    });
  });

  it('should get one test with id', async () => {
    const actualTest = await controller.getOne({ id: 1 });
    const expectedTest = getTestInfo(tests[0]);
    expect(actualTest).toEqual({
      timestamp: expect.any(Number),
      data: {
        test: expectedTest,
      }
    });
  });

  it('should get progress of all tests', async () => {
    const actualProgress = await controller.getProgressAll({ account_id: 1, limit: null, offset: null });
    expect(actualProgress).toEqual({
      timestamp: expect.any(Number),
      data: {
        progresses: testsProgress.map(getTestProgressInfo),
        total: testsProgress.length,
      }
    });
  });

  it('should get progress of all tests with limit and offset', async () => {
    const actualProgress = await controller.getProgressAll({ account_id: 1, limit: 2, offset: 1 });
    const expectedProgress = testsProgress.slice(1, 3).map(getTestProgressInfo);
    expect(actualProgress).toEqual({
      timestamp: expect.any(Number),
      data: {
        progresses: expectedProgress,
        total: expectedProgress.length,
      }
    });
  });

  it('should get progress of one test', async () => {
    const actualProgress = await controller.getProgress({ id: 1 }, { account_id: 1});
    const expectedProgress = testsProgress[0];
    expect(actualProgress).toEqual({
      timestamp: expect.any(Number),
      data: {
        test: expectedProgress.test,
        progress: {
          score: {
            highest: expectedProgress.scoreHighest,
            lowest: expectedProgress.scoreLowest,
            average: expectedProgress.getScoreAverage(),
          },
          times: expectedProgress.times,
          last_date: expectedProgress.date.valueOf(),
        },
      }
    });
  });

  it('should set progress of one test', async () => {
    const actualProgress = await controller.setProgress({ id: 1 }, { account_id: 1, score: 30, timestamp: null });
    const expectedProgress = {
      id: 1,
      test: 1,
      account: 1,
      date: new Date(),
      times: 3,
      scoreHighest: 100,
      scoreLowest: 30,
      scoreSum: 180,
      getScoreAverage: () => 60,
    };
    expect(actualProgress).toEqual({
      timestamp: expect.any(Number),
      status: 'SUCCESS',
    });
    expect({
      ...testsProgress[0],
      date: testsProgress[0].date.valueOf()/10000,
      getScoreAverage: testsProgress[0].getScoreAverage(),
    }).toEqual({
      ...expectedProgress,
      date: expect.closeTo(expectedProgress.date.valueOf()/10000, 0),
      getScoreAverage: expectedProgress.getScoreAverage(),
    });
  });

  it('should set progress of one test for the first time', async () => {
    const actualProgress = await controller.setProgress({ id: 3 }, { account_id: 1, score: 30, timestamp: null });
    const expectedProgress = {
      test: 3,
      account: 1,
      date: new Date(),
      times: 1,
      scoreHighest: 30,
      scoreLowest: 30,
      scoreSum: 30,
      getScoreAverage: () => 30,
    };
    expect(actualProgress).toEqual({
      timestamp: expect.any(Number),
      status: 'SUCCESS',
    });
    expect({
      ...testsProgress[2],
      date: testsProgress[2].date.valueOf()/10000,
      getScoreAverage: testsProgress[2].getScoreAverage(),
    }).toEqual({
      ...expectedProgress,
      date: expect.closeTo(expectedProgress.date.valueOf()/10000, 0),
      getScoreAverage: expectedProgress.getScoreAverage(),
      id: expect.any(Number),
    });
  });
});
