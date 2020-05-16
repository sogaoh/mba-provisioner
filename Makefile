help:
	cat Makefile

all:
	brew upgrade ansible
	ansible-playbook mba-02.yml -i "localhost," -K

test:
	ansible-playbook mba-02.yml -i "localhost," -K -C -D -v    
