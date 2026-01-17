import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
} from 'typeorm';
import { LegalEntity } from '../legal-entities/legal-entity.entity';
import { Discipline } from '../disciplines/discipline.entity';

@Entity({ name: 'employee' })
export class Employee {
  @PrimaryGeneratedColumn()
  e_id: number;

  @Column({ length: 50, unique: true, nullable: true })
  e_norseid: string;

  // 🔹 Foreign key → legal_entity
  @ManyToOne(() => LegalEntity, { nullable: false })
  @JoinColumn({ name: 'le_id' })
  legal_entity: LegalEntity;

  // 🔹 Foreign key → discipline
  @ManyToOne(() => Discipline, { nullable: true })
  @JoinColumn({ name: 'd_id' })
  discipline: Discipline;

  @Column({ length: 100 })
  e_fname: string;

  @Column({ length: 100 })
  e_lname: string;

  @Column({ length: 150 })
  e_job: string;

  @Column({ type: 'date', nullable: true })
  e_start: Date;

  @Column({ length: 255 })
  e_email: string;

  @Column({ length: 50 })
  e_contactno: string;

  @Column({ type: 'nvarchar', nullable: true })
  e_note: string;

  @CreateDateColumn({ type: 'datetime2' })
  e_addDate: Date;

  @CreateDateColumn({ type: 'datetime2' })
  e_eReview: Date;

  @Column({ type: 'datetime2', nullable: true })
  e_mReview: Date;

  @Column({ type: 'bit', default: true })
  e_active: boolean;

  @Column({ length: 20, default: 'temp' })
  data_origin: string;
}
