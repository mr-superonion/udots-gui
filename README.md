# prerequisite

## Build-essential

### Arch

```shell
sudo pacman -S base-devel
```
### Debian
```shell
sudo apt-get install build-essential
```


## Dmenu

```shell
git clone https://github.com/mr-superonion/dmenu.git

cd dmenu

git checkout patched
make install
```

# Install

```shell
git clone --bare https://github.com/mr-superonion.git $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

mkdir -p config-backup
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} config-backup/{}
fi;
config checkout

config config status.showUntrackedFiles no
```

