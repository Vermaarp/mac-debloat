# mac-debloat
Kill the daemons ⚡ A brutalist launchctl script to nuke Apple's background daemon bloat on macOS

Aggressively disables non-essential macOS background services including 
Siri, Analytics, AirPlay, Screen Time, Find My, iCloud Photos, 
Game Controllers, and other memory-hogging daemons that Apple 
ships enabled by default but most power users never need.

Tested on macOS Ventura / Sonoma | Apple Silicon + Intel
Use at your own risk. 

All changes are reversible via launchctl enable.
