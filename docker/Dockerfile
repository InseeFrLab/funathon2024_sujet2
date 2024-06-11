FROM inseefrlab/onyxia-rstudio:r4.3.2-2024.02.13

# Add files necessary for the running app
ADD global.R .
ADD ui.R .
ADD server.R .
ADD sources.yml .
ADD renv.lock .
ADD renv .
ADD R R/

# Expose port where shiny app will broadcast
ARG SHINY_PORT=3838
EXPOSE $SHINY_PORT
RUN echo "local({options(shiny.port = ${SHINY_PORT}, shiny.host = '0.0.0.0')})" >> /usr/local/lib/R/etc/Rprofile.site

RUN Rscript -e "renv::restore()"

# Endpoint
CMD ["Rscript", "-e", "shiny::runApp()"]
