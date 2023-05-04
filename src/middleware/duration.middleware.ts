import { Request, Response, NextFunction } from "express";
import { Injectable, NestMiddleware, Logger } from "@nestjs/common";
import { InjectMetric } from "@willsoto/nestjs-prometheus";
import { Summary } from "prom-client";

@Injectable()
export class DurationMiddleWare implements NestMiddleware {
  constructor(
    @InjectMetric("app_request_duration_seconds")
    private summary: Summary,
  ) {}

  use(request: Request, response: Response, next: NextFunction): void {
    const end = this.summary.startTimer();
    
    response.on("finish", () => {
      const status = response.statusCode;
      const path = response.req.route.path;
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
      const endTime = Date.now();
      end({ service, method, path, status });
    });

    next();
  }
}