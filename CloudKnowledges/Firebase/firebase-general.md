
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

- Used in *github.com/oopsmails/react-sandbox*
  
  - *https://github.com/oopsmails/react-sandbox/blob/main/meetups/src/pages/AllMeetups.js*
  - *https://github.com/oopsmails/react-sandbox/blob/main/meetups/src/pages/AllMeetups.js*



## Authentication

### oopsmails, firebase, OopsAuth

- Authentication, Sign-in providers

Provider:

Email/Password: Enabled


- Used in *https://github.com/oopsmails/sandbox/blob/main/reciclica-app-main/src/environments/environment.ts*

```
export const environment = {
  firebaseConfig: {
    apiKey: "AIzaSyBX8_dH-73_eKpbfrNVwXO7fYCiGwwmLRE",
    authDomain: "oopsauth.firebaseapp.com",
    projectId: "oopsauth",
    storageBucket: "oopsauth.appspot.com",
    messagingSenderId: "1004495272090",
    appId: "1:1004495272090:web:3d817576a8e971e8eb8723"
  },
  production: false
};
```




