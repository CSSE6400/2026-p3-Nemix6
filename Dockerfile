# Using python base image v3.13.
# More efficient than using a base ubuntu image then adding in python dependencies
FROM python:3.13-slim

# Install pipx
RUN apt-get update && apt-get install -y pipx
RUN pipx ensurepath

# Install poetry
RUN pip3 install poetry

# Setting the working directory
WORKDIR /app

# Install all poetry dependencies
COPY pyproject.toml ./
RUN pipx run poetry install --no-root

# Copy application into container
COPY todo todo

CMD ["bash", "-c", "sleep 10 && pipx run poetry run flask --app todo run \
   --host 0.0.0.0 --port 6400"]



