
# What is the difference between localStorage, sessionStorage, session and cookies?

## Ref:

https://stackoverflow.com/questions/19867599/what-is-the-difference-between-localstorage-sessionstorage-session-and-cookies

## Answer 1

This is an extremely broad scope question, and a lot of the pros/cons will be contextual to the situation.

In all cases, these storage mechanisms will be specific to an individual browser on an individual computer/device. Any requirement to store data on an ongoing basis across sessions will need to involve your application server side - most likely using a database, but possibly XML or a text/CSV file.

localStorage, sessionStorage, and cookies are all client storage solutions. Session data is held on the server where it remains under your direct control.

### localStorage and sessionStorage
localStorage and sessionStorage are relatively new APIs (meaning, not all legacy browsers will support them) and are near identical (both in APIs and capabilities) with the sole exception of persistence. sessionStorage (as the name suggests) is only available for the duration of the browser session (and is deleted when the tab or window is closed) - it does, however, survive page reloads (source DOM Storage guide - Mozilla Developer Network).

Clearly, if the data you are storing needs to be available on an ongoing basis then localStorage is preferable to sessionStorage - although you should note both can be cleared by the user so you should not rely on the continuing existence of data in either case.

localStorage and sessionStorage are perfect for persisting non-sensitive data needed within client scripts between pages (for example: preferences, scores in games). The data stored in localStorage and sessionStorage can easily be read or changed from within the client/browser so should not be relied upon for storage of sensitive or security-related data within applications.

### Cookies
This is also true for cookies, these can be trivially tampered with by the user, and data can also be read from them in plain text - so if you are wanting to store sensitive data then the session is really your only option. If you are not using SSL, cookie information can also be intercepted in transit, especially on an open wifi.

On the positive side cookies can have a degree of protection applied from security risks like Cross-Site Scripting (XSS)/Script injection by setting an HTTP only flag which means modern (supporting) browsers will prevent access to the cookies and values from JavaScript (this will also prevent your own, legitimate, JavaScript from accessing them). This is especially important with authentication cookies, which are used to store a token containing details of the user who is logged on - if you have a copy of that cookie then for all intents and purposes you become that user as far as the web application is concerned, and have the same access to data and functionality the user has.

As cookies are used for authentication purposes and persistence of user data, all cookies valid for a page are sent from the browser to the server for every request to the same domain - this includes the original page request, any subsequent Ajax requests, all images, stylesheets, scripts, and fonts. For this reason, cookies should not be used to store large amounts of information. The browser may also impose limits on the size of information that can be stored in cookies. Typically cookies are used to store identifying tokens for authentication, session, and advertising tracking. The tokens are typically not human readable information in and of themselves, but encrypted identifiers linked to your application or database.

### localStorage vs. sessionStorage vs. Cookies
In terms of capabilities, cookies, sessionStorage, and localStorage only allow you to store strings - it is possible to implicitly convert primitive values when setting (these will need to be converted back to use them as their type after reading) but not Objects or Arrays (it is possible to JSON serialise them to store them using the APIs). Session storage will generally allow you to store any primitives or objects supported by your Server Side language/framework.

### Client-side vs. Server-side
As HTTP is a stateless protocol - web applications have no way of identifying a user from previous visits on returning to the web site - session data usually relies on a cookie token to identify the user for repeat visits (although rarely URL parameters may be used for the same purpose). Data will usually have a sliding expiry time (renewed each time the user visits), and depending on your server/framework data will either be stored in-process (meaning data will be lost if the web server crashes or is restarted) or externally in a state server or database. This is also necessary when using a web-farm (more than one server for a given website).

As session data is completely controlled by your application (server side) it is the best place for anything sensitive or secure in nature.

The obvious disadvantage of server-side data is scalability - server resources are required for each user for the duration of the session, and that any data needed client side must be sent with each request. As the server has no way of knowing if a user navigates to another site or closes their browser, session data must expire after a given time to avoid all server resources being taken up by abandoned sessions. When using session data you should, therefore, be aware of the possibility that data will have expired and been lost, especially on pages with long forms. It will also be lost if the user deletes their cookies or switches browsers/devices.

Some web frameworks/developers use hidden HTML inputs to persist data from one page of a form to another to avoid session expiration.

localStorage, sessionStorage, and cookies are all subject to "same-origin" rules which means browsers should prevent access to the data except the domain that set the information to start with.

For further reading on client storage technologies see Dive Into Html 5.

## Answer 2

### LocalStorage

- Pros:

Web storage can be viewed simplistically as an improvement on cookies, providing much greater storage capacity. If you look at the Mozilla source code we can see that 5120KB (5MB which equals 2.5 Million chars on Chrome) is the default storage size for an entire domain. This gives you considerably more space to work with than a typical 4KB cookie.
The data is not sent back to the server for every HTTP request (HTML, images, JavaScript, CSS, etc) - reducing the amount of traffic between client and server.
The data stored in localStorage persists until explicitly deleted. Changes made are saved and available for all current and future visits to the site.
- Cons:

It works on same-origin policy. So, data stored will only be available on the same origin.

### Cookies

- Pros:

Compared to others, there's nothing AFAIK.

- Cons:

The 4K limit is for the entire cookie, including name, value, expiry date etc. To support most browsers, keep the name under 4000 bytes, and the overall cookie size under 4093 bytes.
The data is sent back to the server for every HTTP request (HTML, images, JavaScript, CSS, etc) - increasing the amount of traffic between client and server.
Typically, the following are allowed:

300 cookies in total
4096 bytes per cookie
20 cookies per domain
81920 bytes per domain(Given 20 cookies of max size 4096 = 81920 bytes.)

### sessionStorage

- Pros:

It is similar to localStorage.
The data is not persistent i.e. data is only available per window (or tab in browsers like Chrome and Firefox). Data is only available during the page session. Changes made are saved and available for the current page, as well as future visits to the site on the same tab/window. Once the tab/window is closed, the data is deleted.
- Cons:

The data is available only inside the window/tab in which it was set.
Like localStorage, it works on same-origin policy. So, data stored will only be available on the same origin.
Checkout across-tabs - how to facilitate easy communication between cross-origin browser tabs.



