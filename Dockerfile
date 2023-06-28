#FROM kasmweb/core-ubuntu-jammy:1.13.0
ARG BASE_TAG="develop"
ARG BASE_IMAGE="core-ubuntu-jammy"
FROM kasmweb/$BASE_IMAGE:$BASE_TAG
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# INSTALL MAPTOOL
COPY ./src/maptool/install-maptool.sh $INST_SCRIPTS/maptool/
COPY ./src/maptool/maptool-Maptool.desktop $HOME/Desktop/
COPY ./src/xdg-utils/scripts/ $INST_SCRIPTS/xdg-utils/scripts/
RUN bash $INST_SCRIPTS/maptool/install-maptool.sh && rm -rf $INST_SCRIPTS/maptool/
RUN echo "/usr/bin/desktop_ready && /opt/maptool/bin/MapTool &" > $STARTUPDIR/custom_startup.sh && chmod +x $STARTUPDIR/custom_startup.sh

# Update the desktop environment to be optimized for a single application
RUN cp $HOME/.config/xfce4/xfconf/single-application-xfce-perchannel-xml/* $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/
RUN cp /usr/share/extra/backgrounds/bg_kasm.png /usr/share/extra/backgrounds/bg_default.png
RUN apt-get remove -y xfce4-panel

######### End Customizations ###########

RUN chown 1000:0 $HOME
#RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
