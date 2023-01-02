import { IsInt } from "class-validator";

export class QueryByIdDTO {
    @IsInt()
    id: number;
}

export class QueryByAccountIdDTO {
    @IsInt()
    account_id: number;
}