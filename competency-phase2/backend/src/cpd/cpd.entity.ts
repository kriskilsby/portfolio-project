import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { Employee } from '../employees/employee.entity';

@Entity({ name: 'cpd' })
export class Cpd {
  @PrimaryGeneratedColumn()
  cpd_id: number;

  // 🔗 Foreign key → employee
  @ManyToOne(() => Employee, { nullable: false })
  @JoinColumn({ name: 'e_id' })
  employee: Employee;

  @Column({ length: 255 })
  cpd_name: string;

  @Column({ type: 'int' })
  cpd_year: number;

  @CreateDateColumn({ type: 'datetime2' })
  cpd_addDate: Date;

  @CreateDateColumn({ type: 'datetime2' })
  cpd_eReview: Date;

  @Column({ type: 'datetime2', nullable: true })
  cpd_mReview: Date | null;

  @Column({ type: 'bit', default: true })
  cpd_active: boolean;

  @Column({ length: 20, default: 'temp' })
  data_origin: string;
}
