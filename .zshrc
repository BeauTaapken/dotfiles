# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/opt/cuda/bin/:$PATH:$HOME/go/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
. ~/.config/aliasrc

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="avit"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=()

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

export EDITOR=nvim
export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.local/share/Steam"
export NVD_BACKEND="direct"
export MOZ_DISABLE_RDD_SANDBOX="1"
export LIBVA_DRIVER_NAME="nvidia"

# Added by Toolbox App
export PATH="$PATH:/home/beau/.local/share/JetBrains/Toolbox/scripts"

#TODO: uncomment again if needed to fix steam screensaver, seems to only have been an issue in x11, so maybe this can be removed to prevent some stupid ERROR log things in wine
export SDL_VIDEO_ALLOW_SCREENSAVER=1

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# NOTE: this is for fcitx
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export CLUTTER_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=fcitx

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

ollama-code() {
    local model=${1:-devstral-small-2}

    export HOME=/mnt/980-evo
    export OLLAMA_MODELS=/mnt/980-evo/.ollama/models
    export CUDA_VISIBLE_DEVICES=0
    
    if pgrep -f "ollama serve" > /dev/null; then
        echo "✅ Using existing Ollama server"
        SERVER_ALREADY_RUNNING=true
    else
        echo "🚀 Starting Ollama server..."
        ollama serve > /tmp/ollama.log 2>&1 &
        SERVER_PID=$!
        echo "   Server started with PID: $SERVER_PID"
        
        echo "   Waiting for server to initialize..."
        sleep 3
        
        if ! curl -s http://localhost:11434/api/tags > /dev/null; then
            echo "❌ Server failed to start. Check /tmp/ollama.log"
            return 1
        fi
        echo "✅ Server is ready!"
        SERVER_ALREADY_RUNNING=false
    fi
    
    echo ""
    echo "🤖 Running model: $model"
    echo "   (Type /bye or Ctrl+D to exit)"
    echo "----------------------------------------"
    ollama run "$model"
    
    echo "----------------------------------------"
    echo "✅ Model session ended."
    
    if [ "$SERVER_ALREADY_RUNNING" = false ]; then
        echo ""
        pkill -f "ollama serve"
        echo "   Server stopped"
    else
        echo "   (Leaving pre-existing server running)"
    fi
}
