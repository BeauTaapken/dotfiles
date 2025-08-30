# dotfiles

## Read to install again
https://www.atlassian.com/git/tutorials/dotfiles

## Getting all submodules
config submodule update --init --recursive

## Updating all submodules
git submodule update --recursive --remote

### Install [yay](https://github.com/Jguer/yay?tab=readme-ov-file#installation)
### Enable crontab (need cronie or alternative if not installed)
### run yay -S - < ~/pkglist.txt (https://superuser.com/questions/1061612/how-do-you-make-a-list-file-for-pacman-to-install-from)

## Firefox installation
Download the user.js file -> go to about:profiles -> click on the default or default-release root dir -> put user.js in folder

## cronjob config
crontab -e\
\
0 23 * * * ~/shell-scripts/automatic-push-dotfiles.sh 2>&1


## enable service for FIIO auto replug
systemctl --user daemon-reload
systemctl --user enable --now replug-after-resume.service
