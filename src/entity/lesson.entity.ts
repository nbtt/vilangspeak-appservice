import { Test } from "@nestjs/testing";
import { Column, Entity, JoinColumn, ManyToOne, OneToMany, OneToOne, PrimaryGeneratedColumn } from "typeorm";
import { Card } from "./card.entity";
import { Category } from "./category.entity";
import { Testx } from "./testx.entity";

@Entity()
export class Lesson {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column({ default: true })
    visible: boolean;

    @ManyToOne(type => Category)
    category: Category;

    @OneToOne(type => Testx)
    @JoinColumn()
    linkedTest: Testx;

    @OneToMany(type => Card, card => card.lesson)
    cards: Card[];
}