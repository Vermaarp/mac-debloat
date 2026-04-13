# mac-debloat

Kill the daemons ⚡ A brutalist `launchctl` script to nuke Apple's background daemon bloat on macOS.

Aggressively disables non-essential macOS background services including Siri, Analytics, AirPlay, Screen Time, Find My, iCloud Photos, Game Controllers, and other memory-hogging daemons that Apple ships enabled by default but most power users never need.

Tested on macOS Ventura / Sonoma | Apple Silicon + Intel

---

## Usage

```bash
git clone https://github.com/yourusername/mac-debloat.git
cd mac-debloat
chmod +x slim-interactive.sh
./slim.sh
```

Some commands require `sudo` — you'll be prompted.

---

## What Gets Killed

| Category | Daemons |
|---|---|
| Siri | `assistantd`, `siriknowledged`, `siriactionsd`, `suggestd`, `corespeechd`, `parsecd`, `parsec-fbf`, `siri.embeddedspeech` |
| Analytics & Crash Reporting | `analyticsd`, `osanalyticshelper`, `awdd`, `rtcreportingd`, `UsageTrackingAgent` |
| AirPlay & Continuity | `AirPlayUIAgent`, `AirPlayXPCHelper`, `ContinuityCaptureAgent`, `sharingd`, `rapportd` |
| AirDrop / Handoff / Nearby | `nearbyd`, `sharingd`, `rapportd`, `BTLEServerAgent` |
| Screen Time & Family | `ScreenTimeAgent`, `familycircled`, `studentd`, `parentalcontrolsd` |
| Location Services | `routined`, `CoreLocationAgent`, `WiFiVelocityAgent`, `wifivelocityd`, `wifianalyticsd` |
| Spotlight & Search | `corespotlightd`, `knowledge-agent`, `contextstored`, `ContextStoreAgent`, `proactiveeventtrackerd` |
| iCloud Photos & Media Analysis | `cloudphotod`, `photoanalysisd`, `mediaanalysisd`, `photolibraryd`, `CloudPhotosConfiguration` |
| Find My | `findmydevice-user-agent`, `findmydeviced`, `fmfd`, `searchpartyd`, `searchpartyuseragent` |
| Media / Music / iTunes | `AMPDeviceDiscoveryAgent`, `AMPArtworkAgent`, `mediaremoteagent`, `itunescloudd`, `mediaremoted` |
| Apple Pay & Wallet | `passd`, `nfcd`, `commerce` |
| Game Controllers | `gamecontrolleragentd`, `gamecontrollerd` |
| Biometrics Background | `BiomeAgent`, `biomed`, `biomesyncd` |
| Apple Health & Hearing | `heard`, `homed` |
| NaturalLanguage / AI Junk | `naturallanguaged`, `coreduetd` |
| Useless Sync Agents | `followupd`, `donotdisturbd`, `useractivityd`, `CMFSyncAgent` |
| Docker | `com.docker.vmnetd` |

---

## Reverting

All changes are reversible:

```bash
launchctl enable <service.name>
```

For system-level daemons:

```bash
sudo launchctl enable system/<service.name>
```

Then reboot, or kickstart the agent directly:

```bash
launchctl kickstart -k gui/$(id -u)/<service.name>
```

---

## Warning

Some macOS features will stop working. Apple updates may partially revert changes. Intended for advanced users only.

**Use at your own risk.**

---

## License

MIT
