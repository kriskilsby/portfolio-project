import { Connection } from 'tedious';
import * as dotenv from 'dotenv';
dotenv.config({ path: './.env' });

// Use 'as const' to make the type literal instead of string
const config = {
  server: process.env.DB_HOST!.trim(),
  authentication: {
    type: 'default' as const,  // <-- fix TypeScript literal type
    options: {
      userName: process.env.DB_USER!.trim(),
      password: process.env.DB_PASSWORD!.trim(),
    },
  },
  options: {
    database: process.env.DB_NAME!.trim(),
    encrypt: true,
    trustServerCertificate: false,
  },
};

const connection = new Connection(config);

connection.on('connect', (err) => {
  if (err) {
    console.error('Connection failed:', err);
  } else {
    console.log('Connected to Azure SQL successfully!');
  }
});

connection.connect();
