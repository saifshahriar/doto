#   _________  _____  .______________
#  /   _____/ /  _  \ |   \_   _____/  Author:   Saif Shahriar
#  \_____  \ /  /_\  \|   ||    __)    Web:      https://saifshahriar.github.io/
#  /        /    |    |   ||     \     GitHub:   https://github.com/saifshahriar
# /_______  \____|__  |___|\___  /     GitLab:   https://gitlab.com/saifshahriar
#         \/        \/         \/      License:  MIT
#
# My advance fish shell configuration file. Up to date and much things should
# work.

### Compilation flags ###
set -gx ARCHFLAGS "-arch x86_64"

###########################################
###            EXPORT                   ###
###########################################
set fish_greeting                       # Suppresses fish's intro message.

set -gx PLAN9 /opt/plan9
alias 9="$PLAN9/bin/9"
set -gx SBASE /opt/sbase
alias sl="$SBASE/bin/sbase-box"

# XDG stuff rules
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_RUNTIME_DIR /run/user/(id -u)

set -gx ANDROID_HOME "$XDG_DATA_HOME"/android/sdk
set -gx ANDROID_USER_HOME "$XDG_DATA_HOME"/android
set -gx BAT_THEME "gruvbox-dark"
set -gx BUN_INSTALL "$XDG_DATA_HOME/bun"
set -gx CALCHISTFILE "$XDG_CACHE_HOME"/calc_history
set -gx CARGO_HOME "$XDG_DATA_HOME"/cargo
set -gx CLAUDE_CONFIG_DIR "$XDG_CONFIG_HOME"/claude
set -gx DOTNET_CLI_HOME "$XDG_DATA_HOME"/dotnet
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME"/docker
set -gx ELINKS_CONFDIR "$XDG_CONFIG_HOME"/elinks
set -gx GNUPGHOME "$XDG_DATA_HOME"/gnupg
set -gx GOPATH "$XDG_DATA_HOME"/go
set -gx GOROOT "/usr/local/go"
set -gx GRADLE_USER_HOME "$XDG_DATA_HOME"/gradle
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
set -gx LESSHISTFILE "$XDG_STATE_HOME"/less/history
set -gx MAXIMA_USERDIR "$XDG_CONFIG_HOME"/maxima
set -gx NIMBLE_DIR "$XDG_DATA_HOME"/nimble
set -gx NVIM_NOTTYFAST 1
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME"/node_repl_history
set -gx NPM_CONFIG_CACHE "$XDG_CACHE_HOME"/npm
set -gx NPM_CONFIG_INIT_MODULE "$XDG_CONFIG_HOME"/npm/config/npm-init.js
set -gx NPM_CONFIG_TMP "$XDG_RUNTIME_DIR"/npm
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME"/npm/npmrc
set -gx MASON_DIR "$XDG_DATA_HOME"/nvim/mason
set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME"/pass
set -gx PSQL_HISTORY "$XDG_STATE_HOME"/psql_history
set -gx PYTHONSTARTUP "$XDG_CONFIG_HOME"/python/pythonrc
set -gx RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set -gx R_HISTFILE "$XDG_CACHE_HOME"/Rhistory
set -gx SCREENRC "$XDG_CONFIG_HOME"/screen/screenrc
set -gx SQLITE_HISTORY "$XDG_CACHE_HOME"/sqlite_history
set -gx STACK_XDG 1
set -gx TYPST_INSTALL "$XDG_DATA_HOME"/typst
set -gx W3M_DIR "$XDG_DATA_HOME"/w3m
set -gx XCURSOR_PATH /usr/share/icons:"$XDG_DATA_HOME"/icons
set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

if test (basename (tty 2>/dev/null)) = "0"
	set -gx TERM "xterm-256color"
	set -gx COLORTERM truecolor
end

if type -q brave
	set -gx BROWSER "brave"
else if type -q brave-browser
	set -gx BROWSER "brave-browser"
else if type -q firefox
	set -gx BROWSER "firefox"
end

type -q nvim && set -gx EDITOR "nvim" || set -gx EDITOR "vim"
type -q pcmanfm && set -gx FILEMANAGER "pcmanfm"
type -q doas && set prevesc doas || set prevesc sudo

###########################################
###       ADDING TO THE PATH            ###
###########################################
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive && fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/Applications/{,flutter/bin,opencode/bin} \
	$MASON_DIR/bin/ \
	/opt/shutil/bin/ \
	/usr/local/texlive/2025/bin/x86_64-linux/ \
	$XDG_DATA_HOME/{bun,cargo,go,nimble,typst}/bin \
	$ANDROID_HOME/{cmdline-tools/latest/bin,platform-tools,emulator} \
	$fish_user_paths

