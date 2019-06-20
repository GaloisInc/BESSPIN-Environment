# User Interface

## Domain Model
```
subsystem Overview UI
  indexing
    owner: Ben Razet <benoit.razet@galois.com>
    contributors:

  View of the different models present in the Database,
  with links to other UI elements. Implemented in overview.html.

  component Table
    Show models with info?
    Show link tasks for models?
    Search models! // @todo BenRazet
    Sort models by criteria! // @todo BenRazet identify which criteria
    Delete model! // @todo BenRazet

  component Model Adder
    Select text model from local files!
    Add selected model to system!


subsystem Model Configurator UI
  indexing
    owner: Ben Razet <benoit.razet@galois.com>
    contributors:

  View of the different elements to configure a model.
  Implemented as configurator.html.
  component Current Model
  component Graphical Visualizer
    Graphical representation of feature model?
    Change feature selection with rotation click!
  component Textual Visualizer
    Textual representation of feature model?
  component Undo Button
    Undo selection!
  component Redo Button
    Redo selection!
  component Validate Button
    Run configurator/validation algorithm on configured model!
  component Download Button
    Download configured model?

  component Branch Button
    // @todo BenRazet just an idea for improving UX
    Save current feature model and start new one with same state!
  component Build Evaluation Button
    // @note BenRazet not sure yet where this button will be and what it will do.

subsystem Test Configurator inherits Configurator UI
  // @note @todo BenRazet need to confirm that this is an element of the pipeline.


subsystem MOOV
  indexing
    owner: Ben Razet <benoit.razet@galois.com>
    contributors:

  // @note @todo BenRazet this is a giant TODO, the components are from Clafer MOOV
  // We might consider merging it with the Configurator UI
  Multiple Objective Optimizer Visualizer for feature models.
  The main functionality is to explore sets of configurations.

  component Current Model

  component Optimize
    Optimize the model!
    Visualize result of optimize?

  component Constraint Editor
    Constraint the range of feature.
    Select feature.

  component Instance Visualizer
    Table of instances?


subsystem Dashboard
  indexing
    owner: Ben Razet <benoit.razet@galois.com>
    contributors:

  UI elements to view the build pipeline and to view the results of the evaluation

  compoment Build Evaluation Visual
    Display info about Build process for model?

  component Evaluation Metrics Visual
    Display metrics related to model?
```

## Events

```
Configurator UI Events

event new_model_chosen A model is chosen from the local filesystem.
event old_model_chosen A previously known model is chosen from the list of known models in the system.
event start_configure_pressed Button to start configuring new model is pressed.
event continue_configure_pressed Button continue configuring model is pressed.
event feature_selected A feature is selected.
event feature_configured A feature is configured.
event validate_light_up Button validate is light up, indicating it can be pressed.
event validate_pressed Button validate is pressed.
event validate_inactive Button validate is inactive, indicating it cannot be pressed.
event undo_pressed Button undo is pressed.
event redo_pressed Button redo is pressed.
event download_pressed Button download is pressed.
```

## Scenarios

```
scenarios BESSPIN UI

scenario Load New Feature Model.
0- Starting from the Configuration UI.
1- Select a new model from local filesystem.
2- Confirm selection and start configure model.
3- Interactively configure model.
4- Validate and Save the configuration.

scenario Continue Configuration.
0- Starting from the Overview UI.
1- Select a model from table. UI is changed to Configuration UI.
2- Interactively configure model.
4- Validate and Save the configuration

scenario View Model Dashboard.
0- Starting from the Overview UI.
1- Select a model from table. UI is changed to Dashboard UI.
2- View info.

scenario Download Configured Model.
0- Starting from the Configurator UI.
1- Click on the Download Button.
2- Choose destination.
3- Confirm.
```