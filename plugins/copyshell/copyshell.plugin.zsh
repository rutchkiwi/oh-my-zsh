#!/bin/zsh
echo copyshell installed
copyshell() {
	echo "zsh home:" $ZSH
	if [[ ! ARGC -eq 1 ]]; then
		echo "1 argument required, $# provided";
		exit 1;
	fi
	echo 'Setting up vhoshell shell on ' $1
	cd ~
	echo 'Transfering '$ZSH', .zshrc, .gitconfig and this script:'
	cp .zshrc .zshrc_new
	cp .gitconfig .gitconfig_new
	scp -r $ZSH .zshrc_new .gitconfig_new copy_shell_conf.sh $1:~/
	echo "We will now setup the shell via ssh."
	ssh -t $1 'if [ -f .zshrc ]; then 
	mv .zshrc .zshrc_old; 
	echo "An existing .zshrc was found. It was moved to .zshrc_old"
	fi;
	mv .zshrc_new .zshrc;
	if [ -f .gitconfig ]; then 
	mv .gitconfig .gitconfig_old; 
	echo "An existing .gitconfig was found. It was moved to .gitconfig_old"
	fi;
	mv .gitconfig_new .gitconfig;
	echo "Changing the default shell to ZSH";
	chsh -s /bin/zsh'
	rm .zshrc_new .gitconfig_new
}

copyshell fff

# Transfering .oh-my-zsh, .zshrc, .gitconfig and this script:
# :~/: No such file or directory
# We will now setup the shell via ssh.
# ssh: Could not resolve hostname if [ -f .zshrc ]; then
# 	mv .zshrc .zshrc_old;
# 	echo "An existing .zshrc was found. It was moved to: nodename nor servname provided, or not known
# /Users/viktor/oh-my-zsh-fork/plugins/copyshell/copyshell.plugin.zsh:22: parse error near `}'

#no gitconfig