#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
files="vimrc vim zshrc xvimrc"    # list of files/folders to symlink in homedir

##########

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

#  creating symlinks 
for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
