
# User specific environment and startup programs

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

#if [[ ${TERM} == "screen-bce" || ${TERM} == "screen" ]]
#then
# precmd () { print -Pn "\033k\033\134\033k[%1d]\033\134" }
#  preexec () { print -Pn "\033k\033\134\033k[$1]\033\134" }
#else
#  precmd () { print -Pn "\e]0;%n@%m: %~\a" }
#  preexec () { print -Pn "\e]0;%n@%m: $1\a" }
#fi
#PS1=$'%{\e[0;32m%}%m%{\e[0m%}:%~> '
#export PS1


#################### changing colors for ls and file completion ################
# export MY_LS_COLORS="LS_COLORS_NORM"  #  export MY_LS_COLORS="LS_COLORS_BOLD"
# or define your own, say: export LS_COLORS_DARK='...'
#                          export MY_LS_COLORS="LS_COLORS_DARK"
# before you source this file. For color codes see # coloring matters # in this file

# You can tune the behavior of this file with the following config knobs:
# OVERRIDE_EDITOR="your favorite editor" # set several editing prefs at once
# AUTO_TITLE_SCREENS="NO"                # (or "YES") to turn screen auto-titling on or off
# LONG_TITLE="YES"                       # Set a longer title, including host and more path
# IGNORE_APOLLO_1="NO"                   # Allows /apollo_1 to be used for tab completions, default to ignoring it
# FORCE_USE_OPT_AMAZON="YES"             # Enable all references to /opt/amazon
PROMPT_COLOR="${PROMPT_COLOR:-cyan}"     # Set the prompt color; defaults to cyan
export GREP_COLOR="${GREP_COLOR:-1;35}"  # Set the color for grep matches

if [[ -e /etc/zshenv ]];
then
  source /etc/zshenv
fi

if [[ -e /etc/zshrc ]];
then
  source /etc/zshrc
fi
#################### important zsh vars & common env vars ############
#
# Notes on the PATH varaible:
#   ENV_IMPROVEMENT_ROOT/bin should be early in the path, so that
#   it can override the /opt/third-party/bin paths
#
#   Since BrazilTools is deployed with the environment, we need to put
#   /apollo/env/SDETools/bin/ before the ROOT/bin since we want to pick up the
#   devtools-deployed versions first
#
#   Also we need /opt/third-party/bin in front of /usr/bin in order to get perl
#   to be /opt/third-party/bin

path=(                                     \
       ${JUMBO_ROOT}/opt/gcc46/bin         \
       /home/tools/tools/svn/1.6.5/64/bin  \
       /home/tools/tools/scmtools/usr/bin  \
       /home/tools/tools/maven/apache-maven-2.2.0/bin \
       /home/tools/tools/ant/apache-ant-1.6.5/bin \
       /home/tools/tools/ant/apache-ant-1.7.1/bin \
       /home/tools/tools/php/5.2.17/64/bin \
       /home/tools/tools/java/jdk1.6.0_20/bin \
       /home/tools/tools/vim/7.2/64/bin/   \
       ~/bin                               \
       ~/usr/bin                           \
       /home/tools/bin/64                  \
       /usr/local/bin                      \
       /usr/bin                            \
       /bin                                \
       /usr/sbin                           \
       /sbin                               \
       /usr/local/sbin                     \
       /usr/X11R6/bin                      \
       /usr/X11/bin                        \
     )

if [ -d "/home/tools/tools" ]; then
	PATH=/home/tools/tools/svn/1.6.5/64/bin:/home/tools/tools/scmtools/usr/bin:/home/tools/tools/../bin/64/:/home/tools/tools/maven/apache-maven-2.2.0/bin:/home/tools/tools/ant/apache-ant-1.6.5/bin:/home/tools/tools/ant/apache-ant-1.7.1/bin:/home/tools/tools/php/5.2.17/64/bin:$PATH
	MANPATH=:/tools/baidu_manpage/man
	JAVA_HOME_1_5=/home/tools/tools/java/jdk1.5.0_07
	JAVA_HOME_1_6=/home/tools/tools/java/jdk1.6.0_20
	ANT_HOME=/home/tools/tools/ant/apache-ant-1.6.5
	ANT_HOME_1_7=/home/tools/tools/ant/apache-ant-1.7.1
	MAVEN_2_2_1=/home/tools/tools/maven/apache-maven-2.2.1/bin
	MAVEN_3_0_4=/home/tools/tools/maven/apache-maven-3.0.4/bin
	MAC=64
	export JAVA_HOME_1_5 ANT_HOME JAVA_HOME_1_6 ANT_HOME_1_7 MAVEN_2_2_1 MAVEN_3_0_4 PATH MANPATH MAC
fi

if [[ -e ~/.jumbo/etc/bashrc ]];
then
  source ~/.jumbo/etc/bashrc
fi

LD_LIBRARY_PATH=~/lib:$LD_LIBRARY_PATH

# a sane default prompt, most people will override this
autoload colors
colors
PS1="%{${fg[$PROMPT_COLOR]}%}%B%n@%m] %b%{${fg[default]}%}"   # a nice colored prompt
RPROMPT="%{${fg[$PROMPT_COLOR]}%}%B%(7~,.../,)%6~%b%{${fg[default]}%}"

