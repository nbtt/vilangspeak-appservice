import { IsInt, IsOptional, IsPositive, Min } from "class-validator";

export class GetAllDTO {
    @IsOptional()
    @IsInt()
    @IsPositive()
    public limit: number;

    @IsOptional()
    @IsInt()
    @Min(0)
    public offset: number;
}