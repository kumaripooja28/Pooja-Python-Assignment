# Django Dockerized Assignment

A complete Django REST API application containerized with Docker Compose, featuring PostgreSQL database integration.

## Features Implemented
- **Django 5** with Django REST Framework
- **Item CRUD API** with full Create, Read, Update, Delete operations
- **PostgreSQL** database via Docker Compose
- **Automatic migrations** & superuser creation on startup
- **Admin panel** with user-friendly interface
- **Swagger API documentation** via drf-yasg
- **CORS support** for frontend integration
- **Hot-reload development** environment
- **Environment variable** configuration

## Project Structure
```
├── djangoapp/              # Django application
│   ├── project/           # Main project settings
│   │   ├── settings.py    # Django configuration
│   │   ├── urls.py        # URL routing
│   │   └── wsgi.py        # WSGI application
│   ├── items/             # Items API app
│   │   ├── models.py      # Item model
│   │   ├── views.py       # API views
│   │   ├── serializers.py # Data serialization
│   │   ├── urls.py        # App URLs
│   │   └── admin.py       # Admin configuration
│   └── manage.py          # Django management script
├── docker/
│   ├── entrypoint.sh      # Container startup script
│   └── wait-for.sh        # Database readiness check
├── Dockerfile             # Django container definition
├── docker-compose.yml     # Multi-container setup
├── requirements.txt       # Python dependencies
├── .env                   # Environment variables
└── .env.example           # Environment template
```

## Quick Start

### 1. Clone and Setup
```bash
git clone https://github.com/s2pl/RailSathiBE
cd RailSathiBE
cp .env.example .env
```

### 2. Start with Docker Compose
```bash
docker compose up --build
```

This will:
- Build the Django container
- Start PostgreSQL database  
- Run database migrations
- Create superuser `admin` with password `adminpass`
- Launch Django dev server on port 8000

### 3. Access the Application

| Service | URL | Description |
|---------|-----|-------------|
| **Items API** | `http://localhost:8000/items/` | REST API endpoints |
| **Admin Panel** | `http://localhost:8000/admin/` | Django admin interface |
| **Swagger Docs** | `http://localhost:8000/swagger/` | Interactive API documentation |
| **ReDoc** | `http://localhost:8000/redoc/` | Alternative API docs |

## API Endpoints

### Items API
- `GET /items/` - List all items
- `POST /items/` - Create new item
- `GET /items/{id}/` - Retrieve specific item  
- `PUT/PATCH /items/{id}/` - Update item
- `DELETE /items/{id}/` - Delete item

### Example Usage
```bash
# Create an item
curl -X POST http://localhost:8000/items/ \
  -H "Content-Type: application/json" \
  -d '{"name": "Laptop", "description": "Work laptop"}'

# Get all items
curl http://localhost:8000/items/
```

## Development

### Environment Variables
Configure via `.env` file:
```env
# Django Settings
DJANGO_SECRET_KEY=your-secret-key
DJANGO_DEBUG=True
DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1

# Database
POSTGRES_DB=railsathi
POSTGRES_USER=railsathi  
POSTGRES_PASSWORD=railsathi
POSTGRES_HOST=db
POSTGRES_PORT=5432

# Admin User
DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_EMAIL=admin@example.com
DJANGO_SUPERUSER_PASSWORD=adminpass
```

### Commands
```bash
# Stop containers
docker compose down

# Rebuild after changes
docker compose up --build

# View logs
docker compose logs -f

# Access Django shell
docker compose exec web python manage.py shell

# Run migrations manually
docker compose exec web python manage.py migrate
```

## Production Deployment

For production use:
1. Set `DJANGO_DEBUG=False`
2. Update `DJANGO_SECRET_KEY` 
3. Configure proper `DJANGO_ALLOWED_HOSTS`
4. Use stronger database credentials
5. Consider using `gunicorn` instead of development server

## Technology Stack
- **Backend**: Django 5.0.7 + Django REST Framework
- **Database**: PostgreSQL 15
- **API Docs**: drf-yasg (Swagger/OpenAPI)
- **Containerization**: Docker & Docker Compose
- **Development**: Hot-reload with volume mounting


