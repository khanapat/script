# Mongodb

## Install MongoDB with Docker

ref: [docker](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-community-with-docker/)

ref: [mongosh](https://www.mongodb.com/docs/mongodb-shell/install/)

ref: [sql-comparison](https://www.mongodb.com/docs/v6.0/reference/sql-comparison/)

## mongo-cli

```bash
# install on linux
apt-get update
apt install wget
wget -qO- https://www.mongodb.org/static/pgp/server-6.0.asc |  tee /etc/apt/trusted.gpg.d/server-6.0.asc
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list
apt-get update
apt-get install -y mongodb-mongosh

# install on macos
brew install mongosh

# connect
mongosh "mongodb://{host}:{port}" --username {username} --authenticationDatabase admin --password {password}

# display database you are using
db

# switch database
use <database>

# healthcheck
db.runCommand( { hello: 1 } )

# list all database
db.adminCommand( { listDatabases: 1 } )

# list all collection
db.runCommand( { listCollections: 1, nameOnly: false } )

# insert 
.editor # open editor to use multi line command

db.myCollection.insertOne( { x: 1 } );

db.movies.insertMany([
    {
        title: "Jurassic World: Fallen Kingdom",
        genres: [ "Action", "Sci-Fi" ],
        runtime: 130,
        rated: "PG-13",
        year: 2020,
        directors: [ "J. A. Bayona" ],
        cast: [ "Chris Pratt", "Bryce Dallas Howard", "Rafe Spall" ],
        type: "movie"
    },
    {
        title: "Twilight",
        genres: [ "Comedy", "Action" ],
        runtime: 105,
        rated: "R",
        year: 2018,
        directors: [ "Jeff Tomsic" ],
        cast: [ "Annabelle Wallis", "Jeremy Renner", "Jon Hamm" ],
        type: "movie"
    }
])

# read
db.movies.find( { "title": "Titanic" } )

db.movies.find( { rated: { $in: [ "PG", "PG-13" ] } } )

# AND ( OR )
db.movies.find( {
    year: 2018,
    $or: [ { "runtime": { $gte: 120 } }, { genres: "Comedy" } ]
})

# update
db.movies.updateOne( { title: "Twilight" },
{
    $set: {
        plot: "A teenage girl risks everything–including her life–when she falls in love with a vampire."
    },
    $currentDate: { lastUpdated: true }
})

# delete
db.movies.deleteMany({})

db.movies.deleteOne( { cast: "Brad Pitt" } )
```
