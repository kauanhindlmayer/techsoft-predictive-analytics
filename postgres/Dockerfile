FROM postgres:latest

ENV POSTGRES_DB=techsoft_db
ENV POSTGRES_USER=techsoft_user
ENV POSTGRES_PASSWORD=techsoft_password

COPY init/ /docker-entrypoint-initdb.d/

EXPOSE 5432