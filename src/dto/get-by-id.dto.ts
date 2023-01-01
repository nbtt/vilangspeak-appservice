import { IsInt } from "class-validator";

export class GetByIdDTO {
    @IsInt()
    id: number;
}