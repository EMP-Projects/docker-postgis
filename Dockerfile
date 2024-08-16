FROM postgis/postgis:16-3.4

WORKDIR /pg_cron 
RUN git clone https://github.com/citusdata/pg_cron.git
# Ensure pg_config is in your path, e.g.
RUN export PATH=/usr/pgsql-16/bin:$PATH
RUN make && sudo PATH=$PATH make install

RUN echo "shared_preload_libraries='pg_cron'" >> /usr/share/postgresql/postgresql.conf
RUN echo "cron.database_name='postgres'" >> /usr/share/postgresql/postgresql.conf

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d
COPY ./update-postgis.sh /usr/local/bin
