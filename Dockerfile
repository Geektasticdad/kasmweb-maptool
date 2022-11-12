FROM kasmweb/core-ubuntu-focal:1.11.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# INSTALL MAPTOOL
RUN wget https://github.com/RPTools/maptool/releases/download/1.10.2/maptool_1.10.2-amd64.deb \
    && apt-get update \
    && apt-get install -y ./maptool_1.10.2-amd64.deb \
    && cp /opt/maptool/lib/maptool-MapTool.desktop $HOME/Desktop/ \
    && chmod +x $HOME/Desktop/maptool-MapTool.desktop \
    && chown 1000:1000 $HOME/Desktop/maptool-MapTool.desktop

RUN echo "/usr/bin/desktop_ready && /opt/maptool/bin/MapTool &" > $STARTUPDIR/custom_startup.sh && chmod +x $STARTUPDIR/custom_startup.sh


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
