FROM python:3.11-slim

WORKDIR /setup
COPY requirements.txt .
RUN pip install -r requirements.txt

WORKDIR /copilot
# Commented out for local dev
# COPY ./*.py .
# COPY ./*.txt .
CMD ["python", "copilot.py"]