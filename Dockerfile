# syntax=docker/dockerfile:1.3-labs
FROM node
RUN <<EOF
apt-get update
apt-get install -y \
  tini
apt-get clean
rm -rf /var/lib/apt/lists/*
EOF
ENTRYPOINT ["/usr/bin/tini", "--"]
USER node
WORKDIR /home/node
COPY --chown=node:node package.json package-lock.json ./
RUN npm install --production && npm cache clean --force
COPY --chown=node:node index.ts ./
CMD ["node_modules/.bin/ts-node", "index.ts"]
