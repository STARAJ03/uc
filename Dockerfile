#FROM python:3.9.7-slim-buster
FROM python:3.10.8-slim

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app/
RUN pip3 install --no-cache-dir --upgrade -r requirements.txt

RUN pip3 install pytube

RUN pip3 install yt-dlp

RUN pip3 install cloudscraper

RUN pip3 install Pillow
RUN pip3 install beautifulsoup4


ENV COOKIES_FILE_PATH="/app/youtube_cookies.txt"

#CMD ["python3", "modules/main.py"]
CMD gunicorn app:app & python3 main.py
