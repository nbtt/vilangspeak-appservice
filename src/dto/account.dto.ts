import { Transform } from "class-transformer";
import { IsDateString, IsOptional, IsString, Matches } from "class-validator";
import * as _ from "lodash";

export class CreateAccountDTO {
    @IsString()
    name: string;

    @Matches(/^[0-9]{4}-[0-9]{2}-[0-9]{2}.*$/, {
        message: 'birthday must be in format starting with YYYY-MM-DD',
    })
    @IsDateString({ strict: true })
    @Transform(({value}) => value.slice(0, 10))
    birthday: string;

    @Matches(/^[a-zA-Z][a-zA-Z0-9_]{3,19}$/, {
        message: 'Username must be 4-20 characters, start with a letter, and contain only letters, numbers, and underscores.',
    })
    @Transform(({value}) => _.toLower(value))
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