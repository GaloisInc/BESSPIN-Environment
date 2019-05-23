package myconfig

import freechips.rocketchip.config.Config

class MyConfig extends Config(
  new galois.system.P1Config
)
