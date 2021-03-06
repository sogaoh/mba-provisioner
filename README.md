# mba-provisioner
my PC (MacBook Air) provisioner

## Prerequisite
- macOS Catalina ~  (zsh)

- **Allow full access to terminal.app**
  - System Environment Settings -> Security & Privacy 

- Install Homebrew 
  ```zsh
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  ```

- Install Ansible
  ```zsh
  brew update
  brew install python ansible
  ```

- Clone this repository
  ```zsh
  git clone git@github.com:sogaoh/mba-provisioner.git
  ```

- Set `variables.yaml` (If run `make ma`)
  ```
  mackerel_agent_apikey: "<your_key>"
  ```

- Create `/etc/hosts` symbolic link 
  ```zsh
  sudo mv /private/etc/hosts /private/etc/hosts.org
  touch ~/.config/hosts
  sudo ln -snf ~/.config/hosts /private/etc/hosts
  ``` 


## Usage

- That's all  
  `make`

- Dry run  
  `make test`

- Only packages install/update  
  `make packages`

- etc...
  - `make ma`    # Mackerel Agent
  - `make hosts` # Add hosts 
  - `make dot`
  - `make zsh`
  - `make py3`   # Update Python3 via pyenv ... not work ...


## Note 
- Commands
  - rebuild zcompdump -> `rm -f ~/.zcompdump; compinit`
  - clear DNS cache -> `sudo killall -HUP mDNSResponder`


## References
- https://github.com/j-un/osx-provisioner
- https://github.com/ucan-lab/dotfiles
- [Mac を買ったら必ずやっておきたい初期設定 - Qiita](https://qiita.com/ucan-lab/items/c1a12c20c878d6fb1e21) / by [@ucan-lab](https://qiita.com/ucan-lab) 2020.05.11
- [Macの開発環境をzshで良い感じにする](https://qiita.com/bake0937/items/79e350a474c1cd60a5e0)
- [お前らのターミナルはダサい](https://qiita.com/kinchiki/items/57e9391128d07819c321)
- https://github.com/Arc0re/Iceberg-iTerm2
- https://github.com/sorin-ionescu/prezto
- https://github.com/sindresorhus/pure/blob/master/pure.zsh <- https://github.com/sorin-ionescu/prezto/tree/master/modules/prompt/external
- https://github.com/zsh-users/zsh-completions#manual-installation
- [Mac の DNS キャッシュ をクリアするコマンド](https://blog.77jp.net/command-to-clear-dns-cache-on-mac)


