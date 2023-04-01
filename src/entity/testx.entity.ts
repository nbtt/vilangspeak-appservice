import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { Category } from "./category.entity";
import { Question } from "./question.entity";

@Entity()
export class Testx {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column({ default: true })
    visible: boolean;

    @ManyToOne(type => Category)
    category: Category;

    @OneToMany(type => Question, question => question.test)
    questions: Question[];
}