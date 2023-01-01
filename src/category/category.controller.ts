import { Controller, Get } from '@nestjs/common';
import { CategoryService } from './category.service';

@Controller('/app/category')
export class CategoryController {
    constructor(private categoryService: CategoryService) {}

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
