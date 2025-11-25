// db.js - PostgreSQL Connection Pool with Cloud + Local Fallback
// require('dotenv').config(); // Load environment variables
// const { Pool } = require('pg');

// let pool;

// if (process.env.DATABASE_URL) {
//   // Use Render-hosted database
//   pool = new Pool({
//     connectionString: process.env.DATABASE_URL,
//     ssl: {
//       rejectUnauthorized: false, // Required for Render SSL
//     },
//   });
//   console.log('🔗 Connected to Render PostgreSQL database');
// } else {
//   // Fallback to local database
//   pool = new Pool({
//     user: process.env.DB_USER || 'postgres',
//     host: process.env.DB_HOST || 'localhost',
//     database: process.env.DB_NAME || 'crown_hotel',
//     password: process.env.DB_PASSWORD || 'your_password',
//     port: process.env.DB_PORT || 5432,
//   });
//   console.log('💻 Connected to local PostgreSQL database');
// }

// pool.on('error', (err) => {
//   console.error('❌ Unexpected error on idle client', err);
//   process.exit(-1);
// });

// module.exports = pool;



// db.js - PostgreSQL Connection Pool (Local Only)
const path = require('path'); // <<< NEW: Import path module

// // db.js - PostgreSQL Connection Pool (Local Only)
// require('dotenv').config(); // Load environment variables



// MODIFIED: Tell dotenv to look for .env in the same directory as db.js
require('dotenv').config({
    path: path.resolve(__dirname, '.env') 
});

const { Pool } = require('pg');
// Create the connection pool using only the environment variables
// Note: We remove the '||' fallback values to ensure the app fails
// if the necessary variables are missing from .env

console.log('crown-app DB_USER:', process.env.DB_USER);
console.log('crown-app DB_HOST:', process.env.DB_HOST);
console.log('crown-app DB_NAME:', process.env.DB_NAME); 


console.log('crown-app DB_PORT:', process.env.DB_PORT);

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

console.log('💻 Connected to local PostgreSQL database');

pool.on('error', (err) => {
  console.error('❌ Unexpected error on idle client', err);
  process.exit(-1);
});

module.exports = pool;