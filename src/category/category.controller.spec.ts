import { Test, TestingModule } from '@nestjs/testing';
import { CategoryController } from './category.controller';
import { CategoryService } from './category.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Category } from 'src/entity/category.entity';

const categories: Category[] = [{
  id: 1,
  name: 'test',
  image: 'test',
}, {
  id: 2,
  name: 'test',
  image: 'test',
}];

describe('CategoryController', () => {
  let controller: CategoryController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [CategoryController],
      providers: [{ provide: CategoryService, useValue: {
        getAll: jest.fn().mockResolvedValue(categories),
      } }],
    }).compile();

    controller = module.get<CategoryController>(CategoryController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should get all categories', async () => {
    expect(await controller.getAll()).toEqual({
      timestamp: expect.any(Number),
      data: {
        categories: categories,
        total: categories.length,
      },
    });
  });
});
