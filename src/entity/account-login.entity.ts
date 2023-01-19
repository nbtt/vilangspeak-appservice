import { Column, Entity, PrimaryColumn } from "typeorm";
import { AccountRole } from "./account.entity";

@Entity()
export class AccountLogin {
    @PrimaryColumn()
    accountId: number;

    @PrimaryColumn({ type: "tinyint" })
    role: AccountRole;

    @Column({type: "timestamp"})
    date: Date;
}