FROM kasmweb/core-ubuntu-jammy:1.13.0
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
export PATH=$PATH:$INST_SCRIPTS/xdg-utils/scripts
RUN bash $INST_SCRIPTS/maptool/install-maptool.sh && rm -rf $INST_SCRIPTS/maptool/

### Install Tools
COPY ./src/ubuntu/install/tools $INST_SCRIPTS/tools/
RUN bash $INST_SCRIPTS/tools/install_tools_deluxe.sh && rm -rf $INST_SCRIPTS/tools/

# Install Utilities
COPY ./src/ubuntu/install/misc $INST_SCRIPTS/misc/
RUN bash $INST_SCRIPTS/misc/install_tools.sh && rm -rf $INST_SCRIPTS/misc/

# Install Google Chrome
COPY ./src/ubuntu/install/chrome $INST_SCRIPTS/chrome/
RUN bash $INST_SCRIPTS/chrome/install_chrome.sh  && rm -rf $INST_SCRIPTS/chrome/

# Install Firefox
COPY ./src/ubuntu/install/firefox/ $INST_SCRIPTS/firefox/
COPY ./src/ubuntu/install/firefox/firefox.desktop $HOME/Desktop/
RUN bash $INST_SCRIPTS/firefox/install_firefox.sh && rm -rf $INST_SCRIPTS/firefox/

### Install Thunderbird
COPY ./src/ubuntu/install/thunderbird $INST_SCRIPTS/thunderbird/
RUN bash $INST_SCRIPTS/thunderbird/install_thunderbird.sh  && rm -rf $INST_SCRIPTS/thunderbird/

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
