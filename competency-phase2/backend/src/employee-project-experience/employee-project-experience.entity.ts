import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  Check,
} from 'typeorm';

import { Employee } from '../employees/employee.entity';
import { ProjectMaster } from '../project-master/project-master.entity';

@Entity({ name: 'employee_project_experience' })
@Check(`epe_start BETWEEN 1950 AND 2100`)
@Check(`epe_end BETWEEN 1950 AND 2100 OR epe_end IS NULL`)
@Check(`epe_end IS NULL OR epe_end >= epe_start`)
export class EmployeeProjectExperience {
  @PrimaryGeneratedColumn()
  epe_id: number;

  // 🔗 Employee (required)
  @ManyToOne(() => Employee, { nullable: false })
  @JoinColumn({ name: 'e_id' })
  employee: Employee;

  // 🔗 Canonical project (optional)
  @ManyToOne(() => ProjectMaster, { nullable: true })
  @JoinColumn({ name: 'pm_id' })
  project: ProjectMaster | null;

  // 🔗 Future FK → primary_sector
  @Column({ type: 'int', nullable: true })
  ps_id: number | null;

  @Column({ length: 150 })
  epe_service: string;

  @Column({ type: 'int' })
  epe_start: number;

  @Column({ type: 'int', nullable: true })
  epe_end: number | null;

  @Column({ type: 'int', nullable: true })
  epe_contract_value: number | null;

  @Column({ type: 'varchar', length: 50, nullable: true })
  epe_stages?: string;

  @Column({ type: 'bit', default: false })
  epe_high_risk: boolean;

  @Column({ type: 'varchar', length: 150, nullable: true })
  epe_contract_type?: string;

  @Column({ type: 'varchar', length: 150, nullable: true })
  epe_gia: string | null;

  @Column({ type: 'text', nullable: true })
  epe_description_1: string | null;

  @Column({ type: 'text', nullable: true })
  epe_description_2: string | null;

  @Column({ type: 'text', nullable: true })
  epe_description_3: string | null;

  @Column({ type: 'text', nullable: true })
  epe_notes: string | null;

  @CreateDateColumn({ type: 'datetime2' })
  epe_added_at: Date;

  @CreateDateColumn({ type: 'datetime2' })
  epe_employee_reviewed_at: Date;

  @Column({ type: 'datetime2', nullable: true })
  epe_manager_reviewed_at: Date | null;

  @Column({ type: 'bit', default: true })
  epe_active: boolean;

  @Column({ length: 20, default: 'temp' })
  data_origin: string;

  @Column({ type: 'int', nullable: true })
  temp_sort: number | null;
}
