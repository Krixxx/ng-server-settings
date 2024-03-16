FROM postgres:latest

ENV POSTGRES_PASSWORD=mysecretpassword

RUN mkdir -p /var/lib/postgresql/data

RUN chown -R postgres:postgres /var/lib/postgresql/data

VOLUME /var/lib/postgresql/data

EXPOSE 5432
