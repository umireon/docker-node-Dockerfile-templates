FROM node
RUN apt-get update && apt-get install -y \
    tini \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["/usr/bin/tini", "--"]
USER node
WORKDIR /home/node
ENV NODE_ENV=production
COPY --chown=node:node package.json package-lock.json ./
RUN npm install && npm cache clean --force
COPY --chown=node:node index.ts ./
CMD ["node_modules/.bin/ts-node", "index.ts"]
