FROM python:3.11-slim-buster

# Create a directory for package lists and set permissions
RUN mkdir -p /var/lib/apt/lists/partial && chmod a+rw /var/lib/apt/lists/partial

WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt requirements.txt
RUN apt-get update && \
    apt-get install -y libmupdf-dev && \
    # pip install -r requirements.txt
    pip install --no-cache-dir -r requirements.txt

# Copy your app code
COPY . /app

# Expose the port (replace with the correct port if needed)
EXPOSE 8080

ENV PORT=8080 

# Start the app using waitress-serve
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]
