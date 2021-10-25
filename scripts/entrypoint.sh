#!/bin/sh

set -e

echo "Running migrations start"
python manage.py dbwait
echo "Running migrations done"

echo "Running migrations start"
python manage.py makemigrations
echo "Running migrations done"

echo "Running migrate start"
python manage.py migrate --no-input
echo "Running migrate done"

echo "Running collect static start"
python manage.py collectstatic --noinput
echo "Running collect static done"

echo "Running command '$*'"
exec su -s /bin/sh -c "$*"

# uwsgi --socket :8000 --master --enable-threads --module app.wsgi
