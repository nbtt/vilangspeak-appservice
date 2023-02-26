import { Controller, Get, Post, Request, UseGuards } from '@nestjs/common';
import { getSuccessResponse } from 'src/common/util';
import { AuthService } from './auth.service';
import { JwtAuthGuard } from './jwt/jwt.guard';
import { LocalAuthGuard } from './local/local.guard';

@Controller('/auth')
export class AuthController {
    constructor(private authService: AuthService) {}

    @UseGuards(LocalAuthGuard)
    @Post('/login')
    async login(@Request() req) {
        const tokens = this.authService.login(req.user);
        return {
            timestamp: Date.now(),
            access_token: tokens.accessToken,
            refresh_token: tokens.refreshToken
        }
    }

    @UseGuards(JwtAuthGuard)
    @Get('/ping')
    async ping(@Request() req) {
        return req.user
    }

    @UseGuards(JwtAuthGuard)
    @Post('/logout')
    async logout(@Request() req) {
        const account = {
            id: req.user.sub,
            username: req.user.username,
            loginRole: req.user.login_role,
            role: req.user.role,
        }
        this.authService.logout(account);
        return getSuccessResponse();
    }
}
