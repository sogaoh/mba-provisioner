all:
	brew upgrade ansible
	ansible-playbook mba-02.yml -i "localhost," -K

test:
	ansible-playbook mba-02.yml -i "localhost," -K -C -D -v


packages:
	ansible-playbook mba-02.yml -i "localhost," --tags=packages

zsh:
	ansible-playbook mba-02.yml -i "localhost," --tags=zsh -K

dot:
	ansible-playbook mba-02.yml -i "localhost," --tags=dotfiles

py3:
	ansible-playbook mba-02.yml -i "localhost," --tags=python3


hosts:
	ansible-playbook hosts.yml -i "localhost," --tags=hosts -K

ma:
	ansible-playbook mackerel.yml -i "localhost," -e @variables.yaml --tags=mackerel -K 


help:
	cat Makefile
