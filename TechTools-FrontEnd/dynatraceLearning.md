# Dynatrace Learning

## What is Dynatrace?

For real user monitoring, Dynatrace OneAgent injects a JavaScript tag into the HTML of each application page that is rendered by your web servers. With these tags in place, the agent can monitor the response times and performance experienced by your customers in their mobile and desktop browsers.

## Design Notes:

### Feature Toggle Flag to turn on off

- in application configuration json file, e.g, appConfig.json

"FEATURE_TOGGLE_DYNATRACE": "true"

- this can be retrieved by an Action and put it in Store, can be retrieved by using Selector

### An Action 

DynatraceAction


### import DynatraceAction in component to trace





## Other

XHR: Async http calls

PII: Personal Identificable Information

token
colloration id
...



