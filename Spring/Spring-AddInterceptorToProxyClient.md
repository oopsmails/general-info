
# Spring: OLD Apache CXF, Adding an Interceptor to existing Proxy Client

## This is using apache cxf configuration

- bean.xml

```
<!-- Interceptor for Sample Proxy service -->
<bean id="sampleInterceptor" class="com.interceptor.SampleInterceptor" ></bean>
```

- SampleInterceptor

```
package com.interceptor;

import org.apache.cxf.message.Message;
import org.apache.cxf.phase.AbstractPhaseInterceptor;
import org.apache.cxf.phase.Phase;
import org.apache.cxf.transport.Conduit;
import org.apache.cxf.transport.http.HTTPConduit;
import org.apache.cxf.transports.http.configuration.HTTPClientPolicy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;

/* Interceptor class to increase the timeout for Sample service to 888 seconds
 */
public class SampleInterceptor extends  AbstractPhaseInterceptor<Message>{

	private static final Logger logger = LoggerFactory.getLogger(SampleInterceptor.class);
	
	@Value("${hub.sample.timeout}")
	protected int clientTimeout;
	
	public SampleInterceptor() {
        super(Phase.SETUP);
    }
	@Override
	public void handleMessage(Message message) {
		try {
			final Conduit conduit = message.getExchange().getConduit(message);
			if (conduit instanceof HTTPConduit) {
				final HTTPConduit httpConduit = (HTTPConduit) conduit;
				HTTPClientPolicy policy = httpConduit.getClient();
				policy.setReceiveTimeout(clientTimeout);
				policy.setConnectionTimeout(clientTimeout);
				httpConduit.setClient(policy);
			}
		} catch (Exception e) {
			logger.error("Error in increasing timeout for Sample Service");
		}
	}
}
```

- proxy-bean.xml

```
xmlns:jaxrs="http://cxf.apache.org/jaxrs-client"

<jaxrs:client id="sampleProxy" address="${hub.sample.endpoint}" threadSafe="true" serviceClass="com.client.proxy.SampleProxy">
		<jaxrs:headers>
			<entry key="Accept-Encoding" value="gzip,deflate" />
			<entry key="Content-Type" value="application/json;charset=UTF-8" />
			<entry key="Content-Length" value="92" />
			<entry key="Connection" value="Keep-Alive" />
		</jaxrs:headers>
		<jaxrs:providers>
			<ref bean="jsonProvider" />
		</jaxrs:providers>
		<jaxrs:outInterceptors>
			<!--  interceptor to increase timeout -->
			<ref bean="sampleInterceptor" />
		</jaxrs:outInterceptors>
		<jaxrs:features>
			<!-- Enables logging of the 'on-the-wire' request/response -->
			<bean class="org.apache.cxf.feature.LoggingFeature" />
		</jaxrs:features>
    </jaxrs:client>
```


- orig SampleClient

```
@Service
public class SampleClient extends AbstractRestClient {
```

