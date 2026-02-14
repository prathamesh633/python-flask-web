FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]


# Here we are writing COPY command in 2 layers (5th and 9th line) because
# it is a good practice to separate the installation of dependencies from the application code.
# if we write COPY . . in one layer, it will invalidate the cache for all layers
# whenever we change any file in the application code, even if the dependencies remain the same.
# This will lead to longer build times.
