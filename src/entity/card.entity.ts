import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { CardItem } from "./card-item.entity";
import { Lesson } from "./lesson.entity";
import { createTransformerEnum } from "../common/util";

export enum CardType {
    WORD = 'w',
    SENTENCE = 's',
}

@Entity()
export class Card {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({
        type: 'tinyint',
        transformer: createTransformerEnum(CardType),
    })
    type: CardType;

    @Column()
    audioUrl: string;

    @Column()
    content: string;

    @Column()
    translation: string;

    @ManyToOne(type => Lesson, {createForeignKeyConstraints: false})
    lesson: Lesson;

    @OneToMany(type => CardItem, cardItem => cardItem.card, {createForeignKeyConstraints: false})
    items: CardItem[];
}