import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { AccountService } from 'src/account/account.service';
import { getCurrentNumericDate, getDateFromNumericDate } from 'src/common/util';
import { AccountLogin } from 'src/entity/account-login.entity';
import { AccountRole } from 'src/entity/account.entity';
import { Repository } from 'typeorm';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(AccountLogin)
    private accountLoginRepository: Repository<AccountLogin>,

    private accountService: AccountService,

    private jwtService: JwtService,

    private configService: ConfigService,
  ) { }

  async validateAccount(username: string, password: string): Promise<any> {
    const user = await this.accountService.getInfo({ username: username });
    if (user && user.password === password) {
      const { password, ...result } = user;
      return result;
    }
    return null;
  }

  login(account: any, loginRole: AccountRole = AccountRole.USER) {
    const loginTime = getCurrentNumericDate();

    this.updateLoginTime(account, loginRole, loginTime);

    // create tokens
    const payload = {
      username: account.username,
      sub: account.id,
      role: account.role,
      login_role: loginRole,
      iat: loginTime,
    };
    return this.createTokens(payload);
  }

  logout(account: any, loginRole: AccountRole = AccountRole.USER) {
    const logoutTime = getCurrentNumericDate();

    // Update loginTime as logOut time will make refresh token invalid
    this.updateLoginTime(account, loginRole, logoutTime);
  }

  convertJwtToAccount(jwtPayload: any) {
    return {
      id: jwtPayload.sub,
      username: jwtPayload.username,
      loginRole: jwtPayload.login_role,
      role: jwtPayload.role,
      iat: jwtPayload.iat,
    }
  }

  createTokens(payload: any) {
    return {
      accessToken: this.jwtService.sign(payload, {
        secret: this.configService.get<string>('jwt.secret.access'),
        expiresIn: this.configService.get<string>('jwt.exp_time.access'),
      }),
      refreshToken: this.jwtService.sign(payload, {
        secret: this.configService.get<string>('jwt.secret.refresh'),
        expiresIn: this.configService.get<string>('jwt.exp_time.refresh'),
      }),
    };
  }

  /**
   * Update login time of account
   * @param account.id id of account to update login time
   * @param loginRole login role
   * @param loginTime login time in NumericDate
   */
  updateLoginTime(account: any, loginRole: AccountRole, loginTime: number) {
    this.accountLoginRepository.upsert({
      accountId: account.id,
      role: loginRole,
      date: getDateFromNumericDate(loginTime),
    }, {
      conflictPaths: {
        accountId: true,
        role: true,
      },
      skipUpdateIfNoValuesChanged: true,
    })
  }

  async checkLoginTime(account: any, loginRole: AccountRole, timeToCheck: number) {
    const selectedAccount = await this.accountLoginRepository.findOne({
      where: {
        accountId: account.id,
        role: loginRole,
      },
      select: {
        date: true,
      }
    });

    return getDateFromNumericDate(timeToCheck).getTime() >= selectedAccount.date.getTime()
  }
}