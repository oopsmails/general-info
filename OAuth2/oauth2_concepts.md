
# Concepts Around OAuth2 and JWT

## OAuth2 vs JWT

https://stackoverflow.com/questions/39909419/what-are-the-main-differences-between-jwt-and-oauth-authentication


### OAuth2 vs JWT Diff, Comments 01

- JWT (JSON Web Tokens)- It is just a token format. JWT tokens are JSON encoded data structures contains information about issuer, subject (claims), expiration time etc. It is signed for tamper proof and authenticity and it can be encrypted to protect the token information using symmetric or asymmetric approach. JWT is simpler than SAML 1.1/2.0 and supported by all devices and it is more powerful than SWT(Simple Web Token).

- OAuth2 - OAuth2 solve a problem that user wants to access the data using client software like browse based web apps, native mobile apps or desktop apps. OAuth2 is just for authorization, client software can be authorized to access the resources on-behalf of end user using access token.

- OpenID Connect - OpenID Connect builds on top of OAuth2 and add authentication. OpenID Connect add some constraint to OAuth2 like UserInfo Endpoint, ID Token, discovery and dynamic registration of OpenID Connect providers and session management. JWT is the mandatory format for the token.

- CSRF protection - You don't need implement the CSRF protection if you do not store token in the browser's cookie. No cookies == No CSRF protection. If you don't use cookies for authorization, then you don't have to worry about CSRF protection.

### OAuth2 vs JWT Diff, Comments 02

Firstly, we have to differentiate JWT and OAuth. Basically, JWT is a token format. OAuth is an authorization protocol that can use JWT as a token. OAuth uses server-side and client-side storage. If you want to do real logout you must go with OAuth2. Authentication with JWT token can not logout actually. Because you don't have an Authentication Server that keeps track of tokens. **If you want to provide an API to 3rd party clients, you must use OAuth2 also. OAuth2 is very flexible.** JWT implementation is very easy and does not take long to implement. If your application needs this sort of flexibility, you should go with OAuth2. But if you don't need this use-case scenario, implementing OAuth2 is a waste of time.

XSRF token is always sent to the client in every response header. It does not matter if a CSRF token is sent in a JWT token or not, because the CSRF token is secured with itself. Therefore sending CSRF token in JWT is unnecessary.


## Design

### Good Example 01

https://www.djamware.com/post/5d3332980707cc65eac46c7b/spring-boot-security-mongodb-angular-8-build-authentication

- Authentication + Authorization



![Authentication + Authorization](https://github.com/oopsmails/general-info/blob/master/OAuth2/oauth2-real-authenticationAndauthorization.png)



