#!/bin/sh
set -e

# Optional: wait for DB (uncomment if you're using a DB service like PostgreSQL/MySQL)
# echo "Waiting for database..."
# until nc -z db 5432; do
#   echo "Database not ready, waiting..."
#   sleep 2
# done

echo "Applying migrations..."
python manage.py makemigrations
python manage.py migrate

echo "Collecting static files..."
python manage.py collectstatic --noinput

exec gunicorn product.wsgi:application --bind 0.0.0.0:8000 --workers 3
