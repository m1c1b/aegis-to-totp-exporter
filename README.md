# Description

There is a script for migrating from Android [totp-app](https://getaegis.app/) to macOS [totp-cli app](https://github.com/yitsushi/totp-cli) 🔄

---

# Usage

- Clone repo 📦

- Export your keys from Aegis as JSON and put it into the repo root 🗝️

- Change permissions 🔐
  ```bash
  chmod +x migrator.sh
  ```

- Create totp-cli import .yml file 📄
  ```bash
  ./migrator.sh --namespace your-namespace --json-in aegis-export-plain-***.json
  ```

- Import that file into storage 📥
  ```bash 
  totp-cli import --input output.yml
  ```

- View your imported keys 👀
  ```bash 
  totp-cli list personal
  ```
---