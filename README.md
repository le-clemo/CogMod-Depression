# CogMod-Depression
Modeling the effects of depression on free recall

First-year research project at the University of Groningen.

(Note: This project builds on top of Chi Sam Mac's [project](https://github.com/cs-mac/fyrp))

### Prerequisits

```
Python, version 3.6+

ACT-R, version 7.21

jupyter-notebook, version 6.1.4
```

### Getting started

You need the ACT-R environment.

Currently, the models are run using jupyter notebook.

#### Models

Two ACT-R models were created for this project. A general model and a model that incorporates rumination.

- General model - general_free_recall_model_Murdock_Roberts.lisp
- Rumination model - rumination_free_recall_model_vanVugt.lisp

#### Experiments

There are three different scripts that will run the model(s) for different experimental set ups: 
- experiment_murdock.ipynb - Murdock (1962)
- experiment_roberts.ipynb - Roberts (1972)
- experiment_vanVugt.ipynb - van Vugt et al. (2012)

### File structure

The jupyer notebooks with the experimental set up are located in the root directory.

##### models
Here you'll find the two aforementioned models and older versions. In the CSM folder the models created by Chi Sam Mac can be found.

##### word_lists
Once a word list has been created, it will be stored here.

##### results
After having run a simulation, the results are stored here. Note that if you run the same experiment with the same number of agents more than once, the results file will all end up in the same folder. This means that all of them will be used in the analyses the notebooks produce. Therefore, you should delete the specific results subfolders before running an experiment again.

### Authors

Clemens M Kaiser - [Linkedin](https://www.linkedin.com/in/clemens-kaiser-702713164/)

### Acknowledgements

- M.K. van Vugt, the supervisor for this project, for mentoring my project giving me guidance and tips
- A. Gupta, for his help and guidance with the project
- M. van der Velde for providing me with insights into his related works

