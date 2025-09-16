#!/usr/bin/env bash
set -e

# Default values
: "${DJANGO_MANAGE_DIR:=djangoapp}"
: "${DJANGO_SUPERUSER_USERNAME:=admin}"
: "${DJANGO_SUPERUSER_EMAIL:=admin@example.com}"
: "${DJANGO_SUPERUSER_PASSWORD:=adminpass}"

python -c "import os; print('Python version:', os.sys.version)"

echo "Waiting for database ${POSTGRES_HOST}:${POSTGRES_PORT}..."
/wait-for.sh ${POSTGRES_HOST:-db}:${POSTGRES_PORT:-5432} -- echo "Database is up"

if [ -d "$DJANGO_MANAGE_DIR" ]; then
  cd $DJANGO_MANAGE_DIR
fi

if [ -f manage.py ]; then
  echo "Applying migrations..."
  python manage.py migrate --noinput

  echo "Creating superuser (if not exists)..."
  python manage.py shell <<EOF
import os
from django.contrib.auth import get_user_model
User = get_user_model()
username = os.environ.get('DJANGO_SUPERUSER_USERNAME')
email = os.environ.get('DJANGO_SUPERUSER_EMAIL')
password = os.environ.get('DJANGO_SUPERUSER_PASSWORD')
if not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username=username, email=email, password=password)
    print('Superuser created')
else:
    print('Superuser already exists')
EOF

  echo "Starting development server..."
  python manage.py runserver 0.0.0.0:8000
else
  echo "manage.py not found. Sleeping."
  exec "$@"
fi