###########################################
###            SET MANPAGER             ###
###########################################
### Uncomment only one of these!
### "bat" as manpager
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
### "vim" as manpager
# set -x MANPAGER '/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
### "nvim" as manpager
set -x MANPAGER "nvim +Man!"

function 9man
	9 man $argv | nvim +Man!
end

function slman
	man "$SBASE/man/$argv".1 | nvim +Man!
end

###########################################
###           SET EITHER DEFAULT        ###
###         EMACS MODE OR VI MODE       ###
###########################################
function fish_user_key_bindings
	fish_vi_key_bindings
	fish_default_key_bindings -M insert
	fish_vi_key_bindings --no-erase insert
	bind -M insert '!' bind_bang
	bind -M insert '$' bind_dollar
end

###########################################
###  CURSOR SHAPE IN DIFFERENT VI MODE  ###
###########################################
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

###########################################
###   AUTOCOMPLETE && HIGHLIGHT COLORS  ###
###########################################
# Dracula Color Palette
set -l foreground f8f8f2
set -l selection 44475a
set -l comment 6272a4
set -l red ff5555
set -l orange ffb86c
set -l yellow f1fa8c
set -l green 50fa7b
set -l purple bd93f9
set -l cyan 8be9fd
set -l pink ff79c6

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $purple
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $cyan
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment
set -g fish_color_cancel $red --reverse
set -g fish_color_option $orange
set -g fish_color_status $red

# Default Prompt Colors
set -g fish_color_cwd $green
set -g fish_color_host $purple
set -g fish_color_host_remote $purple
set -g fish_color_user $cyan

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_background
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection
set -g fish_pager_color_selected_prefix $cyan
set -g fish_pager_color_selected_completion $foreground
set -g fish_pager_color_selected_description $comment
set -g fish_pager_color_secondary_background
set -g fish_pager_color_secondary_prefix $cyan
set -g fish_pager_color_secondary_completion $foreground
set -g fish_pager_color_secondary_description $comment

###########################################
###               PROMPT                ###
###########################################
function fish_prompt --description 'Write out the prompt'
	set -l last_pipestatus $pipestatus
	set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

	# implement git stuff if you wish to
	#if not set -q __fish_git_prompt_show_informative_status
	#    set -g __fish_git_prompt_show_informative_status 1
	#end
	#if not set -q __fish_git_prompt_hide_untrackedfiles
	#    set -g __fish_git_prompt_hide_untrackedfiles 1
	#end
	#if not set -q __fish_git_prompt_color_branch
	#    set -g __fish_git_prompt_color_branch magenta --bold
	#end
	#if not set -q __fish_git_prompt_showupstream
	#    set -g __fish_git_prompt_showupstream informative
	#end
	#if not set -q __fish_git_prompt_color_dirtystate
	#    set -g __fish_git_prompt_color_dirtystate blue
	#end
	#if not set -q __fish_git_prompt_color_stagedstate
	#    set -g __fish_git_prompt_color_stagedstate yellow
	#end
	#if not set -q __fish_git_prompt_color_invalidstate
	#    set -g __fish_git_prompt_color_invalidstate red
	#end
	#if not set -q __fish_git_prompt_color_untrackedfiles
	#    set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
	#end
	#if not set -q __fish_git_prompt_color_cleanstate
	#    set -g __fish_git_prompt_color_cleanstate $green --bold
	#end

	set -l color_cwd
	set -l suffix
	if functions -q fish_is_root_user; and fish_is_root_user
		if set -q fish_color_cwd_root
			set color_cwd $fish_color_cwd_root
		else
			set color_cwd $fish_color_cwd
		end
		set suffix '#'
	else
		set color_cwd $fish_color_cwd
		set suffix '󰡜'
	end

	# PWD
	set_color $fish_color_user
	echo -n (whoami)
	set_color normal
	echo -n "@"
	set_color $fish_color_host
	echo -n (cat /etc/hostname)
	echo -n " "
	set_color normal
	set_color $color_cwd
	echo -n (prompt_pwd)
	set_color normal

	printf '%s ' (fish_vcs_prompt)

	set -l status_color (set_color $fish_color_status)
	set -l statusb_color (set_color --bold $fish_color_status)
	set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
	echo -n $prompt_status
	set_color normal

	if test $__fish_last_status -eq 0
		printf "%s󰡜%s " (set_color $fish_color_host) (set_color normal)
	else
		printf "%s✘%s " (set_color --bold $fish_color_status) (set_color normal)
	end
	#echo -n "$suffix "
