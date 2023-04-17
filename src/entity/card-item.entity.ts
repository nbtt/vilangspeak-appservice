import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Card } from "./card.entity";
import { createTransformerEnum } from "../common/util";

export enum CardItemType {
    HEADER = 'h',
    PARAGRAPH = 'p',
    IMAGE = 'i',
    VIDEO = 'v',
    AUDIO = 'a',
}

@Entity()
export class CardItem {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({
        type: 'tinyint',
        transformer: createTransformerEnum(CardItemType),
    })
    type: CardItemType;

    @Column({type: 'tinyint'})
    order: number;

    @Column()
    content: string;

    @ManyToOne(type => Card, {createForeignKeyConstraints: false})
    card: Card;
}