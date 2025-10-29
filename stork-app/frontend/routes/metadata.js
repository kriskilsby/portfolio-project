// routes/metadata.js
const express = require('express');
const { spawn } = require('child_process');
const path = require('path');
const os = require('os');
const router = express.Router();


router.get('/', (req, res) => {
  const scriptPath = path.join(__dirname, '../../scripts/get_metadata.py');
  const pythonWorkingDir = path.join(__dirname, '../../');

  // Dynamically set Python interpreter path
  const pythonPath =
    os.platform() === 'win32'
      // ? path.join(process.cwd(), 'venv', 'Scripts', 'python.exe')
      ? path.join(__dirname, '../../../venv/Scripts/python.exe')
      : '/root/portfolio/venv/bin/python';

  console.log('[DEBUG] Running python script with:');
  console.log('  pythonPath:', pythonPath);
  console.log('  scriptPath:', scriptPath);
  console.log('  cwd:', pythonWorkingDir);

  // const python = spawn(
  //   'C:\\Users\\krist\\OneDrive\\UEA Folder\\Dissertation\\stork_project\\venv\\Scripts\\python.exe',
  //   [scriptPath],
  //   { cwd: pythonWorkingDir }
  // );

  // const python = spawn(
  //   '/root/portfolio/venv/bin/python',
  //   [scriptPath],
  //   { cwd: pythonWorkingDir }
  // );

  const python = spawn(pythonPath, [scriptPath], { cwd: pythonWorkingDir });

  let result = '';
  let errorOutput = '';

  python.stdout.on('data', (data) => {
    result += data.toString();
  });

  python.stderr.on('data', (data) => {
    errorOutput += data.toString();
    console.error('[Python stderr]', errorOutput);
  });

  python.on('close', (code) => {
    if (code !== 0) {
      console.error('[Python exit code]', code);
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
// export default router;
