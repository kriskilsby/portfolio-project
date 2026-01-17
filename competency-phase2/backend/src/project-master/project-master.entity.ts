import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
} from 'typeorm';

@Entity({ name: 'project_master' })
export class ProjectMaster {
  @PrimaryGeneratedColumn()
  pm_id: number;

  @Column({ length: 150 })
  pm_name: string;

  @Column({ length: 150, nullable: true })
  pm_location: string;

  @Column({ length: 150, nullable: true })
  pm_client: string;

  @Column({ type: 'text', nullable: true })
  pm_notes: string;

  @Column({ type: 'bit', default: true })
  pm_active: boolean;

  @Column({ length: 20, default: 'temp' })
  data_origin: string;
}
