import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  ManyToOne,
  JoinColumn,
  Unique,
} from 'typeorm';

import { Employee } from '../employees/employee.entity';
import { BusinessCategory } from '../business-categories/business-category.entity';

@Entity({ name: 'category_match' })
@Unique(['employee', 'businessCategory'])
export class CategoryMatch {
  @PrimaryGeneratedColumn()
  cm_id: number;

  // 🔗 Employee FK
  @ManyToOne(() => Employee, { nullable: false })
  @JoinColumn({ name: 'e_id' })
  employee: Employee;

  // 🔗 Business Category FK
  @ManyToOne(() => BusinessCategory, { nullable: false })
  @JoinColumn({ name: 'bc_id' })
  businessCategory: BusinessCategory;

  @CreateDateColumn({ type: 'datetime2' })
  cm_addDate: Date;

  @CreateDateColumn({ type: 'datetime2' })
  cm_eReview: Date;

  @Column({ type: 'datetime2', nullable: true })
  cm_mReview: Date | null;

  @Column({ type: 'bit', default: true })
  cm_active: boolean;

  @Column({ length: 20, default: 'temp' })
  data_origin: string;
}
