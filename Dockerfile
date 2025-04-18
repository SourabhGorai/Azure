FROM alpine AS prep

ENV KOMPOSE_VERSION="v1.34.0"
ARG TARGETARCH

# Install curl to download Kompose
RUN apk add --no-cache curl

# Download Kompose binary for the architecture
RUN curl -L "https://github.com/kubernetes/kompose/releases/download/${KOMPOSE_VERSION}/kompose-linux-${TARGETARCH}" \
    -o /tmp/kompose && chmod +x /tmp/kompose


# Final stage
FROM python:3.11-alpine

# Copy Kompose from prep stage
COPY --from=prep /tmp/kompose /usr/local/bin/kompose
RUN chmod +x /usr/local/bin/kompose

# Copy uv from external image
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Set up app directory
WORKDIR /usr/src/app
COPY . .

# Create virtual environment and install dependencies
RUN python -m venv .venv && \
    uv sync --frozen

ENV PATH="/usr/src/app/.venv/bin:$PATH"

# Run Django setup
RUN python manage.py collectstatic --no-input && \
    python manage.py makemigrations && \
    python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
