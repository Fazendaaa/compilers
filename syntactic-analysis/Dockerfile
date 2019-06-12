FROM archlinux/base
LABEL authors="Fazendaaa"

##
## Creating a new system user
##
COPY ./mirrorlist ./
COPY ./pacman.conf ./
RUN cp ./mirrorlist /etc/pacman.d/mirrorlist
RUN cp ./pacman.conf /etc/pacman.conf
RUN rm ./mirrorlist ./pacman.conf
RUN pacman -Syu --noconfirm
RUN pacman -S pacman-contrib --noconfirm
RUN cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
RUN rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
# Adding  new  mirror  and  raking  them before running any heavy install due to
# performance
RUN pacman -S base-devel --noconfirm
RUN useradd -m image
# This  modified  sudoers  file contains a new line that will remove the need to
# configure  the  first  time  running  "sudo" prompt to allow its usage -- that
# cli "be sure of what you are doing" 
COPY ./sudoers ./
RUN cp ./sudoers /etc/sudoers
RUN sudo visudo --check
RUN rm sudoers
USER image

##
## Configuring everthing needed in the system 
##
RUN sudo pacman -S git --noconfirm
# Only  breaking  a  part  go  installation process due to its larger size, wich
# takes quite some time to install and, sometimes, fails
RUN sudo pacman -S go --noconfirm

##
## Starting user config
##
WORKDIR /home/image/
RUN git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si --noconfirm

##
## Add here any new package
##
# RUN sudo pacman -S packageOne packageTwo packageThree ... packageN --noconfirm
# RUN yay -S packageOne packageTwo packageThree ... packageN --noconfirm
RUN sudo pacman -S bison --noconfirm

##
## Just a last verification
##
RUN sudo pacman -Syu --noconfirm
RUN yay -Syu --aur --noconfirm
