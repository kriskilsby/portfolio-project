// routes/metadata.js
const express = require('express');
const { spawn } = require('child_process');
const path = require('path');
const os = require('os');
const router = express.Router();

router.get('/', (req, res) => {
  const scriptPath = path.join(__dirname, '../../scripts/get_metadata.py');
  const pythonWorkingDir = path.join(__dirname, '../../');

  // Use the correct venv for Windows or Linux
  const pythonPath = os.platform() === 'win32'
    ? "C:\\Users\\krist\\OneDrive\\Projects\\portfolio\\venv\\Scripts\\python.exe"
    : "/root/portfolio/venv/bin/python";

  console.log('[DEBUG] Running Python metadata script:');
  console.log('  pythonPath:', pythonPath);
  console.log('  scriptPath:', scriptPath);
  console.log('  cwd:', pythonWorkingDir);

  const python = spawn(pythonPath, [scriptPath], { cwd: pythonWorkingDir });

  let result = '';
  let errorOutput = '';

  python.stdout.on('data', (data) => {
    console.log('[Python stdout]', data.toString());
    result += data.toString();
  });

  python.stderr.on('data', (data) => {
    console.error('[Python stderr]', data.toString());
    errorOutput += data.toString();
  });

  python.on('error', (err) => {
    console.error('[Spawn error]', err);
    res.status(500).json({ error: 'Failed to start Python script', details: err });
  });

  python.on('close', (code) => {
    console.log('[Python exit code]', code);

    if (code !== 0) {
      return res.status(500).json({
        error: 'Python script failed',
        code,
        stderr: errorOutput,
      });
    }

    try {
      const parsed = JSON.parse(result);
      res.json(parsed);
    } catch (e) {
      console.error('[Parse error]', e.message);
      res.status(500).json({
        error: 'Failed to parse Python output',
        rawOutput: result,
      });
    }
  });
});

module.exports = router;
