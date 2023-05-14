import { Column, Entity, Index, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Card } from "./card.entity";
import { createTransformerEnum } from "../common/util";
import { CardItemType } from "./card-item.entity";
import { Question } from "./question.entity";

@Entity()
export class QuestionItem {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({
        type: 'tinyint',
        transformer: createTransformerEnum(CardItemType),
    })
    type: CardItemType; // question item type

    @Column()
    content: string;

    @Column()
    answer: number;

    @Index()
    @ManyToOne(type => Question, {createForeignKeyConstraints: false})
    question: Question;
}