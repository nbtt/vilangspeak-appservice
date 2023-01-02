import { Column, Entity, ManyToOne, OneToMany, PrimaryGeneratedColumn } from "typeorm";
import { CardItem } from "./card-item.entity";
import { Lesson } from "./lesson.entity";

enum CardType {
    WORD = 'w',
    SENTENCE = 'h',
}

@Entity()
export class Card {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({type: 'tinyint'})
    type: CardType;

    @Column()
    audioUrl: string;

    @Column()
    content: string;

    @Column()
    translation: string;

    @ManyToOne(type => Lesson)
    lesson: Lesson;

    @OneToMany(type => CardItem, cardItem => cardItem.card)
    items: CardItem[];
}