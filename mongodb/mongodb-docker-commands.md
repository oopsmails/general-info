
# MongoDB Commands

Using MongoDB Backup and Restore Tools

sudo docker logs mongodb

sudo docker logs -f --tail 100 container-name

sudo docker logs -f --tail 100 mongodb


sudo docker exec -it mongodb bash

mongodump -h sample.mongodbhost.com:27017 -d DATABASE_NAME -u USER_NAME -p SAMPLE_PASSWORD -o ~/Desktop

mongorestore --host sample.mongohost.com --port 27017 --username USER_NAME --password SAMPLE_PASSWORD --db DATABASE_NAME .

mongorestore --host localhost --port 27017 --username root --password root --db elm .

## ELM

docker cp /dev/elm/elm-db-bk mongodb:/elm-db-bk

sudo docker cp ~/Documents/dev/elm/elm-db-bk mongodb:/elm-db-bk

sudo docker exec -i mongodb /usr/bin/mongorestore --username root --password root --authenticationDatabase admin --db elm /elm-db-bk


sudo docker exec -it mongodb bash


- inside container,
mongo admin -u root -p root

use admin

db.createUser({
    user: "elmadmin",
	pwd: passwordPrompt(),
	roles:[{role: "readWrite" , db:"elm"}]})


elmadmin/elmadmin

mongo admin -u elmadmin -p elmadmin


MongoClient.connect('mongodb://admin:password@localhost:27017/db', function (err, db) {
mongodb://[username:password@]host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]

mongodb://[username:password@]host1[:port1][,host2[:port2],...[,hostN[:portN]]][/[database][?options]]

config.url=mongodb://elmadmin:elmadmin@localhost:27017/elm

// mongoose.connect(config.url, {useMongoClient:true});
mongoose.connect(config.url, {user:'elmadmin', password:'elmadmin'});

url: 'mongodb://elmadmin:elmadmin@mongodb:27017/elm',

url: 'mongodb://mongodb:27017/elm',










