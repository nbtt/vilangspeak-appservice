import { IsInt, IsOptional, IsPositive, Min } from "class-validator";

export class GetAllByIdDTO {
    @IsInt()
    public account_id: number;

    @IsOptional()
    @IsInt()
    @IsPositive()
    public limit: number;

    @IsOptional()
    @IsInt()
    @Min(0)
    public offset: number;
}