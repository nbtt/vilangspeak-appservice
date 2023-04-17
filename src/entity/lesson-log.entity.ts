import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Account } from "./account.entity";
import { Lesson } from "./lesson.entity";

@Entity()
export class LessonLog {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(type => Account, {createForeignKeyConstraints: false})
    account: Account;

    @ManyToOne(type => Lesson, {createForeignKeyConstraints: false})
    lesson: Lesson;

    @Column({type: "timestamp"})
    date: Date;

    @Column({type: "tinyint"})
    progress: number;
}