FROM python:3.11

# Set the working directory
WORKDIR /app

COPY . .

ENV PYTHONUNBUFFERED=1

# Set the entrypoint to run the script
ENTRYPOINT ["python", "-u", "main.py"]
