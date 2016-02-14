#!/bin/sh

MISSING=""

[ -z "${COMMENT_PREFIX}" ] && MISSING="${MISSING} COMMENT_PREFIX"
[ -z "${DB_CONNECTION}" ] && MISSING="${MISSING} DB_CONNECTION"

if [ "${MISSING}" != "" ]; then
  echo "Missing required environment variables:" >&2
  echo " ${MISSING}" >&2
  exit 1
fi

TRUSTED_PROXY_IP=`getent hosts ${TRUSTED_PROXY} | awk '{print $1}'`

echo "Trusted Proxy IP: ${TRUSTED_PROXY_IP}"

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

cat <<EOF >/home/tm/production.ini
[app:main]
use = egg:osmtm
reload_templates = false
debug_authorization = false
debug_notfound = false
debug_routematch = false
debug_templates = false
default_locale_name = en

available_languages = en fr es de pt ja lt zh_TW id da pt_BR ru sl it nl_NL uk
available_languages_full = English, Français, Español, Deutsch, Português, 日本語, Lietuvos, 中文, Indonesia, Dansk, Português (Brasil), Русский, Slovenščina, Italiano, Nederlands, Українська

sqlalchemy.url = postgresql://username:password@localhost/osmtm
local_settings_path = %(here)s/local.ini

[server:main]
use = egg:waitress#main
host = 0.0.0.0
port = 6543
trusted_proxy= ${TRUSTED_PROXY_IP}

# Begin logging configuration

[loggers]
keys = root, osmtm, sqlalchemy, exc_logger

[handlers]
keys = filelog, exc_handler

[formatters]
keys = generic, exc_formatter

[logger_root]
level = WARN
handlers = filelog

[logger_osmtm]
level = WARN
handlers = filelog
qualname = osmtm

[logger_sqlalchemy]
level = WARN
handlers = filelog
qualname = sqlalchemy.engine

[logger_exc_logger]
level = ERROR
handlers = exc_handler
qualname = exc_logger

[handler_console]
class = StreamHandler
args = (sys.stderr,)
level = NOTSET
formatter = generic

[handler_filelog]
class = handlers.TimedRotatingFileHandler
args = ('%(here)s/osmtm.log','W6', 1, 3)
level = NOTSET
formatter = generic

[handler_exc_handler]
class = handlers.TimedRotatingFileHandler
args = ('%(here)s/exception.log','W6', 1, 3)
level = ERROR
formatter = exc_formatter

[formatter_generic]
format = %(asctime)s %(levelname)-5.5s [%(name)s][%(threadName)s] %(message)s

[formatter_exc_formatter]
format = %(asctime)s %(message)s

# End logging configuration)

EOF

/home/tm/env/bin/pserve production.ini
