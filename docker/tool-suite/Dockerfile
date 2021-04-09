#syntax=docker/dockerfile-upstream:master-experimental
FROM galoisinc/besspin:gfe

# Get ready for nix install
# Adapted from https://github.com/holochain/holonix/pull/63/files

RUN apt update && \
    apt install -y software-properties-common && \
    apt install -y sudo xz-utils curl ssh git tar iptables && \
    adduser -u 1000 --disabled-password --gecos '' besspinuser && \
    adduser besspinuser sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    addgroup --system nixbld && \
    adduser besspinuser nixbld && \
    adduser besspinuser plugdev && \
    adduser besspinuser dialout

# use the besspinuser user
USER besspinuser
ENV USER besspinuser \
    # This should be updated prior to open source
    REPO_SRC="/home/besspinuser/SSITH-FETT-Target"
WORKDIR /home/besspinuser

RUN mkdir -p -m 0700 ~/.ssh \
    && ssh-keyscan github.com >> /home/besspinuser/.ssh/known_hosts \
    # https://nixos.wiki/wiki/Nix_Installation_Guide#Single-user_install
    && curl -L https://nixos.org/nix/install | sh \
    # Nix install
    # disable nix sandboxing in docker + substituters (for binary cache if used)
    && mkdir -p /home/besspinuser/.config/nix \
    && echo 'sandbox = false' > /home/besspinuser/.config/nix/nix.conf \
    && echo 'substituters = https://artifactory.galois.com/artifactory/besspin_generic-nix/ https://cache.nixos.org/' >> /home/besspinuser/.config/nix/nix.conf \
    && echo 'trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= besspin.galois.com-1:8IqXQ2FM1J5CuPD+KN9KK4z6WHve4KF3d9zGRK+zsBw=' >> /home/besspinuser/.config/nix/nix.conf \
    && echo 'netrc-file = /home/besspinuser/.config/nix/netrc' >> /home/besspinuser/.config/nix/nix.conf

# Populate the cache & prepare a copy of FETT-target
RUN --mount=type=ssh,uid=1000 \
    --mount=type=secret,id=galoisCredentialsNetrc,dst=/home/besspinuser/.config/nix/netrc,uid=1000 \
    # This should be updated prior to open source
    git clone git@github.com:DARPA-SSITH-Demonstrators/SSITH-FETT-Target.git \
    && cd $REPO_SRC \
    && git submodule update --init SSITH-FETT-Environment \
    # Run a dummy command to return from the shell automatically + populate the nix store
    # The gitlab dependency should be fixed at some time in the open source process
    && ssh-keyscan gitlab-ext.galois.com >> /home/besspinuser/.ssh/known_hosts \
    && . $HOME/.nix-profile/etc/profile.d/nix.sh \
    && nix-shell --run "ls" \
    #Cleanup the repo checkout
    && rm -rf $REPO_SRC \
    # Create an alias for easier nix-shell start
    && echo "alias nix-shell=\". $HOME/.nix-profile/etc/profile.d/nix.sh && nix-shell\"" >> /home/besspinuser/.bashrc
