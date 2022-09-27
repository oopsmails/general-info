
# Knowledges and Tips on Postman

## Tips

### Auto Set access_token to Env Variable

- Get access_token Request: Tests Tab

This will "automatically" update the value of environment variable "token". Of course, need to define an env variable name "token" first, and use it in other requests header, as, *Authorization: Bearer {{token}}*

```
pm.test("Set Token", function () {
    var jsonData = pm.response.json();
    postman.setEnvironmentVariable("token", jsonData.access_token);
});

```

## Issues and Solutions

### Issue: Encoding Issue with Postman 8

Postman 8, the default encode url parameters in the request setting will not encode all characters, thus, getting 400, Bad Request.

### Solution:

Ref: https://learning.postman.com/docs/sending-requests/requests/

*Parameters will not automatically be URL-encoded. Right-click selected text, and choose EncodeURIComponent to manually encode a parameter value.*

### Issue: Query having a JSON

JSON, containing **:, {,}**, they are not getting encoded

### Solution:

- In the Pre-request Script tab, add,

`pm.request.url.query.all().forEach((param) => { param.value = encodeURIComponent(param.value)});`

- Also can be applied this at Collection level, Edit Collection, Pre-request Scripts



