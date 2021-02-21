Spring-OAuth2-AuthServer-ResourceServer.md


# @EnableAuthorizationServer

====> public void configure(final AuthorizationServerEndpointsConfigurer endpoints) throws Exception {

This enables the link "/oauth/token", getting an access token or/and refresh token.


====> public void configure(final ClientDetailsServiceConfigurer clients) throws Exception:
```java
@Override
public void configure(final ClientDetailsServiceConfigurer clients) throws Exception {
    clients
            .inMemory()
            .withClient("clientId")
            .secret(passwordEncoder.encode("rawPasswordToBeEncoded"))
            .authorizedGrantTypes("password", "refresh_token")
            .scopes("read", "write");
}
```
This is for verifying a client (Resource Server) from getting an access token or refresh token.

-- if using clients.jdbc() ...., need a "ClientDetailsService" (Note, Resource Server, this is called UserDetailsService)
i.e, getting client verification from database, then,

First, it’s time to setup the database tables for the OAuth2, therefore we need the following tables:

oauth_client_details
oauth_client_token
oauth_access_token
oauth_refresh_token
oauth_code
oauth_approvals
ClientDetails

https://dazito.com/java/spring-boot-and-oauth2-with-jdbc
https://github.com/dazito/oauth2-with-jdbc


-- if using Symmetric key:

If using a symmetric key in JwtAccessTokenConverter to sign tokens, then need to use the same exact key for the Resources Server as well.

@Bean
public TokenStore tokenStore() {
    return new JwtTokenStore(accessTokenConverter());
}

@Bean
public JwtAccessTokenConverter accessTokenConverter() {
    JwtAccessTokenConverter converter = new JwtAccessTokenConverter();
    converter.**setSigningKey**("123"); 
    return converter;
}

-- if using Asymmetric KeyPair: (Public and Private keys)

:: Generate JKS Java KeyStore File
```
keytool -genkeypair -alias mytest 
                    -keyalg RSA 
                    -keypass mypass 
                    -keystore mytest.jks 
                    -storepass mypass
```
:: Export Public Key
```
keytool -list -rfc --keystore mytest.jks | openssl x509 -inform pem -pubkey
```
:: We take only our Public key and copy it to our resource server src/main/resources/public.txt

:: Authorization Server
```
@Bean
public JwtAccessTokenConverter accessTokenConverter() {
    JwtAccessTokenConverter converter = new JwtAccessTokenConverter();
    KeyStoreKeyFactory keyStoreKeyFactory = 
      new KeyStoreKeyFactory(new ClassPathResource("mytest.jks"), "mypass".toCharArray());
    converter.**setKeyPair**(keyStoreKeyFactory.getKeyPair("mytest"));
    return converter;
}
```

:: Resource Server
```
@Bean
public JwtAccessTokenConverter accessTokenConverter() {
    JwtAccessTokenConverter converter = new JwtAccessTokenConverter();
    Resource resource = new ClassPathResource("public.txt");
    String publicKey = null;
    try {
        publicKey = IOUtils.toString(resource.getInputStream());
    } catch (final IOException e) {
        throw new RuntimeException(e);
    }
    converter**.setVerifierKey**(publicKey);
    return converter;
}
```

====> Extra Claims available in the Authentication Object:

Now that the Authorization Server added some extra claims in the token, we can now access on the Resource Server side, directly in the Authentication object:
```
public Map<String, Object> getExtraInfo(Authentication auth) {
    OAuth2AuthenticationDetails oauthDetails
      = (OAuth2AuthenticationDetails) auth.getDetails();
    return (Map<String, Object>) oauthDetails
      .getDecodedDetails();
}
```

====> curl for testing:
-- original
```
curl -X POST -vu client:secret http://localhost:8080/oauth/token -H "Accept: application/json" -d "password=admin&username=admin&grant_type=password&scope=read%20write&client_secret=secret&client_id=client"
```
-- revised version:
```
curl -X POST -vu clientId:rawPasswordToBeEncoded http://localhost:8080/oauth/token -H "Accept: application/json" -d "password=admin&username=admin&grant_type=password&scope=read%20write&client_secret=rawPasswordToBeEncoded&client_id=clientId" 
```
-- not working:
```
curl -X POST http://localhost:8080/oauth/token -H "Accept: application/json" -d "password=admin&username=admin&grant_type=password&scope=read%20write&client_secret=rawPasswordToBeEncoded&client_id=clientId" 
```
-- final working version: 
```
curl -X POST -vu clientId:rawPasswordToBeEncoded http://localhost:8080/oauth/token -H "Accept: application/json" -d "password=admin&username=admin&grant_type=password&scope=read%20write"
```
-- from Postman: -H 'Content-Type: application/x-www-form-urlencoded'
```
curl -X POST \
  http://localhost:8080/oauth/token \
  -H 'Authorization: Basic Y2xpZW50SWQ6cmF3U2VjcmV0VG9CZUVuY29kZWQ=' \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: f8e1e63d-cbec-4998-9832-ce06dad02891' \
  -d 'grant_type=password&username=admin&password=admin'
```







====> Good references:

https://www.baeldung.com/spring-security-oauth-jwt


====> To Be Handled:




-- OAuth2AuthenticationProcessingFilter
public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain):
Authentication authentication = tokenExtractor.extract(request);
Authentication authResult = authenticationManager.authenticate(authentication);

-- OAuth2AuthenticationManager
public Authentication authenticate(Authentication authentication):
String token = (String) authentication.getPrincipal();
OAuth2Authentication auth = tokenServices.loadAuthentication(token);


-- DefaultTokenServices
public OAuth2Authentication loadAuthentication(String accessTokenValue):
OAuth2AccessToken accessToken = tokenStore.readAccessToken(accessTokenValue);

==> else if (accessToken.isExpired())

-- JwtTokenStore
public OAuth2AccessToken readAccessToken(String tokenValue):
OAuth2AccessToken accessToken = convertAccessToken(tokenValue);

private OAuth2AccessToken convertAccessToken(String tokenValue) {
	return jwtTokenEnhancer.extractAccessToken(tokenValue, jwtTokenEnhancer.decode(tokenValue));
}



JwtAccessTokenConverter




============================================


@FrameworkEndpoint
public class TokenEndpoint extends AbstractEndpoint

@RequestMapping(value = "/oauth/token", method=RequestMethod.POST)
	public ResponseEntity<OAuth2AccessToken> postAccessToken(Principal principal, @RequestParam
	Map<String, String> parameters) throws HttpRequestMethodNotSupportedException {
::
OAuth2AccessToken token = getTokenGranter().grant(tokenRequest.getGrantType(), tokenRequest);

:: 
from AuthorizationServerEndpointsConfigurer
::
ResourceOwnerPasswordTokenGranter
protected OAuth2Authentication getOAuth2Authentication(ClientDetails client, TokenRequest tokenRequest)
parameters.remove("password");
userAuth = authenticationManager.authenticate(userAuth);
::
Own class !!!!
@Component
public class AccountAuthenticationProvider extends AbstractUserDetailsAuthenticationProvider {

@Override
protected void additionalAuthenticationChecks(final UserDetails userDetails, final UsernamePasswordAuthenticationToken token)




.inMemory()
                    .withClient("client")
                    .secret(passwordEncoder.encode("secret"))
                    .authorizedGrantTypes("password", "refresh_token")
                    .scopes("read", "write");

curl -X POST -vu client:secret http://localhost:8080/oauth/token -H "Accept: application/json" -d "password=admin&username=admin&grant_type=password&scope=read%20write&client_secret=secret&client_id=client"





