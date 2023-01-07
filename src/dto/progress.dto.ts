import { IsInt, IsOptional, Min } from "class-validator";

export class SetLessonProgressDTO {
    @IsOptional()
    @IsInt()
    public timestamp: number;

    @IsInt()
    @Min(0)
    public value: number;

    @IsInt()
    public account_id: number;
}

export class SetTestProgressDTO {
    @IsOptional()
    @IsInt()
    public timestamp: number;
    
    @IsInt()
    @Min(0)
    public score: number;

    @IsInt()
    public account_id: number;
}