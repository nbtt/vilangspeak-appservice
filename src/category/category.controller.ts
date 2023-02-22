import { Controller, Get, UseGuards } from '@nestjs/common';
import { RolesGuard } from 'src/auth/roles/roles.guard';
import { LoginRole } from 'src/auth/roles/roles.login.decorator';
import { AccountRole } from 'src/entity/account.entity';
import { CategoryService } from './category.service';

@LoginRole(AccountRole.USER)
@Controller('/app/category')
export class CategoryController {
    constructor(private categoryService: CategoryService) {}

    @UseGuards(RolesGuard)
    @Get('/all')
    async getAll() {
        const categories = await this.categoryService.getAll();
        
        return {
            timestamp: Date.now(),
            data: {
                categories: categories,
                total: categories.length,
            },
        };
    }
}
