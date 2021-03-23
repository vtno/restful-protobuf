FROM node:15.4.0
COPY . .
RUN npm i
CMD ["node", "index.js"] 
