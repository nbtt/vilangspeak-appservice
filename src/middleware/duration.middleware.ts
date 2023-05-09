import { Request, Response, NextFunction } from "express";
import { Injectable, NestMiddleware, Inject, LoggerService } from "@nestjs/common";
import { InjectMetric } from "@willsoto/nestjs-prometheus";
import { Summary } from "prom-client";
import { WINSTON_MODULE_NEST_PROVIDER } from "nest-winston";

@Injectable()
export class DurationMiddleWare implements NestMiddleware {
  constructor(
    @InjectMetric("app_request_duration_seconds")
    private summary: Summary,

    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: LoggerService,
  ) {}

  use(request: Request, response: Response, next: NextFunction): void {
    const end = this.summary.startTimer();
    
    response.on("finish", () => {
      const status = response.statusCode;
      const path = response.req.route ? response.req.route.path : '/other';
      const method = request.method;
      let pathSplit = path.split("/");
      let service = pathSplit[1];
      if (!["auth", "public", "metrics"].includes(service)) {
        if (pathSplit[1] == "app") {
          service = pathSplit[2];
          if (![ "lesson", "category", "test", "account" ].includes(service)) {
            service = "app-unknown";
          }
        } else {
          service = "other";
        }
      }
      end({ service, method, path, status });
      
      // log information when status is not 2xx and 401
      if (status < 200 || status >= 300 && status != 401) {
        const originalUrl = request.originalUrl;
        this.logger.warn(`[${service}] ${method} ${originalUrl} response_status=${status} request=${JSON.stringify(request.body)}`);
      }
    });

    next();
  }
}