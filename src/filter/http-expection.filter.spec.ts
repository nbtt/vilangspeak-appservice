import { Test, TestingModule } from "@nestjs/testing";
import { HttpExceptionFilter } from "./http-expection.filter";
import { HttpException, HttpStatus } from "@nestjs/common";

const mockJson = jest.fn();
const mockStatus = jest.fn().mockImplementation(() => ({
  json: mockJson
}));
const mockGetRequest = jest.fn().mockImplementation(() => ({
  url: '/example/url'
}));
const mockGetResponse = jest.fn().mockImplementation(() => ({
  status: mockStatus
}));
const mockHttpArgumentsHost = jest.fn().mockImplementation(() => ({
  getResponse: mockGetResponse,
  getRequest: mockGetRequest,
}));

const mockArgumentsHost = {
  switchToHttp: mockHttpArgumentsHost,
  getArgByIndex: jest.fn(),
  getArgs: jest.fn(),
  getType: jest.fn(),
  switchToRpc: jest.fn(),
  switchToWs: jest.fn()
};

describe('HttpExpectionFilter', () => {
  let filter: HttpExceptionFilter;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [HttpExceptionFilter],
    }).compile();

    filter = module.get<HttpExceptionFilter>(HttpExceptionFilter);
  });

  it('should be defined', () => {
    expect(filter).toBeDefined();
  });

  it('should catch Bad Request exception', () => {
    filter.catch(new HttpException('test exception 400', HttpStatus.BAD_REQUEST), mockArgumentsHost);
    expect(mockStatus).toBeCalledWith(HttpStatus.BAD_REQUEST);
    expect(mockJson).toBeCalledWith({
      timestamp: expect.any(Number),
      code: 1,
      path: '/example/url',
      message: 'test exception 400',
    });
  });

  it('should catch other http exceptions', () => {
    filter.catch(new HttpException('test exception', HttpStatus.UNAUTHORIZED), mockArgumentsHost);
    expect(mockStatus).toBeCalledWith(HttpStatus.UNAUTHORIZED);
    expect(mockJson).toBeCalledWith({
      timestamp: expect.any(Number),
      code: 2,
      path: '/example/url',
      message: 'test exception',
    });
  });

  it('should catch http exceptions with response message', () => {
    filter.catch(new HttpException({ message: 'test response message' }, HttpStatus.CONFLICT), mockArgumentsHost);
    expect(mockStatus).toBeCalledWith(HttpStatus.CONFLICT);
    expect(mockJson).toBeCalledWith({
      timestamp: expect.any(Number),
      code: 2,
      path: '/example/url',
      message: 'test response message',
    });
  });
});