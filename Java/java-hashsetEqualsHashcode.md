
# Jave: HashSet Eques Hashcode

- Ref:

https://stackoverflow.com/questions/5396939/hashcode-and-equals-for-hashset


There's no need to call equals if hashCode differs.
There's no need to call hashCode if (obj1 == obj2).
There's no need for hashCode and/or equals just to iterate - you're not comparing objects
When needed to distinguish in between objects.

