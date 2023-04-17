import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Account } from "./account.entity";
import { Testx } from "./testx.entity";

@Entity()
export class TestLog {
    @PrimaryGeneratedColumn()
    id: number;

    @ManyToOne(type => Account, {createForeignKeyConstraints: false})
    account: Account;

    @ManyToOne(type => Testx, {createForeignKeyConstraints: false})
    test: Testx;

    @Column({type: "timestamp"})
    date: Date;

    @Column()
    times: number;

    @Column()
    scoreHighest: number;

    @Column()
    scoreLowest: number;

    @Column()
    scoreSum: number;
    
    getScoreAverage() {
        return (this.times == 0) ? 0 : Math.round(this.scoreSum / this.times * 10) / 10;
    }
}