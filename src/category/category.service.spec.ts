import { Test, TestingModule } from '@nestjs/testing';
import { CategoryService } from './category.service';

describe('CategoryService', () => {
  let service: CategoryService;
  const categories = [{
    id: 1,
    name: 'test',
    image: 'test',
  }, {
    id: 2,
    name: 'test',
    image: 'test',
  }];

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [CategoryService,
      { provide: 'CategoryRepository', useValue: {
        find: jest.fn().mockResolvedValue(categories),
      } }],
    }).compile();

    service = module.get<CategoryService>(CategoryService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should get all categories', async () => {
    expect(await service.getAll()).toEqual(categories);
  });
});
