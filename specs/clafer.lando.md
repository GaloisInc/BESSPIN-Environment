subsystem Clafer
  component Description Language

  component Parser
    Parse Description Language to Model

  component Validator
    Validate Model

  component Exporter
    Extract JSON description of Model

  component Configurator
    Generate Configuration States for Model

//Need to work out scenarios. Mainly some of these actions always occur together based on
//the tools command line interface.