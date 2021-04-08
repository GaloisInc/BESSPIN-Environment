# Based on the Besspin GFE image
FROM galoisinc/besspin:gfe

# Get ready for nix install
# Adapted from https://github.com/holochain/holonix/pull/63/files
WORKDIR /

RUN apt-get update && \
    apt install -y software-properties-common && \
    apt install -y sudo xz-utils curl ssh git tar iptables && \
    adduser --disabled-password --gecos '' besspinuser && \
    adduser besspinuser sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    addgroup --system nixbld && \
    adduser besspinuser nixbld && \
    adduser besspinuser plugdev && \
    adduser besspinuser dialout

# use the besspinuser user
USER besspinuser
ENV USER besspinuser
WORKDIR /home/besspinuser

RUN mkdir /home/besspinuser/.ssh/ \
    && touch /home/besspinuser/.ssh/known_hosts \
    && ssh-keyscan github.com >> /home/besspinuser/.ssh/known_hosts

# Nix install
# disable nix sandboxing in docker
RUN mkdir -p /home/besspinuser/.config/nix && \
    echo 'sandbox = false' > /home/besspinuser/.config/nix/nix.conf

# ---------- THIS PART SHOULD BE UPDATED PRIOR TO OPEN-SOURCING ----------
# Add some configuration settings to nix.conf
RUN echo 'trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= besspin.galois.com-1:8IqXQ2FM1J5CuPD+KN9KK4z6WHve4KF3d9zGRK+zsBw=' >> /home/besspinuser/.config/nix/nix.conf && \
    echo 'substituters = https://artifactory.galois.com/artifactory/besspin_generic-nix/ https://cache.nixos.org/' >> /home/besspinuser/.config/nix/nix.conf && \
    echo 'netrc-file = /home/besspinuser/.config/nix/netrc' >> /home/besspinuser/.config/nix/nix.conf

# Set the login and APIKEY for artifactory
ARG BINCACHE_LOGIN
ARG BINCACHE_APIKEY
RUN echo 'machine artifactory.galois.com' > /home/besspinuser/.config/nix/netrc && \
    echo "login ${BINCACHE_LOGIN}" >> /home/besspinuser/.config/nix/netrc && \
    echo "password ${BINCACHE_APIKEY}" >> /home/besspinuser/.config/nix/netrc
# -----------------------------------------------------------------------

# https://nixos.wiki/wiki/Nix_Installation_Guide#Single-user_install
RUN curl -L https://nixos.org/nix/install | sh


# ---------- THIS PART SHOULD BE REMOVED PRIOR TO OPEN-SOURCING ----------
RUN sudo curl --silent https://$BINCACHE_LOGIN:$BINCACHE_APIKEY@artifactory.galois.com/artifactory/besspin_generic-nix/nix-cache-info
# -----------------------------------------------------------------------

# ---------- THIS PART SHOULD BE UPDATED PRIOR TO OPEN-SOURCING ----------
# Populate the cache & prepare a copy of FETT-target
RUN sudo mkdir /opt/SSITH-FETT-Target
RUN sudo chown besspinuser /opt/SSITH-FETT-Target
RUN --mount=type=ssh git clone git@github.com:DARPA-SSITH-Demonstrators/SSITH-FETT-Target.git /opt/SSITH-FETT-Target
WORKDIR /opt/SSITH-FETT-Target
# -----------------------------------------------------------------------

# Update Nix submodule
RUN git submodule update --init BESSPIN-Environment
# Run a dummy command to return from the shell automatically + populate the nix store
RUN . $HOME/.nix-profile/etc/profile.d/nix.sh && nix-shell --run "ls"

WORKDIR /home/besspinuser

#Cleanup the repo checkout
RUN rm -rf /opt/SSITH-FETT-Target

# Create an alias for easier nix-shell start
RUN echo "alias nix-shell=\". $HOME/.nix-profile/etc/profile.d/nix.sh && nix-shell\"" >> /home/besspinuser/.bashrc
