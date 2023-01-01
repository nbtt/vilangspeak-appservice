import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class Account {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column({type: "date"})
    birthday: string;

    @Column()
    username: string;

    @Column({type: "tinyint"})
    role: number;
}