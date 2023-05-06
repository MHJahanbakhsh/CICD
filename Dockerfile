# Build Phase(temporary container to create build version of the app):
FROM node:19.3-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# /app/build <--this path in container will have all the stuff we care about

#--------------------each FROM statement is responsible for a block-------------------------------------------------------- 

# Run Phase:    
FROM nginx
# we copy just the stuff we care about
# <define step> <source folder of that step> <destination folder of NGINX> 
COPY --from=builder /app/dist /usr/share/nginx/html 

