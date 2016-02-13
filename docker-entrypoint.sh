#!/bin/sh

MISSING=""

[ -z "${COMMENT_PREFIX}" ] && MISSING="${MISSING} COMMENT_PREFIX"
[ -z "${DB_CONNECTION}" ] && MISSING="${MISSING} DB_CONNECTION"

if [ "${MISSING}" != "" ]; then
  echo "Missing required environment variables:" >&2
  echo " ${MISSING}" >&2
  exit 1
fi

cat <<EOF >/home/tm/local.ini
[app:main]
sqlalchemy.url = ${DB_CONNECTION}
default_comment_prefix = ${COMMENT_PREFIX}
EOF

if [ -z "$INIT_DB" ]; then
  echo "Not initializing DB"
else
  echo "initializing DB"
   /home/tm/env/bin/initialize_osmtm_db
fi

/home/tm/env/bin/pserve --reload development.ini
