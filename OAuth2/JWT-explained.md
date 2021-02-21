JWT-explained.md


====> If you can decode JWT how are they secure?
https://stackoverflow.com/questions/27301557/if-you-can-decode-jwt-how-are-they-secure

WTs can be either signed, encrypted or both. If a token is signed, but not encrypted, everyone can read the contents of the token, 
but when you don't know the private key, you can't change it. Otherwise, the receiver will notice that the signature won't match anymore.

Answer to your comment: I'm not sure if I understand your comment the right way. Just to be sure: do you know and understand digital 
signatures? I'll just briefly explain one variant (HMAC, which is symmetrical, but there are many others).

Let's assume Alice wants to send a JWT to Bob. They both know some shared secret. Mallory doesn't know that secret, but wants to 
interfere and change the JWT. To prevent that, Alice calculates Hash(payload + secret) and appends this as signature.

When receiving the message, Bob can also calculate Hash(payload + secret) to check whether the signature matches. If however, 
Mallory changes something in the content, she isn't able to calculate the matching signature (which would be Hash(newContent + secret)). 
She doesn't know the secret and has no way of finding it out. This means if she changes something, the signature won't match anymore, 
and Bob will simply not accept the JWT anymore.

Let's suppose, I send another person the message {"id":1} and sign it with Hash(content + secret). (+ is just concatenation here). I use 
the SHA256 Hash function, and the signature I get is: 330e7b0775561c6e95797d4dd306a150046e239986f0a1373230fda0235bda8c. 
Now it's your turn: play the role of Mallory and try to sign the message {"id":2}. You can't because you don't know which secret I used. 
If I suppose that the recipient knows the secret, he CAN calculate the signature of any message and check if it's correct.


====> JWT & OAuth2 - Does the server store the token ? & How are they Secure/Hacker Safe?
https://stackoverflow.com/questions/38596792/jwt-oauth2-does-the-server-store-the-token-how-are-they-secure-hacker-sa

-- Q: I don't understand why a middleman(or a hacker) would not be able to see the token being sent by the client and use the same to 
impersonate as that client/person to retrieve resources ?

A: JWT does not protect you to a man-in-the-middle (MITM) attack. If an attacker gets a valid token, can effectively impersonate. 
Even if the content is encrypted.

JWT should be used with a SSL/TLS connection to avoid MITM

-- Q: What makes JSON Web Tokens / OAuth2 based authentications safer in that sense ?

A: JWT is a token format, and oauth2 is a protocol. oauth2 can use jwt. Oauth2 is safer to the user using a third party site because 
credentials are only sent from the user to the main site, then the site issues a token that can be used by the third party site to 
authenticate user. The third party site never see the user credentials

-- Q: But as the token stays the same until it expires, how is that a safer authentication strategy ?

A: Read above. You need to protect your tokens to not be stolen: Mainly use HTTPS, or mitigate its effects: store in cookies with 
HttpOnly (if you do not need to access JWT content in client side), set expiration time short, rotate tokens...

-- Q: How does the server know that the token sent by the client is valid i.e something that the server exchanged with the client during login.

A: The third part of a JWT like hhhh.pppp.ssss is the signature. The signature is performed with server private key over the header 
and payload (hhhh.pppp), an protects the content. If an attacker alters the content or the signature, the server will detect it 
verifying the signature and will reject the authentication.

-- Q: Does the server store the token generated in a database or somewhere and keep updating the "last accessed timestamp" or 
something and keeps removing the tokens where last_accessed_time is > 1hour ago, to keep expiring it after 1 hour of inactivity ?

A: It is not needed. The signature is packed in the token itself (ssss), therefore it is said that JWT is self-contained

The server has a cryptographic secret key or a key pair, public and privete. The token is signed and verified with the secret 
key (for HMAC symmetric keys), or signed with the private key and verified with the corresponding public key (for RSA asymmetric keys)


====> Where to Store your JWTs – Cookies vs HTML5 Web Storage
https://stormpath.com/blog/where-to-store-your-jwts-cookies-vs-html5-web-storage

JWT localStorage or sessionStorage (Web Storage) or JWT Cookie Storage?

A: In short JWT Cookie Storage.

-- Web Storage (localStorage/sessionStorage) is accessible through JavaScript on the same domain. This means that any JavaScript running 
on your site will have access to web storage, and because of this can be vulnerable to cross-site scripting (XSS) attacks.

To prevent XSS, the common response is to escape and encode all untrusted data. But this is far from the full story. 
In 2015, modern web apps use JavaScript hosted on CDNs or outside infrastructure. Modern web apps include 3rd party 
JavaScript libraries for A/B testing, funnel/market analysis, and ads. We use package managers like Bower to import 
other peoples’ code into our apps.

What if only one of the scripts you use is compromised? Malicious JavaScript can be embedded on the page, and Web Storage is compromised. 
These types of XSS attacks can get everyone’s Web Storage that visits your site, without their knowledge. 

This is probably why a bunch of organizations advise not to store anything of value or trust any information in web storage. 
This includes session identifiers and tokens

As a storage mechanism, Web Storage does not enforce any secure standards during transfer. Whoever reads Web Storage and 
uses it must do their due diligence to ensure they always send the JWT over HTTPS and never HTTP.


-- Cookies, when used with the HttpOnly cookie flag, are not accessible through JavaScript, and are immune to XSS. 
You can also set the Secure cookie flag to guarantee the cookie is only sent over HTTPS.

However, cookies are vulnerable to a different type of attack: cross-site request forgery (CSRF). 
A CSRF attack is a type of attack that occurs when a malicious web site, email, or blog causes a user’s web browser to perform an 
unwanted action on a trusted site on which the user is currently authenticated.

CSRF can be prevented by using synchronized token patterns. This sounds complicated, but all modern web frameworks have support for this.

