import { Test, TestingModule } from '@nestjs/testing';
import { AccountController } from './account.controller';
import { AccountService } from './account.service';
import { ChangePasswordDTO, CreateAccountDTO, UpdateAccountDTO } from 'src/dto/account.dto';
import { HttpException, HttpStatus, UnauthorizedException } from '@nestjs/common';

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
  date: new Date(2023, 1, 1).valueOf(),
}, {
  id: 2,
  account: 1,
  achievement: {
    id: 2,
    name: 'test2',
    image: '/public/image/test2.png',
  },
  date: new Date(2023, 1, 2).valueOf(),
}];
let counter = accounts.length;
const getNewId = () => {
  return ++counter;
};

describe('AccountController', () => {
  let controller: AccountController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AccountController],
      providers: [{ provide: AccountService, useValue: {
          getInfo: (filter: {id?: number, username?: string}) => {
            if (filter.id) {
              return accounts.find((account) => account.id === filter.id);
            }
            else if (filter.username) {
              return accounts.find((account) => account.username === filter.username);
            }
            else {
              return accounts;
            }
          },
          create: (accountInfo: CreateAccountDTO) => {
            let findAccount = accounts.find((account) => account.username === accountInfo.username);
            if (findAccount) {
              throw new HttpException("Username existed", HttpStatus.CONFLICT);
            }
            let newAccount = {
              ...accountInfo,
              id: getNewId(),
              role: 1,
            };
            accounts.push(newAccount);
            return newAccount;
          },
          createForced: (accountInfo: CreateAccountDTO) => {
            let findAccountIndex = accounts.findIndex((account) => account.username === accountInfo.username);
            let findAccountId = -1;
            if (findAccountIndex != -1) {
              findAccountId = accounts[findAccountIndex].id;
              accounts.splice(findAccountIndex, 1);
            }
            let newAccount = {
              ...accountInfo,
              id: findAccountIndex === -1 ? getNewId() : findAccountId,
              role: 0,
            };
            accounts.push(newAccount);
            return newAccount;
          },
          updateInfo: (filter: { id?: number, username?: string }, updateInfo: UpdateAccountDTO) => {
            let findAccountIndex = accounts.findIndex((account) => account.id === filter.id);
            accounts[findAccountIndex].name = updateInfo.name;
            accounts[findAccountIndex].birthday = updateInfo.birthday;
            return accounts[findAccountIndex];
          },
          changePassword: (filter: { id?: number, username?: string }, changePasswordInfo: ChangePasswordDTO) => {
            let findAccount = accounts.find((account) => account.id === filter.id);
            if (findAccount.password !== changePasswordInfo.password) {
              throw new UnauthorizedException("Wrong password");
            }
            findAccount.password = changePasswordInfo.new_password;
            return findAccount;
          },
          getAchievements: (id: number, limit: number, offset: number) => {
            return achievementsLog.filter((achievementLog) => achievementLog.account === id).slice(offset, offset + limit);
          },
        },
      }],
    }).compile();

    controller = module.get<AccountController>(AccountController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should create a new account', async () => {
    let newAccount = {
      username: 'test new',
      password: 'test new pass',
      name: 'testnew',
      birthday: '2000-01-03',
    };
    let newAccountResponse = await controller.create(newAccount);
    expect(newAccountResponse).toEqual({
      timestamp: expect.any(Number),
      data: {
        account: {
          id: expect.any(Number),
          username: newAccount.username,
          name: newAccount.name,
          birthday: newAccount.birthday,
          role: 1,
        }
      }
    });
  });

  it('should update account info', async () => {
    let updateInfo = {
      name: 'test update',
      birthday: '2000-01-04',
    };
    let oldAccountInfo = structuredClone(accounts[1]);
    let updateInfoResponse = await controller.updateInfo({ id: 2 }, updateInfo);
    expect(updateInfoResponse).toEqual({
      timestamp: expect.any(Number),
      data: {
        account: {
          id: oldAccountInfo.id,
          username: oldAccountInfo.username,
          name: updateInfo.name,
          birthday: updateInfo.birthday,
          role: oldAccountInfo.role,
        }
      }
    });
  });

  it('should change password', async () => {
    let changePasswordInfo = {
      password: 'test3 pass',
      new_password: 'test pass new',
    };
    let oldAccountInfo = structuredClone(accounts[2]);
    let changePasswordResponse = await controller.changePassword({ id: 3 }, changePasswordInfo);
    expect(changePasswordResponse).toEqual({
      timestamp: expect.any(Number),
      data: {
        account: {
          id: oldAccountInfo.id,
          username: oldAccountInfo.username,
          name: oldAccountInfo.name,
          birthday: oldAccountInfo.birthday,
          role: oldAccountInfo.role,
        }
      }
    });
  });

  it('should get account info', async () => {
    let oldAccountInfo = structuredClone(accounts[0]);
    let getAccountInfoResponse = await controller.getInfo({ id: 1 });
    expect(getAccountInfoResponse).toEqual({
      timestamp: expect.any(Number),
      data: {
        account: {
          id: oldAccountInfo.id,
          username: oldAccountInfo.username,
          name: oldAccountInfo.name,
          birthday: oldAccountInfo.birthday,
          role: oldAccountInfo.role,
        }
      }
    });
  });

  it('should throw error when get account info with wrong id', async () => {
    const result = controller.getInfo({ id: 10000 });
    await expect(result).rejects.toThrowError(new HttpException("Not found account by id 10000", HttpStatus.NOT_FOUND));
  });

  it('should get all achievements of account', async () => {
    const expected = achievementsLog.filter((achievementLog) => achievementLog.account === 1);
    const result = await controller.getAllAchievement({ id: 1 }, { limit: 10, offset: 0 });
    expect(result).toEqual({
      timestamp: expect.any(Number),
      data: {
        account: 1,
        achievements: expected.slice(0, 10).map((achievementLog) => {
          return {
            id: achievementLog.id,
            name: achievementLog.achievement.name,
            image: achievementLog.achievement.image,
            date: achievementLog.date,
          };
        }),
        total: expected.length,
      }
    });
  });
});
