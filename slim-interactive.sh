#!/bin/bash

# mac-debloat — interactive mode
# Asks before killing each category of daemons.

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

confirm() {
  printf "${YELLOW}Disable $1?${RESET} [y/N] "
  read -r answer
  [[ "$answer" =~ ^[Yy]$ ]]
}

echo ""
echo "⚡ mac-debloat — interactive"
echo "────────────────────────────"
echo "Answer y/N for each category. Changes take effect after reboot."
echo ""

# === SIRI ===
if confirm "Siri & voice processing"; then
  launchctl disable gui/$(id -u)/com.apple.siri.embeddedspeech
  launchctl disable gui/$(id -u)/com.apple.assistantd
  launchctl disable gui/$(id -u)/com.apple.siriknowledged
  launchctl disable gui/$(id -u)/com.apple.siriactionsd
  launchctl disable gui/$(id -u)/com.apple.suggestd
  launchctl disable gui/$(id -u)/com.apple.corespeechd
  launchctl disable gui/$(id -u)/com.apple.parsecd
  launchctl disable gui/$(id -u)/com.apple.parsec-fbf
  echo -e "${GREEN}  ✓ Siri disabled${RESET}"
fi

# === GAME CONTROLLERS ===
if confirm "Game Controllers"; then
  launchctl disable gui/$(id -u)/com.apple.gamecontrolleragentd
  sudo launchctl disable system/com.apple.gamecontrollerd
  echo -e "${GREEN}  ✓ Game Controllers disabled${RESET}"
fi

# === AIRPLAY & CONTINUITY ===
if confirm "AirPlay & Continuity"; then
  launchctl disable gui/$(id -u)/com.apple.AirPlayUIAgent
  launchctl disable gui/$(id -u)/com.apple.sharingd
  sudo launchctl disable system/com.apple.AirPlayXPCHelper
  launchctl disable gui/$(id -u)/com.apple.ContinuityCaptureAgent
  launchctl disable gui/$(id -u)/com.apple.rapportd
  echo -e "${GREEN}  ✓ AirPlay & Continuity disabled${RESET}"
fi

# === SCREEN TIME & FAMILY ===
if confirm "Screen Time, Family & Education"; then
  launchctl disable gui/$(id -u)/com.apple.ScreenTimeAgent
  launchctl disable gui/$(id -u)/com.apple.familycircled
  launchctl disable gui/$(id -u)/com.apple.studentd
  launchctl disable gui/$(id -u)/com.apple.parentalcontrolsd
  echo -e "${GREEN}  ✓ Screen Time & Family disabled${RESET}"
fi

# === AIRDROP / HANDOFF / NEARBY ===
if confirm "AirDrop, Handoff & Nearby"; then
  sudo launchctl disable system/com.apple.nearbyd
  launchctl disable gui/$(id -u)/com.apple.rapportd
  launchctl disable gui/$(id -u)/com.apple.sharingd
  launchctl disable gui/$(id -u)/com.apple.BTLEServerAgent
  echo -e "${GREEN}  ✓ AirDrop / Handoff / Nearby disabled${RESET}"
fi

# === LOCATION SERVICES ===
if confirm "Location Services"; then
  launchctl disable gui/$(id -u)/com.apple.routined
  launchctl disable gui/$(id -u)/com.apple.CoreLocationAgent
  launchctl disable gui/$(id -u)/com.apple.WiFiVelocityAgent
  sudo launchctl disable system/com.apple.wifivelocityd
  sudo launchctl disable system/com.apple.wifianalyticsd
  echo -e "${GREEN}  ✓ Location Services disabled${RESET}"
fi

# === SPOTLIGHT & SEARCH ===
if confirm "Spotlight & Search indexing"; then
  launchctl disable gui/$(id -u)/com.apple.corespotlightd
  launchctl disable gui/$(id -u)/com.apple.knowledge-agent
  launchctl disable gui/$(id -u)/com.apple.contextstored
  launchctl disable gui/$(id -u)/com.apple.ContextStoreAgent
  launchctl disable gui/$(id -u)/com.apple.proactiveeventtrackerd
  echo -e "${GREEN}  ✓ Spotlight & Search disabled${RESET}"
fi