end

###########################################
###          CUSTOM FUNCTIONS           ###
###########################################
# Functions needed for !! and !$
function bind_bang
	switch (commandline -t)[-1]
		case "!"
			commandline -t -- $history[1]
			commandline -f repaint
		case "*"
			commandline -i !
	end
end

function bind_dollar
	switch (commandline -t)[-1]
		case "!"
			commandline -f backward-delete-char history-token-search-backward
		case "*"
			commandline -i '$'
	end
end

# Function for extracting different files
# TODO: This function has some problem, fix needed
function ex
	switch $argv
		case *.tar.bz2
			tar xjf $argv       ;;
		case *.tar.gz
			tar xzf $argv       ;;
		case *.bz2
			bunzip2 $argv       ;;
		case *.rar
			unrar x $argv       ;;
		case *.gz
			gunzip $argv        ;;
		case *.tar
			tar xf $argv        ;;
		case *.tbz2
			tar xjf $argv       ;;
		case *.tgz
			tar xzf $argv       ;;
		case *.zip
			unzip $argv         ;;
		case *.Z
			uncompress $argv    ;;
		case *.7z
			7z x $argv          ;;
		case *.deb
			ar x $argv          ;;
		case *.tar.xz
			tar xf $argv        ;;
		case *.tar.zst
			unzstd $argv        ;;
		case *
			echo "'$argv' cannot be extracted via ex" ;;
	end
	set_color normal
end

# Function for nvim | bat as helper
function h
	$argv --help | bathelp
	# $argv --help | nvim +Man!
end

# Delete all binaries in the current directory
function rmbin
	if test (basename "$PWD") = "cp"
		find . -type f -executable -delete
		echo "Binaries deleted in the 'cp' directory."
	else
		echo "Do you want to delete all the binaries from the current directory? [y/n]"
		read -n 1 response
		echo

		if test "$response" = "y" -o "$response" = "Y"
			find . -type f -executable -delete
			echo "Binaries deleted."
		else
			echo "Operation canceled."
		end
	end
end

# pkgx
function use
	set f (echo $argv | cut -d'@' -f1)
	alias $f="pkgx $argv"
end

# zoxide
function zl
	z (zoxide query -l $argv | fzf --preview 'eza -a --color=always {}' --preview-window=right:60%:wrap)
end

###########################################
###               ALIASES               ###
###########################################
### Filesystem
alias ..="cd .."
alias mkdir="mkdir -pv"

alias adb='HOME="$XDG_DATA_HOME"/android adb'

# Use eza instead of ls.
if type -q eza
	alias l="eza -al --color=always --icons --group-directories-first"
	alias ls="eza -al --color=auto --icons --group-directories-first"
	alias la="eza -a --color=auto --group-directories-first"
	alias ll="eza -l --color=auto --group-directories-first"
	alias lt="eza -aT --color=always --icons --group-directories-first"
	alias l.='eza -a | egrep "^\."'
else
	alias l="ls -Alh --color=auto --group-directories-first"
	alias ls="ls -Alh --color=auto --group-directories-first"
end

alias lf="lfcd"

# If you are coming from CMD. I mean no one does that, but I like these commands.
alias cls="clear"
alias del="rm -rfv"

# Always confirm before overwriting something && verbose mode.
if type -q advcp
	alias cp="advcp -gRv"
else
	alias cp="cp -v"
end

if type -q advmv
	alias mv="advmv -gv"
else
	alias mv="mv -v"
end

alias ln="ln -v"
alias rm="rm -v"

### Programs
# Bat alias
if type -q bat
	alias bat='bat --pager="less -FR --RAW-CONTROL-CHARS --quit-if-one-screen --mouse" --map-syntax "*.ino:C++"  --map-syntax h:cpp'
	abbr -ag bman batman
	alias bgrep='batgrep -S'
	alias bathelp='bat --plain --language=help'
end

# cal command wont highlight current date
alias cal="ncal -b"

# grep alias. Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias rg='rg -p'
alias ip='ip --color=auto'

# Devour (https://github.com/salman-abedin/devour)
#if type -q devour
#	alias pcmanfm="devour pcmanfm"
#	alias thunar="devour thunar"
#	alias firefox="devour firefox"
#	alias brave="devour brave"
#	alias sxiv="devour sxiv"
#end

