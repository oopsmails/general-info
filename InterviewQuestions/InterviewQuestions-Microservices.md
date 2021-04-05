
# Microservices Interview Questions

### Commonly used tools for Microservices?

A:
- Wiremock
- Docker
- Hystrix Netflix, Circuit Breaker

https://www.baeldung.com/spring-cloud-netflix-hystrix

Spring Cloud Netflix Hystrix – the fault tolerance library. We’ll use the library and implement the Circuit Breaker enterprise pattern, which is describing a strategy against failure cascading at different levels in an application.

The principle is analogous to electronics: Hystrix is watching methods for failing calls to related services. If there is such a failure, it will open the circuit and forward the call to a fallback method.

The library will tolerate failures up to a threshold. Beyond that, it leaves the circuit open. Which means, it will forward all subsequent calls to the fallback method, to prevent future failures. This creates a time buffer for the related service to recover from its failing state.

- Eureka Server

### Monolithic Architecture

Build and deploy as a single package

### Microservices advantages

- Any change has a big impact, dev, test, deploy ...
- Usually faster to dev or change
- Individual, independent impletations, Tech diversity
- Independent deployment

###  Discuss uses of reports and dashboards in the environment of Microservices

Tools?

### What are the challenges faced while using Microservices?

### In which cases microservice architecture best suited?

### What is RESTful?

- REST standard, jax-rs
- Identify resource, business domain, apply "verbs" on it
- Resource mapping urls

### Explain the use of PACT in Microservices architecture?

It is an open source tool which allows testing interactions between service providers and consumers. However, it is separated from the contract made. This increases the reliability of the Microservices applications.

### What is a CDC?

CDC is Consumer-Driven Contract. It is a pattern for developing Microservices so that external systems can use them.

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 

### 






