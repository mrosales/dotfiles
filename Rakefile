require 'rake'
require 'fileutils'

desc "Hook our dotfiles into system-standard positions."
task :install => [:submodule_init, :submodules] do
  puts
  puts "======================================================"
  puts "Welcome to CF .files Installation."
  puts "======================================================"
  puts

  install_homebrew if RUBY_PLATFORM.downcase.include?("darwin")
  install_rvm_binstubs

  file_operation(Dir.glob('**/*.symlink'))


  install_fonts if RUBY_PLATFORM.downcase.include?("darwin")

  install_term_theme if RUBY_PLATFORM.downcase.include?("darwin")

  # apply_osx_performance_toggle if RUBY_PLATFORM.downcase.include?("darwin")

  append_ssh_config_for_speed_n_efficiency

  success_msg("installed")
end

 task :update do
   Rake::Task["install"].execute
 end

task :submodule_init do
  unless ENV["SKIP_SUBMODULES"]
    run %{ git submodule update --init --recursive }
  end
end

desc "Init and update submodules."
task :submodules do
  unless ENV["SKIP_SUBMODULES"]
    puts "======================================================"
    puts "Downloading cf .files submodules...please wait"
    puts "======================================================"

    run %{
      cd $HOME/.dotfiles
      git submodule update --recursive
      git clean -df
    }
    puts
  end
end


task :default => 'install'


private
def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def install_rvm_binstubs
  puts "======================================================"
  puts "Installing RVM Bundler support. Never have to type"
  puts "bundle exec again! Please use bundle --binstubs and RVM"
  puts "will automatically use those bins after cd'ing into dir."
  puts "======================================================"
  run %{ chmod +x $rvm_path/hooks/after_cd_bundler }
  puts
end

def install_homebrew
  run %{which brew}
  unless $?.success?
    puts "======================================================"
    puts "Installing Homebrew, the missing OSX package manager...If it's"
    puts "already installed, this will do nothing."
    puts "======================================================"
    puts ""
    puts "======================================================"
    puts "Homebrew installation is not script friendly right now"
    puts "Press [ENTER]"
    puts "======================================================"
    run %{ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/master/install)"}
  end

  puts
  puts
  puts "======================================================"
  puts "Updating Homebrew."
  puts "======================================================"
  run %{brew update}
  puts
  puts
  puts "======================================================"
  puts "Installing Homebrew some essential packages...There may be some warnings."
  puts "======================================================"
  run %{brew install zsh git tmux reattach-to-user-namespace fasd }
  puts "======================================================"
  puts "Putting up LaunchAgent that will do brew update automatically"
  puts "======================================================"
  run %{ cp com.cloudfactory.dotfiles.brewupdate.plist ~/Library/LaunchAgents/ }
  puts
  puts
end

