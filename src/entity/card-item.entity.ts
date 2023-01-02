import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Card } from "./card.entity";

export enum CardItemType {
    HEADER = 'h',
    PARAGRAPH = 'p',
    IMAGE = 'i',
    VIDEO = 'v',
}

@Entity()
export class CardItem {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({type: 'tinyint'})
    type: CardItemType;

    @Column({type: 'tinyint'})
    order: number;

    @Column()
    content: string;

    @ManyToOne(type => Card)
    card: Card;
}