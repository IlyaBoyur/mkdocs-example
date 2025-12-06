# builder stage - creates static site
FROM python:3.13-slim AS builder

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y build-essential git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# copy project
COPY . /app

# install mkdocs and material theme
RUN python -m pip install --upgrade pip && \
    pip install -r requirements.txt

# build site into /srv/site
RUN mkdocs build --site-dir /srv/site

# final stage: minimal image only if you want runtime (we will use volume so we can just extract build output)
FROM alpine:3.18
RUN mkdir -p /srv/site
COPY --from=builder /srv/site /srv/site

CMD ["sleep", "infinity"]
