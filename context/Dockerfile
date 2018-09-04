# The rocker/shiny image is unversioned,
# and I never figured out the devtools install,
# so base on tidyverse instead.
FROM rocker/tidyverse:3.5.1

# Install shiny server (from https://hub.docker.com/r/rocker/shiny/~/dockerfile/)
# changes:
#   Formatting
#   -t unstable -> (remove)
#   libcairo2-dev/unstable -> libcairo2-dev
RUN apt-get update && \
    apt-get install -y \
        sudo \
        gdebi-core \
        pandoc \
        pandoc-citeproc \
        libcurl4-gnutls-dev \
        libcairo2-dev \
        libxt-dev && \
    S3=https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64 && \
	wget --no-verbose $S3/VERSION -O version.txt && \
	VERSION=$(cat version.txt) && \
	wget --no-verbose $S3/shiny-server-$VERSION-amd64.deb -O ss-latest.deb && \
	gdebi -n ss-latest.deb && \
	rm -f version.txt ss-latest.deb && \
	R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/')" && \
	rm -rf /var/lib/apt/lists/*

COPY shiny-app /srv/shiny-server/my-app/
COPY shiny-server/shiny-server.sh /usr/bin/shiny-server.sh
COPY shiny-server/shiny-server.conf /etc/shiny-server/shiny-server.conf

CMD ["/usr/bin/shiny-server.sh"]