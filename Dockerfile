FROM node
WORKDIR /export
RUN npm install resume-cli

WORKDIR /home/user

ENTRYPOINT [ "node", "/export/node_modules/resume-cli/index.js" ]
