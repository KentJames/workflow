NIXH=~/.nixpkgs
VIMH=~/.vim
TMUXH=~/



warn() {
        echo "$1" >&2
}

die() {
        warn "$1"
        exit 1
}

[ -e "~/.vimrc" ] && die "vimrc already exists!"
[ -e "~/.tmux.conf" ] && die "tmux.conf already exists!"
[ -e "~/nixpkgs/config.nix" ] && die "config.nix already exists!"



git clone https://github.com/KentJames/workflow.git 
cd "workflow"


cp tmux/tmux.conf ~/.tmux.conf
cp vim/vimrc ~/.vimrc
cp nix/config.nix ~/.nixpkgs/config.nix
cp emacs/emacs ~/.emacs

cd "../"
echo "Cleaning up after myself.."
rm -rf workflow/


echo "Workflow Installed."
