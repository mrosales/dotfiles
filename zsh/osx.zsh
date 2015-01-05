# Exit if not OSX
if [ "${SYS_ARCH:-Linux}" != Darwin ] ; then return ; fi

#shows/hides hidden files in finder
alias showf='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias hidef='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'

alias cask='brew cask'
