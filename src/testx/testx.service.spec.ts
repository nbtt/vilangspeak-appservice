import { Test, TestingModule } from '@nestjs/testing';
import { TestxService } from './testx.service';

describe('TestxService', () => {
  let service: TestxService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [TestxService],
    }).compile();

    service = module.get<TestxService>(TestxService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
