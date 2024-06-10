ARG BASE_IMAGE=inseefrlab/onyxia-rstudio
FROM $BASE_IMAGE

# Clone repository
RUN git clone https://github.com/InseeFrLab/funathon2024_sujet2 .

WORKDIR /funathon2024_sujet2


RUN "Rscript -e 'renv::restore()'"

# Expose port where shiny app will broadcast
ARG SHINY_PORT=3838
EXPOSE $SHINY_PORT
RUN echo "local({options(shiny.port = ${SHINY_PORT}, shiny.host = '0.0.0.0')})" >> /usr/local/lib/R/etc/Rprofile.site

# Endpoint
CMD ["Rscript", "-e", "myshinyapp::runApp()"]