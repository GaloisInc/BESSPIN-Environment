#syntax=docker/dockerfile-upstream:master-experimental
FROM galoisinc/besspin:tool-suite

# Environment
ENV PATH="/home/besspinuser/.local/bin:${PATH}"\
    # # these are for sqlalchemy migration support
    LC_ALL=C.UTF-8\
    LANG=C.UTF-8\
    # have the flask server run on port 3784
    PORT=3784\
    # BESSPIN_CLAFER
    BESSPIN_CLAFER=/home/besspinuser/.local/bin/clafer

# expose the port
EXPOSE 3784

# Dependencies
RUN sudo apt install -y sqlite3

# clafer
RUN git clone https://github.com:GaloisInc/BESSPIN-clafer.git clafer \
    && cd clafer \
    && git checkout besspin-v1.0 \
    && curl -sSL https://get.haskellstack.org/ | sh \
    && stack install clafer

# Besspin-ui repo
RUN git clone https://github.com:GaloisInc/BESSPIN-UI.git ui \
    && cd ui \
    && git checkout besspin-v1.0 \
    && pip3 install -r server/requirements.txt \
    && . $HOME/.nix-profile/etc/profile.d/nix.sh

WORKDIR /home/besspinuser/ui

CMD ["scripts/entrypoint.sh"]
