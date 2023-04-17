import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

export enum AccountRole {
    ADMIN = 0,
    USER = 1,
}

@Entity()
export class Account {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column({type: "date"})
    birthday: string;

    @Column({unique: true})
    username: string;

    @Column()
    password: string;

    @Column({type: "tinyint"})
    role: AccountRole;
}