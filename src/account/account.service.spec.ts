import { Test, TestingModule } from '@nestjs/testing';
import { AccountService } from './account.service';
import { QueryFailedError } from 'typeorm';
import * as util from 'src/common/util';

const accounts = [{
  id: 1,
  username: 'test',
  password: 'test pass',
  name: 'test',
  birthday: '2000-01-01',
  role: 1,
}, {
  id: 2,
  username: 'test2',
  password: 'test2 pass',
  name: 'test2',
  birthday: '2000-01-02',
  role: 1,
}, {
  id: 3,
  username: 'test3',
  password: 'test3 pass',
  name: 'test3',
  birthday: '2000-01-03',
  role: 1,
}];
const achievementsLog = [{
  id: 1,
  account: 1,
  achievement: {
    id: 1,
    name: 'test',
    image: '/public/image/test.png',
  },
  date: new Date(2023, 1, 1),
}, {
  id: 2,
  account: 1,
  achievement: {
    id: 2,
    name: 'test2',
    image: '/public/image/test2.png',
  },
  date: new Date(2023, 1, 2),
}];
let counter = accounts.length;
const getNewId = () => {
  return ++counter;
};

describe('AccountService', () => {
  let service: AccountService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AccountService,
        {
          provide: 'AccountRepository',
          useValue: {
            findOneBy: async (filter: {id?: number, username?: string}) => {
              let result: Array<any> = [];
              if (filter.id) {
                result = accounts.filter(account => account.id === filter.id);
              }
              else {
                result = accounts.filter(account => account.username === filter.username);
              }
              return result.length == 1 ? result[0] : result;
            },
            insert: async (account: any) => {
              const findAccount = accounts.find(a => a.username === account.username);
              if (findAccount) {
                throw new QueryFailedError('test', [], {
                  code: 'ER_DUP_ENTRY'
                });
              };
              accounts.push({
                ...account,
                id: account.id || getNewId(),
              });
            },
            upsert: async (account: any, params: any) => {
              const findAccountIndex = accounts.findIndex(a => a.username === account.username);
              if (findAccountIndex != -1) {
                accounts[findAccountIndex] = {
                  ...accounts[findAccountIndex],
                  ...account,
                };
              } else {
                accounts.push({
                  ...account,
                  id: account.id || getNewId(),
                });
              }
            },
            update: async (id: number, account: any) => {
              const findAccountIndex = accounts.findIndex(a => a.id === id);
              if (findAccountIndex != -1) {
                accounts[findAccountIndex] = {
                  ...accounts[findAccountIndex],
                  ...account,
                };
              }
            },
          },
        },
        {
          provide: 'AchievementLogRepository',
          useValue: {
          },
        },
      ],
    }).compile();
    const makeHashValueSpy = jest.spyOn(util, 'makeHashValue');
    makeHashValueSpy.mockImplementation((value: string) => {
      return `${value}-hashed`;
    });

    service = module.get<AccountService>(AccountService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should get account by id', async () => {
    const result = await service.getInfo({ id: 1 });
    expect(result).toEqual(accounts[0]);
  });

  it('should create account', async () => {
    const newAccount = {
      username: 'test4',
      password: 'test4 pass',
      name: 'test4',
      birthday: '2000-01-04',
    };
    const expected = {
      ...newAccount,
      id: expect.any(Number),
      role: 1,
      password: 'test4 pass-hashed',
    }
    const result = await service.create(newAccount);
    expect(result).toEqual(expected);
    expect(accounts[accounts.length - 1]).toEqual(expected);
  });
});
