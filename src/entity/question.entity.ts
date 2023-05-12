import { createTransformerEnum } from "src/common/util";
import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { CardItemType } from "./card-item.entity";
import { Testx } from "./testx.entity";
import { QuestionItem } from "./question-item.entity";

export enum QuestionType {
    SINGLE_CHOICE = 'sc', // single-answer multiple choices question
    MULTIPLE_CHOICE = 'mc', // multiple-answer multiple choices question
    DRAG_DROP = 'dd', // drag-and-drop question
}

@Entity()
export class Question {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({
        type: 'tinyint',
        transformer: createTransformerEnum(QuestionType),
    })
    question_type: QuestionType;

    @Column({
        type: 'tinyint',
        transformer: createTransformerEnum(CardItemType),
    })
    type: CardItemType; // question header type

    @Column({
        default: "",
    })
    description: string;

    @Column()
    content: string;

    @ManyToOne(type => Testx, {createForeignKeyConstraints: false})
    test: Testx;

    @OneToMany(type => QuestionItem, questionItem => questionItem.question, {createForeignKeyConstraints: false})
    items: QuestionItem[];
}