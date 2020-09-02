FROM rocker/binder:4.0.2
LABEL maintainer='Mauro Lepore'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}



RUN wget https://github.com/2degreesinvesting/r2dii.banks/raw/tutorials/DESCRIPTION && R -e "options(repos = list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2020-09-02/')); devtools::install_deps()"

RUN R -e "install.packages('shiny')";
RUN rm DESCRIPTION.1; exit 0
