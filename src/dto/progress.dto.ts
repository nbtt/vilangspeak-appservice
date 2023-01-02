import { IsInt, Min } from "class-validator";

export class SetLessonProgressDTO {
    @IsInt()
    @Min(0)
    public value: number;

    @IsInt()
    public account_id: number;
}