def install_fonts
  puts ""
  puts "======================================================"
  puts "Installing patched fonts for Powerline/Lightline."
  puts "======================================================"
  run %{ cp -f $HOME/.dotfiles/fonts/* $HOME/Library/Fonts }
  puts ""
end

def add_iterm_theme
  run %{ /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'material-dark-mhr' dict" ~/Library/Preferences/com.googlecode.iterm2.plist }
  run %{ /usr/libexec/PlistBuddy -c "Merge 'iterm2/material-dark-mhr.itermcolors' :'Custom Color Presets':'material-dark-mhr'" ~/Library/Preferences/com.googlecode.iterm2.plist }
end

def install_term_theme
  puts "======================================================"
  puts "Installing iTerm2 theme."
  puts "======================================================"


  # If iTerm2 is not installed or has never run, we can't autoinstall the profile since the plist is not there
  if !File.exists?(File.join(ENV['HOME'], '/Library/Preferences/com.googlecode.iterm2.plist'))
    puts "======================================================"
    puts "To make sure your profile is using the solarized theme"
    puts "Please check your settings under:"
    puts "Preferences> Profiles> [your profile]> Colors> Load Preset.."
    puts "======================================================"
    puts ""
    return
  end

  # Ask the user which theme he wants to install
  message = "Which theme would you like to apply to your iTerm2 profile?[Dark Theme is recommended]"
  color_scheme = ask message, iTerm_available_themes
  color_scheme_file = File.join('iTerm2', "#{color_scheme}.itermcolors")

  # Ask the user on which profile he wants to install the theme
  profiles = iTerm_profile_list
  message = "I've found #{profiles.size} #{profiles.size>1 ? 'profiles': 'profile'} on your iTerm2 configuration, which one would you like to apply the Solarized theme to?"
  profiles << 'All'
  selected = ask message, profiles

  if selected == 'All'
    (profiles.size-1).times { |idx| apply_theme_to_iterm_profile_idx idx, color_scheme_file }
  else
    apply_theme_to_iterm_profile_idx profiles.index(selected), color_scheme_file
  end
  # puts ""
  # puts "Calling up OSX handy 'open' on the file...just press OKAY"
  # run %{ open "$HOME/.dotfiles/iterm2/Solarized Dark.itermcolors" }
  # puts ""
end

def iTerm_available_themes
   Dir['iterm2/*.itermcolors'].map { |value| File.basename(value, '.itermcolors')}
end

def iTerm_profile_list
  profiles=Array.new
  begin
    profiles <<  %x{ /usr/libexec/PlistBuddy -c "Print :'New Bookmarks':#{profiles.size}:Name" ~/Library/Preferences/com.googlecode.iterm2.plist 2>/dev/null}
  end while $?.exitstatus==0
  profiles.pop
  profiles
end

def ask(message, values)
  puts message
  while true
    values.each_with_index { |val, idx| puts " #{idx+1}. #{val}" }
    selection = STDIN.gets.chomp
    if (Float(selection)==nil rescue true) || selection.to_i < 0 || selection.to_i > values.size+1
      puts "ERROR: Invalid selection.\n\n"
    else
      break
    end
  end
  selection = selection.to_i-1
  values[selection]
end

def want_to_install? (section)
  if ENV["ASK"]=="true"
    puts "Would you like to install configuration files for: #{section}? [y]es, [n]o"
    STDIN.gets.chomp == 'y'
  else
    true
  end
end

def file_operation(files, method = :symlink)
  files.each do |f|
    file = f.split('/').last.chomp('.symlink')
    source = "#{ENV["PWD"]}/#{f}"
    target = "#{ENV["HOME"]}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exists?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %{ mv "$HOME/.#{file}" "$HOME/.#{file}.backup" }
    end

    if method == :symlink
      run %{ ln -nfs "#{source}" "#{target}" }
    else
      run %{ cp -f "#{source}" "#{target}" }
    end

    puts "=========================================================="
    puts
  end
end

def apply_theme_to_iterm_profile_idx(index, color_scheme_path)
  values = Array.new
  16.times { |i| values << "Ansi #{i} Color" }
  values << ['Background Color', 'Bold Color', 'Cursor Color', 'Cursor Text Color', 'Foreground Color', 'Selected Text Color', 'Selection Color']
  values.flatten.each { |entry| run %{ /usr/libexec/PlistBuddy -c "Delete :'New Bookmarks':#{index}:'#{entry}'" ~/Library/Preferences/com.googlecode.iterm2.plist } }

  run %{ /usr/libexec/PlistBuddy -c "Merge '#{color_scheme_path}' :'New Bookmarks':#{index}" ~/Library/Preferences/com.googlecode.iterm2.plist }
end

def apply_osx_performance_toggle
  puts "=============================================================================="
  puts "Running OSX hidden Performance toggles that are very very useful to developers"
  puts "=============================================================================="
  run %{ $HOME/.dotfiles/osx_hidden_preftoggle }
end

def append_ssh_config_for_speed_n_efficiency
  puts "=============================================================================="
  puts "Prepending SSH configuration onto your ssh_config file"
  puts "=============================================================================="
  run %{ timestamp=$(date +%s) && cat $HOME/.dotfiles/ssh/config $HOME/.ssh/config > /tmp/ssh_config_$timestamp && mv -f /tmp/ssh_config_$timestamp $HOME/.ssh/config }
end


def success_msg(action)
  puts ""
  puts "       _                 _  __            _"
  puts "   ___| | ___  _   _  __| |/ _| __ _  ___| |_ ___  _ __ _   _"
  puts "  / __| |/ _ \| | | |/ _` | |_ / _` |/ __| __/ _ \| '__| | | |"
  puts " | (__| | (_) | |_| | (_| |  _| (_| | (__| || (_) | |  | |_| |"
  puts "  \___|_|\___/ \__,_|\__,_|_|  \__,_|\___|\__\___/|_|   \__, |"
  puts "                                                        |___/.FILES"
  puts ""
  puts "CF.files has been #{action}. Please restart your terminal"
  puts ""
  puts ""
  puts ""
  puts "========================================================================="
  puts "Please be sure to populate your git config in ~/.gitconfig.user and ...."
  puts "make sure you checkout ~/.secret for easySSH integration"
  puts "========================================================================="

end
