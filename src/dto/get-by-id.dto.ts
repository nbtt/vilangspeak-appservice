import { IsInt } from "class-validator";

export class GetByIdDTO {
    @IsInt()
    id: number;
}

export class GetByAccountIdDTO {
    @IsInt()
    account_id: number;
}