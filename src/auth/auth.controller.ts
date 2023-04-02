import { Controller, Get, Post, Request, UseGuards } from '@nestjs/common';
import { getSuccessResponse } from 'src/common/util';
import { AccountRole } from 'src/entity/account.entity';
import { AuthService } from './auth.service';
import { JwtAuthGuard } from './jwt/jwt.guard';
import { LocalAuthGuard } from './local/local.guard';
import { RolesGuard } from './roles/roles.guard';
import { LoginRole } from './roles/roles.login.decorator';
import { RolesRefreshGuard } from './roles/roles.refresh.guard';

@LoginRole(AccountRole.USER)
@Controller('/auth')
export class AuthController {
    constructor(private authService: AuthService) {}

    @UseGuards(LocalAuthGuard)
    @Post('/login')
    async login(@Request() req) {
        const tokens = this.authService.login(req.user);
        return this.makeTokensResp(tokens, req.user.id);
    }

    @UseGuards(JwtAuthGuard)
    @Get('/ping')
    async ping(@Request() req) {
        const jwtUser = req.user;
        return {
            timestamp: Date.now(),
            ...jwtUser,
        }
    }

    @UseGuards(RolesGuard)
    @Post('/logout')
    async logout(@Request() req) {
        const account = this.authService.convertJwtToAccount(req.user);
        this.authService.logout(account);
        return getSuccessResponse();
    }

    @UseGuards(RolesRefreshGuard)
    @Post('/refresh')
    async refresh(@Request() req) {
        const account = this.authService.convertJwtToAccount(req.userRefresh);
        const tokens = this.authService.login(account);
        return this.makeTokensResp(tokens, account.id);
    }

    makeTokensResp(tokens: {accessToken: string, refreshToken: string}, accountId: number) {
        return {
            timestamp: Date.now(),
            id: accountId,
            access_token: tokens.accessToken,
            refresh_token: tokens.refreshToken
        }
    }
}
