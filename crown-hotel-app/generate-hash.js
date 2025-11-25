const bcrypt = require('bcrypt');

const password = 'password123';

bcrypt.hash(password, 10, (err, hash) => {
  if (err) {
    console.error('❌ Error hashing password:', err);
  } else {
    console.log(`✅ Bcrypt hash for "${password}":\n`, hash);
  }
});
