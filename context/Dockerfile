FROM rocker/shiny:3.5.1
	
RUN	R -e "install.packages(c('rjson'), repos='https://cran.rstudio.com/')"

COPY shiny-app /srv/shiny-server/shiny-app/
COPY shiny-server/shiny-server.conf /etc/shiny-server/shiny-server.conf
COPY shiny-server/shiny-server.sh /usr/bin/shiny-server.sh
