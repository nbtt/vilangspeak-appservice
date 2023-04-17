import { IsDateString, IsOptional, IsString } from "class-validator";

export class CreateAccountDTO {
    @IsString()
    name: string;

    @IsDateString({ strict: true })
    birthday: string;

    @IsString()
    username: string;

    @IsString()
    password: string;
}

export class UpdateAccountDTO {
    @IsOptional()
    @IsString()
    name: string;

    @IsOptional()
    @IsDateString({ strict: true })
    birthday: string;
}

export class ChangePasswordDTO {
    @IsString()
    password: string;

    @IsString()
    new_password: string;
}