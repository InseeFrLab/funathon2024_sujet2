FROM inseefrlab/onyxia-rstudio:r4.3.2-2024.02.13

# Set the working directory
WORKDIR app

# Copy init.sh into the image
COPY init.sh .

# Ensure init.sh has execute permissions
RUN chmod +x init.sh

# Expose port where shiny app will broadcast
ARG SHINY_PORT=3838
EXPOSE $SHINY_PORT
RUN echo "local({options(shiny.port = ${SHINY_PORT}, shiny.host = '0.0.0.0')})" >> /usr/local/lib/R/etc/Rprofile.site

# Set init.sh as the entrypoint
CMD ["init.sh"]
