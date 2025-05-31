# Use the Ubuntu 16:04 base image
FROM ubuntu:24.10

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=dockeruser
ENV PASSWORD=password

# Update packages and install SSH server
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    sudo \
    x11vnc \
    xvfb \
    xfce4 \
    xfce4-goodies \
    xterm \
    dbus-x11 \
    openjdk-23-jdk \
    && rm -rf /var/lib/apt/lists/*

# Add a new user 'dockeruser' and set a password
RUN useradd -m -s /bin/bash $USER && \
    echo "$USER:$PASSWORD" | chpasswd

# Optional: Add the user to the sudoers to allow administrative actions
RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER

# Enable password authentication in the SSH configuration
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Optional: Disable root login via SSH
RUN echo "PermitRootLogin no" >> /etc/ssh/sshd_config

# Set VNC password
RUN mkdir -p /root/.vnc && \
    x11vnc -storepasswd $PASSWORD /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

COPY .Xresources /root/.Xresources
COPY xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

# prepare vnc start script
COPY start-vnc.sh /root/start-vnc.sh
RUN chmod +x /root/start-vnc.sh

# Expose the SSH port
EXPOSE 22
EXPOSE 5900

# Create launcher script
RUN echo '#!/bin/bash\n/root/idea/bin/idea.sh' > /root/start-intellij.sh && \
    chmod +x /root/start-intellij.sh && \
    chown $USER:$USER /root/start-intellij.sh

# Create Desktop Entry
RUN mkdir -p /root/Desktop && \
    echo "[Desktop Entry]\n\
Type=Application\n\
Name=IntelliJ IDEA Ultimate\n\
Exec=/root/start-intellij.sh\n\
Icon=/root/idea/bin/idea.png\n\
Terminal=false\n\
Categories=Development;IDE;\n\
StartupWMClass=jetbrains-idea\n\
" > /root/Desktop/intellij.desktop && \
    chmod +x /root/Desktop/intellij.desktop && \
    chown root:root /root/Desktop/intellij.desktop

# Run the vnc server
CMD ["/root/start-vnc.sh"]