# editor
alias edit='echo "$EDITOR is currently set as your default editor. If you want to change it, then edit the fish config file at $HOME/.config/fish/config.fish"; $EDITOR'
abbr -ag v  nvim
abbr -ag vi vim

# file manager
type -q $FILEMANAGER && abbr -ag f $FILEMANAGER

# media
# Watch anime:
abbr -ag    ani ani-cli
alias anic='ani-cli -c'             # continue watching anime
# youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

# get fastest mirrors
if type -q reflector
	alias mirrorbd="$prevesc reflector -c Bangladesh >> /etc/pacman.d/mirrorlist"
	alias mirror="$prevesc reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
	alias mirrord="$prevesc reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
	alias mirrors="$prevesc reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
	alias mirrora="$prevesc reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"
end

# adding flags
alias df='df -h'                    # human-readable sizes
alias free='free -m'                # show sizes in MB

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Merge Xresources
alias loadxrdb="xrdb -load ~/.Xresources && xrdb -merge ~/.cache/wal/colors.Xresources"
alias merxrdb="xrdb -merge ~/.Xresources"

# git
abbr -ag ga         git add .
abbr -ag gcl        git clone
abbr -ag gcm        git commit -m \"
abbr -ag gam        git commit -am \"
abbr -ag gd         git diff
abbr -ag gp         git push
abbr -ag gpr        git pull --rebase
abbr -ag gff        git merge --ff-only
abbr -ag gs         git status
abbr -ag pull       git pull origin
abbr -ag push       git push origin
abbr -ag tag        git tag
abbr -ag newtag     git tag -a
abbr -ag lg         lazygit

# zathura
abbr -ag zat   zathura

# zoxide
abbr -ag z-    z -
abbr -ag zz    z -

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# tokei
type -q tokei && abbr -ag tk "tokei --hidden ."
# wget
alias wget="wget --hsts-file="$XDG_DATA_HOME"/wget-hsts"
alias a2c="aria2c -x16 -s16"

### Package aliases
if type -q apt
	# abbr -ag update     $prevesc apt update
	# abbr -ag upgrade    $prevesc apt upgrade
	# abbr -ag sysup      $prevesc apt update && $prevesc apt upgrade
	# abbr -ag install    $prevesc apt install
	# abbr -ag remove     $prevesc apt remove
	# abbr -ag autoremove $prevesc apt autoremove
	# abbr -ag cleanup    $prevesc apt remove && $prevesc apt autoremove
else if type -q xbps-install
	abbr -ag xbi        $prevesc xbps-install
	abbr -ag xbr        $prevesc xbps-remove
	abbr -ag xbq        $prevesc xbps-query
else if type -q pacman
	abbr -ag pac        $prevesc pacman
	abbr -ag pacs       $prevesc pacman -S
	abbr -ag install    $prevesc pacman -S
	abbr -ag pacsyy     $prevesc pacman -Syy
	abbr -ag pacsyu     $prevesc pacman -Syu            # update only standard pkgs
	abbr -ag pacsyyu    $prevesc pacman -Syyu           # Refresh pkglist & update standard pkgs
	abbr -ag pacr       $prevesc pacman -R
	abbr -ag pacrns     $prevesc pacman -Rns
	abbr -ag cleanup    $prevesc pacman -Rns (pacman -Qtdq)     # Removes orphan packages
	abbr -ag pacunlock  $prevesc rm /var/lib/pacman/db.lck      # remove pacman lock
	if type -q yay
		abbr -ag yays       yay -S
		abbr -ag yaysua     yay -Sua --noconfirm            # update only AUR pkgs (yay)
		abbr -ag yaysyu     yay -Syu --noconfirm            # update standard pkgs && AUR pkgs (yay)
	else if type -q paru
		abbr -ag parsua     paru -Sua --noconfirm           # update only AUR pkgs (paru)
		abbr -ag parsyu     paru -Syu --noconfirm           # update standard pkgs && AUR pkgs (paru)
	end
end

alias pkg="doas pacstall"

###########################################
###               LOAD                  ###
###########################################
### Run zoxide | The rust replacement for cd ###
type -q zoxide && zoxide init fish | source
### Set up fzf key bindings
type -q fzf && fzf --fish | source
### SETTING THE STARSHIP PROMPT ###      # NOTE: This might slow down the prompt.
# type -q starship && starship init fish | source

########################################### Run these programs whenever the
###             STARTUP                 ### shell starts. NOTE: This may slow
########################################### down the shell during startup.
# colorscript random
# fastfetch
# pfetch
