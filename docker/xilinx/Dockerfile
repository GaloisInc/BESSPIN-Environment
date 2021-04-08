# Build on top of which image
ARG BASE
FROM ${BASE}

# Install Vivado lab
ADD Xilinx_Vivado_Lab_Lin_2019.1_0524_1430.tar.gz /
ADD install_config_vivado.txt /

RUN cd /Xilinx_Vivado_Lab_Lin_2019.1_0524_1430 && ./xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms \
    --batch Install --config ../install_config_vivado.txt

RUN rm -rf /Xilinx_Vivado_Lab_Lin_2019.1_0524_1430*

# Install HW server
ADD Xilinx_HW_Server_Lin_2019.1_0524_1430.tar.gz /
ADD install_config_hw.txt /

RUN cd /Xilinx_HW_Server_Lin_2019.1_0524_1430 && ./xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms \
    --batch Install --config ../install_config_hw.txt
RUN rm -rf /Xilinx_HW_Server_Lin_2019.1_0524_1430*

# Install cable drivers
RUN mkdir -p /etc/udev/rules.d
RUN cd /opt/Xilinx/Vivado_Lab/2019.1/data/xicom/cable_drivers/lin64/install_script/install_drivers/ && ./install_drivers

# Make Vivado Lab available for all users
RUN echo "source /opt/Xilinx/Vivado_Lab/2019.1/settings64.sh" | tee -a /etc/bash.bashrc
