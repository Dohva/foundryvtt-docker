FROM node:20-alpine3.20 AS base
WORKDIR /usr/local/app

FROM base AS build
WORKDIR /usr/local/app
COPY ./zip .

RUN apk add unzip
RUN unzip temp.zip
RUN rm temp.zip


FROM base AS production
RUN adduser -D foundry
WORKDIR /home/foundry
RUN mkdir foundryvtt
RUN mkdir foundrydata
COPY --from=build . ./foundryvtt
RUN su foundry

CMD node foundryvtt/usr/local/app/resources/app/main.js --dataPath=/foundrydata
