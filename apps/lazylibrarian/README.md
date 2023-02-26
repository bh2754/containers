# sonarr

## Custom environment configuration

This container support setting certain custom enviroment variables with the use of [drone/envsubst](https://github.com/drone/envsubst).

| Name                            | Default             |
|---------------------------------|---------------------|
| LAZYLIBRARIAN__LOG_DIR          | `/config/log`       |
| LAZYLIBRARIAN__BOOK_DIR         | `/books`            |
| LAZYLIBRARIAN__DOWNLOAD_DIR     | `/downloads`        |
