
## Angular 5, the response from a HttpClient GET call is truncated ..

### Getting Error:

`"Unexpected end of JSON input" Angular 5`

### Solution: This only happening when response is very big ...

#### Fixing on Angular side is NOT working:
```
this.headers = new HttpHeaders({
    TestHeader: JSON.stringify({
    requestId: getRequestId(),
    sessionId: getSessionId(),
    sourceFrom: 'CELL'
    }),
    'Content-Type': 'application/json',
    // 'responseType': 'text' as 'json', <--------------- adding this NOT working
    'connection': 'keep-alive', <--------------- adding this NOT working, will be blocked
    'transfer-encoding': 'chunked', <--------------- adding this NOT working, will be blocked
    'gzip': 'true',
    'x_abc_jwt': 'sss.asdfsdf...adsf..adsf.ds.f.a.dsfas.dfadsf.'
});

http.js:2170 Refused to set unsafe header "Connection"

http.js:2170 Refused to set unsafe header "transfer-encoding"


```

#### Fixing on SpringBoot side is working

https://stackoverflow.com/questions/57553614/getting-an-incomplete-chunked-json-response-on-angular-proxy

```
I am aware that the API returns response header Transfer-encoding 'chunked' and from what I understand, this means having to process the response as a stream.

1. One way to avoid this, is to let the API return a Content-Length header. But I'd rather want to leave the API unchanged.
2. I read that when proxying on an nginx server, there is an option 'proxy_buffering' to configure how to handle large HTTP responses. But I'm using the built-in angular proxy (which is a webpack dev server) and I haven't found a way to configure such property.

```

https://stackoverflow.com/questions/24156490/how-to-set-content-length-in-spring-mvc-rest-for-json

```
    @Bean
    public FilterRegistrationBean shallowEtagHeaderFilter() {
        FilterRegistrationBean filterBean = new FilterRegistrationBean();
        filterBean.setFilter(new ShallowEtagHeaderFilter());
        filterBean.setUrlPatterns(Arrays.asList("*"));
        filterBean.setName("shallowEtagHeaderFilter");
        return filterBean;
```






