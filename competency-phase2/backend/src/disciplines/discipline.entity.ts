import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn } from 'typeorm';

@Entity({ name: 'discipline' })
export class Discipline {
  @PrimaryGeneratedColumn()        // Auto-increment primary key
  d_id: number;

  @Column({ length: 100, unique: true })
  d_name: string;

  @CreateDateColumn({ type: 'datetime2' })  // Default to current timestamp
  d_addDate: Date;

  @Column({ type: 'bit', default: true })
  d_active: boolean;

  @Column({ length: 20, default: 'temp' })
  data_origin: string;
}