# === MEDIA / MUSIC / ITUNES ===
if confirm "Media, Music & iTunes agents"; then
  launchctl disable gui/$(id -u)/com.apple.AMPDeviceDiscoveryAgent
  launchctl disable gui/$(id -u)/com.apple.AMPArtworkAgent
  launchctl disable gui/$(id -u)/com.apple.mediaremoteagent
  launchctl disable gui/$(id -u)/com.apple.itunescloudd
  sudo launchctl disable system/com.apple.mediaremoted
  echo -e "${GREEN}  ✓ Media / Music / iTunes disabled${RESET}"
fi

# === ANALYTICS & CRASH REPORTING ===
if confirm "Analytics & Crash Reporting"; then
  sudo launchctl disable system/com.apple.analyticsd
  launchctl disable gui/$(id -u)/com.apple.UsageTrackingAgent
  sudo launchctl disable system/com.apple.osanalyticshelper
  sudo launchctl disable system/com.apple.awdd
  sudo launchctl disable system/com.apple.rtcreportingd
  echo -e "${GREEN}  ✓ Analytics & Crash Reporting disabled${RESET}"
fi

# === APPLE PAY & WALLET ===
if confirm "Apple Pay & Wallet"; then
  launchctl disable gui/$(id -u)/com.apple.passd
  sudo launchctl disable system/com.apple.nfcd
  launchctl disable gui/$(id -u)/com.apple.commerce
  echo -e "${GREEN}  ✓ Apple Pay & Wallet disabled${RESET}"
fi

# === ICLOUD PHOTOS & MEDIA ANALYSIS ===
if confirm "iCloud Photos & Media Analysis"; then
  launchctl disable gui/$(id -u)/com.apple.cloudphotod
  launchctl disable gui/$(id -u)/com.apple.photoanalysisd
  launchctl disable gui/$(id -u)/com.apple.mediaanalysisd
  launchctl disable gui/$(id -u)/com.apple.photolibraryd
  launchctl disable gui/$(id -u)/com.apple.CloudPhotosConfiguration
  echo -e "${GREEN}  ✓ iCloud Photos & Media Analysis disabled${RESET}"
fi

# === FIND MY ===
if confirm "Find My"; then
  launchctl disable gui/$(id -u)/com.apple.findmydevice-user-agent
  sudo launchctl disable system/com.apple.findmydeviced
  launchctl disable gui/$(id -u)/com.apple.fmfd
  echo -e "${GREEN}  ✓ Find My disabled${RESET}"
fi

# === DOCKER ===
if confirm "Docker VM network daemon"; then
  sudo launchctl disable system/com.docker.vmnetd
  echo -e "${GREEN}  ✓ Docker vmnetd disabled${RESET}"
fi

# === BIOMETRICS BACKGROUND ===
if confirm "Biometrics background agents"; then
  launchctl disable gui/$(id -u)/com.apple.BiomeAgent
  sudo launchctl disable system/com.apple.biomed
  sudo launchctl disable system/com.apple.biomesyncd
  echo -e "${GREEN}  ✓ Biometrics background disabled${RESET}"
fi

# === USELESS SYNC AGENTS ===
if confirm "Useless sync agents (followup, DND, activity)"; then
  launchctl disable gui/$(id -u)/com.apple.followupd
  launchctl disable gui/$(id -u)/com.apple.donotdisturbd
  launchctl disable gui/$(id -u)/com.apple.useractivityd
  launchctl disable gui/$(id -u)/com.apple.CMFSyncAgent
  echo -e "${GREEN}  ✓ Sync agents disabled${RESET}"
fi

# === APPLE HEALTH & HEARING ===
if confirm "Apple Health & Hearing"; then
  launchctl disable gui/$(id -u)/com.apple.heard
  launchctl disable gui/$(id -u)/com.apple.homed
  echo -e "${GREEN}  ✓ Health & Hearing disabled${RESET}"
fi

# === NATURALLANGUAGE / AI JUNK ===
if confirm "NaturalLanguage & AI background agents"; then
  launchctl disable gui/$(id -u)/com.apple.naturallanguaged
  launchctl disable gui/$(id -u)/com.apple.coreduetd
  echo -e "${GREEN}  ✓ NaturalLanguage / AI agents disabled${RESET}"
fi

# === SEARCH PARTY ===
if confirm "Search Party (Find My network)"; then
  sudo launchctl disable system/com.apple.searchpartyd
  launchctl disable gui/$(id -u)/com.apple.searchpartyuseragent
  echo -e "${GREEN}  ✓ Search Party disabled${RESET}"
fi

echo ""
echo "────────────────────────────"
echo -e "${GREEN}Done.${RESET} Reboot to apply all changes."
echo "To re-enable any service: launchctl enable <service.name>"
echo ""
