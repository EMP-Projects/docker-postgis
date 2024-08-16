FROM postgis/postgis:16-3.4

RUN apt-get -y update
RUN apt-get -y --no-install-recommends install git build-essential postgresql-16-cron

RUN echo "shared_preload_libraries='pg_cron'" >> /var/lib/postgresql/postgresql.conf
RUN echo "cron.database_name='postgres'" >> /var/lib/postgresql/postgresql.conf

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d
COPY ./update-postgis.sh /usr/local/bin
