import { Test, TestingModule } from '@nestjs/testing';
import { TestxController } from './testx.controller';

describe('TestxController', () => {
  let controller: TestxController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [TestxController],
    }).compile();

    controller = module.get<TestxController>(TestxController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
