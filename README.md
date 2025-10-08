# Configuration management for work MacBook

MacBook Pro 14" 2021, M1 Pro, 32GB.

Install with US region for Apple Intelligence.

## Setup

- Initialize ssh key passwords in keychain:

  ```sh
  ssh-add --apple-use-keychain ~/.ssh/id_ed25519_com
  ```

- Install build dependencies for Homebrew:

  ```sh
  xcode-select --install
  ```

- Install Homebrew using the PKG installer.

- Provide secrets:

  ```sh
  cat <<EOF >secrets.sh
  GIT_NAME='Your Name'
  GIT_EMAIL='your@name.tld'
  EOF
  ```

- Provision the system:

  ```sh
  ./run.sh
  ```

## GUI Settings

### System settings

- Bluetooth
  - Air Pods Pro
    - Options
      - [ ] Connect to This Mac: When Last Connected to This Mac
- General
  - Date & Time
    - [ ] 24-hour time: enable
  - Language & Region
    - [ ] Region: United States
    - [ ] Temperature: Celcius
    - [ ] Measurement system: Metric
    - [ ] First day of week: Metric
    - [ ] Date format: YYYY-MM-DD
- Desktop & Dock
  - Desktop & State Manager
    - [ ] Show Items: disable On Desktop
  - Widgets
    - [ ] Show Widgets: disable On Desktop
- Displays
  - Night Shift
    - [ ] Schedule: Sunset to Sunrise
- Menu Bar
  - [ ] Screen Mirroring: Always Show in Menu Bar
- Wallpaper
  - [ ] Dynamic Wallpapers: Tahoe
- Sound
  - [ ] Play sound on startup: disable
  - [ ] Play user interface sound effects: disable
- Privacy & Security
  - [ ] Location Services: enable
- Touch ID & Password
  - [ ] Add Fingerprint
- Keyboard
  - Keyboard shortcuts
    - Modifier keys (select both internal and external keyboards)
      - [ ] Caps Lock: Escape

### Mission Control

- [ ] Add one more space.

### Safari

- Settings
  - General
    - [ ] Safari opens with: all non-private windows from last session
  - Advanced
    - [ ] Smart search field: show full website address
    - [ ] Show features for web developers: enable
- View
  - [ ] Show Status Bar

### Amphetamine

- Settings
  - General
    - [ ] Launch Amphetamine at login: enable
