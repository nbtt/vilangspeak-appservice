import { ExecutionContext } from "@nestjs/common";
import { Reflector } from "@nestjs/core";
import * as bcrypt from "bcrypt";

export function createTransformerEnum<T>(enumType: T) {
    return {
        from(value: number): T {
            return Object.values(enumType)[value];
        },
        to(value: T): number {
            return Object.values(enumType).indexOf(value);
        },
    }
}

export function getCurrentNumericDate(): number {
    return Math.floor(Date.now() / 1000);
}

export function getDateFromNumericDate(numericDate: number): Date {
    return new Date(numericDate * 1000);
}

export function generateRandomString(length) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    return [...Array(length)].reduce(a=>a+chars[~~(Math.random()*chars.length)],'');
}

export function makeHashValue(data: string) {
    const salt = bcrypt.genSaltSync();
    const hash = bcrypt.hashSync(data, salt);
    return hash;
}

export function hashAndCompare(data: string, hash: string) {
    return bcrypt.compareSync(data, hash);
}

export function getSuccessResponse() {
    return {
        timestamp: Date.now(),
        status: "SUCCESS",
    }
}

export function getMetadataFromControllerAndHandler<T>(context: ExecutionContext, reflector: Reflector, name: string) {
    const metadataController = reflector.get<T>(name, context.getClass()) || [];
    const metadataHandler = reflector.get<T>(name, context.getHandler()) || [];

    // concatenate the result
    const result = [
        ...(Array.isArray(metadataController) ? metadataController : [metadataController]),
        ...(Array.isArray(metadataHandler) ? metadataHandler : [metadataHandler])
    ];

    return result;
}