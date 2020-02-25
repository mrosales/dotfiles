dotfiles
========

## Bootstrapping a New Machine

1. Install Xcode command line tools

		xcode-select --install

2. Install Homebrew

		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

3. Create a [new SSH key for Github](https://help.github.com/en/enterprise/2.18/user/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)

		# RSA
		ssh-keygen -t rsa -b 4096 -C <EMAIL_OR_LABEL>
		pbcopy < ~/.ssh/id_rsa.pub
		
		# or ed25519
		ssh-keygen -t ed25519 -C <EMAIL_OR_LABEL>
		pbcopy < ~/.ssh/id_ed25519.pub

4. Clone this repository

		git clone git@github.com:mrosales/dotfiles.git ~/.dotfiles

5. Make sure you are logged in to the Mac App Store

6. Install applications with the included Brewfile

		cd ~/.dotfiles
		/usr/local/bin/brew bundle

7. Run the install scripts

		bash ./scripts/install

8. Run the bootstrap scripts to symlink files into place

		bash ./scripts/bootstrap.sh

9. Set your brew-installed zsh as your login shell

		echo $(brew --prefix)/bin/zsh | sudo tee -a /etc/shells
		echo $(brew --prefix)/bin/bash | sudo tee -a /etc/shells

		chsh -s $(brew --prefix)/bin/zsh

10. Open up a new shell and hopefully it works!
11. Finish up any manual installation. AFAIK this includes:
	* 1Password
	* Slack Theme
	* AWS credentials
	* OpenVPN credentials
	* Licenses for:
    	* Alfred
    	* Dash
    	* Goland
    	* Postico
    	* Bartender
  	* Restore VSCode settings (install "Settings Sync" and login with Github)
  	* Goland Theme
  	* iTerm Profile & icon
	* Create a `~/.localrc` file for local secrets