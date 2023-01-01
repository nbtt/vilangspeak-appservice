import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Account } from "./account.entity";
import { Lesson } from "./lesson.entity";

@Entity()
export class LessonLog {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(type => Account)
    account: Account;

    @ManyToOne(type => Lesson)
    lesson: Lesson;

    @Column({type: "timestamp"})
    date: Date;

    @Column({type: "tinyint"})
    progress: number;
}