
# Gradle Basics

## implementation vs. api

https://stackoverflow.com/questions/44413952/gradle-implementation-vs-api-configuration


- Gradle *compile* keyword was deprecated in favor of the *api* and *implementation* keywords to configure dependencies.

Using *api* is the equivalent of using the *deprecated* compile, so if you replace all *compile* with *api* everything will works as always.

- I like to think about an api dependency as public (seen by other modules) while implementation dependency as private (only seen by this module).

- Consider you have app module which uses lib1 as a library and lib1 uses lib2 as a library. Something like this: app -> lib1 -> lib2.

Now when using api lib2 in lib1, then app can see lib2 codes when using: api lib1 or implementation lib1 in the app module.

BUT when using implementation lib2 in lib1, then app can not see the lib2 codes.

## Default tasks

- use `gradle tasks` to see the intro of Gradle Tasks.

## Sub projects

```
rootProject.name = 'gradle-evaluation-order'
include 'sub-project-1', 'sub-project-2'
```


## Error and Fix

- Could not find method runtime() for arguments [org.springframework.boot:spring-boot-devtools]

in build.gradle. change runtime to runtimeOnly




