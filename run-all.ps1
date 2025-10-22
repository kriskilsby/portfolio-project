# Start Portfolio
Start-Process powershell -ArgumentList '-NoExit','-Command','npm run app'

# Start Stork app
Start-Process powershell -ArgumentList '-NoExit','-Command','.\run-stork.ps1'