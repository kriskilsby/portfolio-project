import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
} from 'typeorm';
import { ClassificationType } from '../classification-type/classification-type.entity';

@Entity({ name: 'classification_value' })
export class ClassificationValue {
  @PrimaryGeneratedColumn()
  cv_id: number;

  @ManyToOne(() => ClassificationType, { nullable: false })
  @JoinColumn({ name: 'ct_id' })
  classification_type: ClassificationType;

  @Column({ type: 'varchar', length: 150 })
  type_name: string;

  @Column({ length: 20, default: 'temp' })
 data_origin: string;
}
