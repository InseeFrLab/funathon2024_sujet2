FROM inseefrlab/onyxia-rstudio:r4.3.2-2024.02.13

RUN git clone https://github.com/InseeFrLab/funathon2024_sujet2 funathon2024_sujet2 && \
  cd "./funathon2024_sujet2" && \
  ls && \
  Rscript -e "renv::restore()"

# Expose port where shiny app will broadcast
ARG SHINY_PORT=3838
EXPOSE $SHINY_PORT
RUN echo "local({options(shiny.port = ${SHINY_PORT}, shiny.host = '0.0.0.0')})" >> /usr/local/lib/R/etc/Rprofile.site


# Endpoint
CMD ["Rscript", "-e", "shiny::runApp('funathon2024_sujet2')"]
