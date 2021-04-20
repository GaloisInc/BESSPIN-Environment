# Get GFE image
FROM galoisinc/besspin:gfe

# Copy all the files over 
ADD Xilinx_Vivado_SDK_2018.3_1207_2324.tar.gz \
    install_config_full.txt \
    Xilinx_HW_Server_Lin_2018.3_1207_2324.tar.gz \
    install_config_hw.txt \
    /

# Vivado designer
RUN cd /Xilinx_Vivado_SDK_2018.3_1207_2324 \
    && ./xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --batch Install --config ../install_config_full.txt \
    # Cleanup
    && rm -rf /Xilinx_Vivado_SDK_2018* /install_config_full.txt \
    # Install HW server
    && cd /Xilinx_HW_Server_Lin_2018.3_1207_2324 \
    && ./xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --batch Install --config ../install_config_hw.txt \
    # Cleanup
    && rm -rf /Xilinx_HW_Server_Lin_2018.3_1207_2324* /install_config_hw.txt \
    # Install cable drivers
    && mkdir -p /etc/udev/rules.d \
    && cd /opt/Xilinx/Vivado/2019.1/data/xicom/cable_drivers/lin64/install_script/install_drivers/ \
    && ./install_drivers \
    # Make Vivado available for all users
    && echo "source /opt/Xilinx/Vivado/2018.3/settings64.sh" | tee -a /etc/bash.bashrc

# Set the license
ADD Xilinx.lic /opt/Xilinx/Xilinx.lic
ENV XILINXD_LICENSE_FILE="/opt/Xilinx/Xilinx.lic" \
    PATH="/opt/Xilinx/Vivado/2018.3/bin/:${PATH}"

