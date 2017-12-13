# Mongodb cron restore from Google Cloud Storage (GCE)

## How To Use
```
docker run -d -e PROJECT_ID=unique_id_on_gce -e GS_ID=gs_access_key_id -e GS_SECRET=gs_secret_access_key -e MONGO_HOST=127.0.0.1:27017 -e MONGO_DATABASE=database -e MONGO_END_DATABASE=destination-database -e BUCKET=storage-bucket -e CRON_TIME="0 1 * * *" dmapper/mongodb-restore-gce
```

## Environment Variables

#### PROJECT_ID - [Demo(3)](https://storage.googleapis.com/cdn.chessboardradio.com/lab/docker-mongodb-backup-gce/get-storage-keys.png)
The project id on Google Cloud, need be the **default**.

#### GS_ID - [Demo(4)](https://storage.googleapis.com/cdn.chessboardradio.com/lab/docker-mongodb-backup-gce/get-storage-keys.png)
The **Access Key** of Interoperability session.

#### GS_SECRET - [Demo(4)](https://storage.googleapis.com/cdn.chessboardradio.com/lab/docker-mongodb-backup-gce/get-storage-keys.png)
The **Secret Key** of Interoperability session.

#### BUCKET
The bucket name

#### MONGO_HOST
The IP or domain of your Mongodb server, with the port (127.0.0.1:27017).

#### MONGO_DATABASE
Database name to restore

#### MONGO_END_DATABASE
Destination database name or a list of databases (MONGO_END_DATABASE = "db_name_1 db_name_2 db_name_3")

#### MONGO_USER
If your database need authentication, set the user of current database.

#### MONGO_PASS
Like before but for the password.

#### CRON_TIME
The **cron time**, the frequency that will restore a new backup, default is `0 1 * * *` every day at 1am (GTM).
Here is a good [cron generator](http://crontab-generator.org/).

##### Thanks a lot to https://github.com/jadsonlourenco for [docker-mongodb-backup-gce](https://github.com/jadsonlourenco/docker-mongodb-backup-gce)
