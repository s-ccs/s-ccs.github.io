# Applied Linear Mixed Models
## 2018
In this block-course we developed Generalized Linear Models and Mixed Linear Models from scratch. The idea is to 
introduce the linear model and all its encompasing tests as one coherent framework (i.e. t-test, ANOVA, ANCOVA, repeated 
measures ANOVA) and then continue with GLMs and LMMs. The mornings were two to three 1h lectures in the afternoon a 
2.5-3h exercise session (previous edition was withwith Basil Wahn)
### Lecture Slides
All slides are generated in R, thus all the plots can be easily rebuild and customized if necessary.
- [Linear Modeling](http://benediktehinger.de/glm2018/lin_reg.html) We introduce linear modeling as an overarching theme. 
  We use dummy codings, Standard Errors, 
  Confidence Intervals, Bootstrapping, the concept of “there exists only one test”,  interactions, and some 
  philosophical aspects
- [Generalized Linear Models](http://benediktehinger.de/glm2018/glm_slides.html) We discussed Logistic+Poisson 
  regression GLM. A focus is put on motivation and 
  interpretation. We reconcile all members of the GLM family and put special focus on the variance / mean assumptions
- [Linear Mixed Models](http://benediktehinger.de/glm2018/mm_slides.html) We discussed repeated measures designs 
  (within-subject) and move from there to LMMs. 
  We discuss implementation, interpretation, assumption checks. Convergence problems are discussed. 
  Random Coefficients (Intercept, Slopes, Correlations) and finally multiple random variables e.g. subjects and items.

You can find the Rpresentation source code (including code to generate 90% of graphs) for 
[GLM](https://benediktehinger.de/GLM-course2017/glm_slides.Rpres) here and for 
[LMM](https://benediktehinger.de/GLM-course2017/mm_slides.Rpres) here.
### Excercises
**Logistic regression.** Here we use the [cowles data](http://socserv.mcmaster.ca/jfox/Books/Applied-Regression-3E/datasets/) 
from John Fox’s Applied Regression Analysis Book. 
We predict whether a student will volunteer in a study or not based on sex, extraversion and neuroticism. 
An interaction is modeled and interpreted as well.
- [Logistic Regression without tipps (html)](https://benediktehinger.de/GLM-course2017/logistic_model.html)
- [Logistic Regression with tipps (html)](https://benediktehinger.de/GLM-course2017/logistic_model_help.html)
- [The cowles, logistic regression data (csv)](https://benediktehinger.de/GLM-course2017/cowles.csv)
- [Logistic Regression Solutions (html)](https://benediktehinger.de/blog/upload/logistic_exercise.html)
- [Logistic Regression Rmarkdown source (Rmd)](https://benediktehinger.de/GLM-course2017/logistic_exercise.Rmd)

Mixed Linear model. Here we use data from one of my studies to build a simple linear mixed model. We will look at 
parameter transformations, assumption tests (which fail in this case) and log-log interactions. We also have models that 
do not converge, model comparisons using likelihood-ratio tests. Finally we check whether multiple random variables are
necessary.
- [LMM without tipps (html)](https://benediktehinger.de/GLM-course2017/mixed_model.html)
- [LMM with tipps (html)](https://benediktehinger.de/GLM-course2017/mixed_model_help.html)
- [The mixed model data (csv)](https://benediktehinger.de/GLM-course2017/fixdur.csv)
- [LMM Solutions (html)](https://benediktehinger.de/blog/upload/fixdur_exercise.html)
- [LMM Rmarkdown source (Rmd)](https://benediktehinger.de/GLM-course2017/fixdur_exercise.Rmd)