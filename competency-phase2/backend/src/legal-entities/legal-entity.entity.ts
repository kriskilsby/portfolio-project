import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
} from 'typeorm';

@Entity({ name: 'legal_entity' })
export class LegalEntity {
  @PrimaryGeneratedColumn()
  le_id: number;

  @Column({ length: 50, unique: true })
  le_name: string;

  @CreateDateColumn({ type: 'datetime2' })
  le_addDate: Date;

  @Column({ type: 'bit', default: true })
  le_active: boolean;

  @Column({ length: 20, default: 'temp' })
  data_origin: string;
}
