# Use an official Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project files
COPY . .

# Copy and set up entrypoint script
# COPY entrypoint.sh /app/entrypoint.sh
# RUN chmod +x /app/entrypoint.sh

# # Expose the port the app runs on
# EXPOSE 8000

# # Start the Django app
# CMD ["/app/entrypoint.sh"]

# Run migrations and start server
CMD ["sh", "-c", "python manage.py makemigrations && python manage.py migrate && nohup python manage.py runserver 0.0.0.0:8000 > server.log 2>&1 & tail -f server.log"]
