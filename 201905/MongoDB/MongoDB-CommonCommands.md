
https://dzone.com/articles/top-10-most-common-commands-for-beginners

# Log Into MongoDB
The following command can be used to log into the MongoDB database. Make sure that the user with credentials such as username and password exist in the database mentioned in place of dbname.

mongo -u <username> -p <password> --authenticationDatabase <dbname>
# Show All Databases
Once logged in as a user with the appropriate role as userAdmin or userAdminAnyDatabase, the user can see all the databases using a command such as:

show dbs
# Select Database to Work With
To start working with a particular database, the following command can be executed:

use databaseName
# Authenticate and Log Out From Database
When switching to a different database using the use dbName command, the user is required to authenticate using a valid database user for that database. The following command can be used for authentication:

//
// Authenticate
//
db.auth("username", "password");
//
// Logout
//
db.logout()
# List Down Collections, Users, Roles, etc.
The following commands can be used to check existing collections, users, etc.

//
// List down collections of the current database
//
show collections;
db.getCollectionNames();
//
// List down all the users of current database
//
show users;
db.getUsers();
//
// List down all the roles
//
show roles
# Create a Collection
The following command can be used to create a collection. The details on this command can be found on this page.

db.createCollection("collectionName");
# Insert a Document in a Collection
Once a collection is created, the next step is to insert one or more documents. Following is a sample command for inserting a document in a collection.

//
// Insert single document
//
db.<collectionName>.insert({field1: "value", field2: "value"})
//
// Insert multiple documents
//
db.<collectionName>.insert([{field1: "value1"}, {field1: "value2"}])
db.<collectionName>.insertMany([{field1: "value1"}, {field1: "value2"}])
# Save or Update Document
The save command can be used to either update an existing document or insert a new one depending on the document parameter passed to it. If the _id passed matches an existing document, the document is updated. Otherwise, a new document is created. Internally, thesave method uses either the insert or the update command.

//
// Matching document will be updated; In case, no document matching the ID is found, a new document is created
//
db.<collectionName>.save({"_id": new ObjectId("jhgsdjhgdsf"), field1: "value", field2: "value"});
# Display Collection Records
The following commands can be used to retrieve collection records:

//
// Retrieve all records
//
db.<collectionName>.find();
//
// Retrieve limited number of records; Following command will print 10 results;
//
db.<collectionName>.find().limit(10);
//
// Retrieve records by id
//
db.<collectionName>.find({"_id": ObjectId("someid")});
//
// Retrieve values of specific collection attributes by passing an object having 
// attribute names assigned to 1 or 0 based on whether that attribute value needs 
// to be included in the output or not, respectively.
//
db.<collectionName>.find({"_id": ObjectId("someid")}, {field1: 1, field2: 1});
db.<collectionName>.find({"_id": ObjectId("someid")}, {field1: 0}); // Exclude field1
//
// Collection count
//
db.<collectionName>.count();
# Administrative Commands
Following are some of the administrative commands that can be helpful in finding collection details such as storage size, total size, and overall statistics.

//
// Get the collection statistics 
//
db.<collectionName>.stats()
db.printCollectionStats()
//
// Latency statistics for read, writes operations including average time taken for reads, writes
// and related umber of operations performed
//
db.<collectionName>.latencyStats()
//
// Get collection size for data and indexes
//
db.<collectionName>.dataSize() // Size of the collection
db.<collectionName>.storageSize() // Total size of document stored in the collection
db.<collectionName>.totalSize() // Total size in bytes for both collection data and indexes
db.<collectionName>.totalIndexSize() // Total size of all indexes in the collection

