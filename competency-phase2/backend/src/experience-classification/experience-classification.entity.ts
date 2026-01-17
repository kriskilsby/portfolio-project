import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { EmployeeProjectExperience } from '../employee-project-experience/employee-project-experience.entity';
import { ClassificationValue } from '../classification-value/classification-value.entity';

@Entity({ name: 'experience_classification' })
export class ExperienceClassification {
  @PrimaryGeneratedColumn()
  ec_id: number;

  @ManyToOne(() => EmployeeProjectExperience, { nullable: false })
  @JoinColumn({ name: 'epe_id' })
  experience: EmployeeProjectExperience;

  @ManyToOne(() => ClassificationValue, { nullable: false })
  @JoinColumn({ name: 'cv_id' })
  classification_value: ClassificationValue;

  @Column({ length: 20, default: 'temp' })
  data_origin: string;
}
