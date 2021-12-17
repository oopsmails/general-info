FROM node:alpine

WORKDIR /nodejsapp

EXPOSE 3000 9229

CMD ["npm", "start"]

COPY package*.json ./
RUN npm install

COPY . .
