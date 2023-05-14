import { Column, Entity, Index, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Account } from "./account.entity";
import { Achievement } from "./achievement.entity";

@Entity()
export class AchievementLog {
    @PrimaryGeneratedColumn()
    id: number;

    @Index()
    @ManyToOne(type => Account, {createForeignKeyConstraints: false})
    account: Account;

    @ManyToOne(type => Achievement, {createForeignKeyConstraints: false})
    achievement: Achievement;

    @Column({type: "timestamp"})
    date: Date;
}