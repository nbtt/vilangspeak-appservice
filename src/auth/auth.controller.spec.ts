import { Test, TestingModule } from '@nestjs/testing';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { AccountRole } from 'src/entity/account.entity';

const logout = jest.fn().mockResolvedValue(undefined);

describe('AuthController', () => {
  let controller: AuthController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AuthController],
      providers: [{
        provide: AuthService, useValue: {
        login: jest.fn().mockImplementation((account, loginRole ?: AccountRole) => ({
            accessToken: 'test access',
            refreshToken: 'test refresh',
        })),
        logout: logout,
        convertJwtToAccount: jest.fn().mockImplementation((payload) => ({
          id: payload.sub,
          username: 'test',
          loginRole: 1,
          role: 1,
          iat: 123456,
        })),
        },
      }, {
        provide: JwtService, useValue: {},
      }, {
        provide: ConfigService, useValue: {},
      }],
    }).compile();

    controller = module.get<AuthController>(AuthController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should login', async () => {
    const result = await controller.login({ user: { id: 1 }});
    expect(result).toEqual({
      timestamp: expect.any(Number),
      id: 1,
      access_token: 'test access',
      refresh_token: 'test refresh',
    });
  });

  it('should logout', async () => {
    await controller.logout({ user: { id: 1 }});
    expect(logout).toBeCalledTimes(1);
  });

  it('should refresh token', async () => {
    const result = await controller.refresh({ userRefresh: { sub: 1 }});
    expect(result).toEqual({
      timestamp: expect.any(Number),
      id: 1,
      access_token: 'test access',
      refresh_token: 'test refresh',
    });
  });
});
