FROM node:14.0

# locale & timezone (Asia/Tokyo)
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# system update
RUN apt-get update && \
    apt-get install -y vim less

WORKDIR /app

# install vue-cli
RUN npm install -g @vue/cli-init
RUN npm install
# RUN npm install --global firebase-tools

ENV HOST 0.0.0.0
EXPOSE 3000