if [ "x$AUTO_TITLE_SCREENS" '!=' "xNO" ]
then

  # if you are at a zsh prompt, make your screen title your current directory
  precmd ()
  {
    local TITLE="$(/bin/basename $PWD)"
    if [[ "$LONG_TITLE" == "YES" ]]; then
      TITLE="`/bin/hostname | sed 's/.amazon.com//'`:`echo $PWD | sed 's/src\/appgroup\/[^\/]*\/[^\/]*/.../'`"
    fi
    if [[ "$TERM" == "screen" ]]; then
      echo -ne "\ek$TITLE\e\\"
    fi
    if [[ "$TERM" == "xterm" ]]; then
      echo -ne "\e]0;$TITLE\a"
    fi
  }

  # if you are running a command, make your screen title the command you're
  # running
  preexec ()
  {
    local CMD=${1/% */}  # kill all text after and including the first space
    if [[ "$TERM" == "screen" ]]; then
      echo -ne "\ek$CMD\e\\"
    fi
    if [[ "$TERM" == "xterm" ]]; then
      echo -ne "\e]0;$CMD\a"
    fi
  }

fi

if [ "x$OVERRIDE_EDITOR" = "x" ]
then
  OVERRIDE_EDITOR="vim" # default to vim, so we don't surprise anyone
fi
export EDITOR="$OVERRIDE_EDITOR"   # programs will use this by default if you need to edit something
export VISUAL="$EDITOR" # some programs use this instead of EDITOR
export PAGER=less   # less is more :)

#################### coloring matters ########################
# Color codes: 00;{30,31,32,33,34,35,36,37} and 01;{30,31,32,33,34,35,36,37}
# are actually just color palette items (1-16 in gnome-terminal profile)
# your pallette might be very different from color names given at (http://man.he.net/man1/ls)
# The same LS_COLORS is used for auto-completion via zstyle setting (in this file)
# 
export LS_COLORS_BOLD='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.tex=01;33:*.sxw=01;33:*.sxc=01;33:*.lyx=01;33:*.pdf=0;35:*.ps=00;36:*.asm=1;33:*.S=0;33:*.s=0;33:*.h=0;31:*.c=0;35:*.cxx=0;35:*.cc=0;35:*.C=0;35:*.o=1;30:*.am=1;33:*.py=0;34:'
export LS_COLORS_NORM='no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:do=00;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.mpg=00;35:*.mpeg=00;35:*.avi=00;35:*.fli=00;35:*.gl=00;35:*.dl=00;35:*.xcf=00;35:*.xwd=00;35:*.ogg=00;35:*.mp3=00;35:*.wav=00;35:*.tex=00;33:*.sxw=00;33:*.sxc=00;33:*.lyx=00;33:*.pdf=0;35:*.ps=00;36:*.asm=0;33:*.S=0;33:*.s=0;33:*.h=0;31:*.c=0;35:*.cxx=0;35:*.cc=0;35:*.C=0;35:*.o=0;30:*.am=0;33:*.py=0;34:'
export MY_LS_COLORS="${MY_LS_COLORS:-LS_COLORS_BOLD}"
eval export LS_COLORS=\${$MY_LS_COLORS}

######################### aliases ####################################
#Don't alias grep until after sourcing the files above, could get bad version
#of grep that doesn't understand --color
alias grep='nocorrect grep --color=auto'

alias ls='ls --color=auto'
alias ll='ls -lh'

######################### key bindings ###############################
#set zsh key binding options
#case "$EDITOR" in
#  vi|vim|gvim)
#    bindkey -v  # VI is better than Emacs
#    ;;
#  emacs|xemacs)
#    bindkey -e  # Emacs is better than VI
#    ;;
#esac
#bindkey "^R" history-incremental-search-backward
#bindkey "^A" beginning-of-line
#bindkey "^E" end-of-line

bindkey -e

#AWESOME...
#pushes current command on command stack and gives blank line, after that line
#runs command stack is popped
bindkey "^t" push-line-or-edit

# VI editing mode is a pain to use if you have to wait for <ESC> to register.
# This times out multi-char key combos as fast as possible. (1/100th of a
# second.)
KEYTIMEOUT=1

######################### zsh options ################################
setopt ALWAYS_TO_END           # Push that cursor on completions.
setopt AUTO_NAME_DIRS          # change directories  to variable names
setopt AUTO_PUSHD              # push directories on every cd
setopt NO_BEEP                 # self explanatory

######################### history options ############################
setopt EXTENDED_HISTORY        # store time in history
setopt HIST_EXPIRE_DUPS_FIRST  # unique events are more usefull to me
setopt HIST_VERIFY             # Make those history commands nice
setopt INC_APPEND_HISTORY      # immediatly insert history into history file
HISTSIZE=16000                 # spots for duplicates/uniques
SAVEHIST=15000                 # unique events guarenteed
HISTFILE=~/.history

######################### completion #################################
# these are some (mostly) sane defaults, if you want your own settings, I
# recommend using compinstall to choose them.  See 'man zshcompsys' for more
# info about this stuff.

# The following lines were added by compinstall

#zstyle ':completion:*' completer _expand _complete _approximate
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
#zstyle ':completion:*' menu select=long
#zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
#zstyle ':completion:*' use-compctl true

#autoload -U compinit
#compinit
# End of lines added by compinstall

