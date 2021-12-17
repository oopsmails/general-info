var express = require("express");
var app = express();

let port = 3000;

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});

app.get("/api", (req, res, next) => {
    res.json(["Apple", "Banana", "Cherry", "Dewberry", "Grape", "ChangingVersion-v1"]);
});
