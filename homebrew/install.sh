# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

if [ "${SYS_ARCH:-Linux}" != Darwin ] ; then return ; fi

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" > /tmp/homebrew-install.log
fi

echo "Homebrew installer running."

function brew_install {
  local name=`echo $1 | sed -e 's/Caskroom\/cask\///g'`
  local v=$(brew ls --versions $name)
  local c=$(brew cask list | grep "$name")
  if [ -z "$v$c" ]; then
    brew install $1 
  else
    echo "$1 is already installed"
  fi
}

brew tap caskroom/versions
brew tap homebrew/science
brew tap homebrew/dupes

# Install homebrew packages
export lst=$(dirname $0)/packages
for i in `cat $lst`; do brew_install "$i" ; done
exit 0
