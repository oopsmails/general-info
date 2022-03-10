
# Firebase


## DB

### oopsmails, firebase, OopsDB

https://oopsdb-9aead-default-rtdb.firebaseio.com/


project OopsDB

Realtime Database, create in **Start in Test Mode**, otherwise, will NOT be able to send requests.

- Rules

https://medium.com/@juliomacr/10-firebase-realtime-database-rule-templates-d4894a118a98


```
{
  "rules": {
    ".read": "now < 1649476800000",  // 2022-4-9
    ".write": "now < 1649476800000",  // 2022-4-9
  }
}

// No Security
{
 "rules": {
 ".read": true,
 ".write": true
 }
}
```


## Authentication

### oopsmails, firebase, OopsAuth

- Authentication, Sign-in providers

Provider:

Email/Password: Enabled







