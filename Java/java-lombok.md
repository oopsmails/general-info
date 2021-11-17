
# lombok

- Refs:

https://javabydeveloper.com/lombok-getter-setter-and-lazy-getters-examples/



## 3. Changing access level for generated getters and setters

- By default generated getter/setter method will be public . To change access modifier of generated getters and setters, you need to specify AccessLevel as shown in the following example. The legal access levels are PUBLIC, PROTECTED, PACKAGE, and PRIVATE.

```
@Getter
@Setter
public class User {

	@Setter(AccessLevel.PRIVATE)
	private Long id;

	@Getter(AccessLevel.PROTECTED)
	private String username;
	
	@Getter(AccessLevel.PACKAGE)
	private String email;

	@Getter(AccessLevel.PUBLIC)
	@Setter(AccessLevel.PRIVATE)
	private LocalDate lastUpdated;

}
```

## Exclude Or disable generating getters/setters

- You can always manually disable getter/setter generation for any field by using the special AccessLevel.NONE access level. This lets you override the behavior of a @Getter, @Setter or @Data annotation on a class.

##  Return Optional for Getter

- Write your owen to override

## Put Annotations on Lombok generated Constructors, methods and parameters

- To put annotations on the generated method, you can use onMethod, onParam and onConstructor attributes for @Getter, @Setter, @AllArgsConstructor and @NoArgsConstructor like following example.

```
@Getter
@Setter
@AllArgsConstructor(
		onConstructor_= @ConstructorParameters({"id","email"}))
public class User {

	private Long id;
	
	//@Getter(onMethod=@__(@Deprecated)) -- JDK7
	@Getter(onMethod_= @Deprecated) // JDK8
	@Setter(onParam_ = @NonFinal )
	private String email;
	
	@Getter(onMethod_= {
			@Generated("com.javabydeveloper.lombok.settergetter.User"),
			@Deprecated
			})
	private boolean active;
}

```

- On @Autowired

```
old code, need to check for update

class Foo {
  @Setter(onMethod=@__({@Autowired}))
  private Bar bar;
}
```int


## ToString and @EqualsAndHashCode

```
@ToString(callSuper=true)

@ToString(of = {"fieldName1", "fieldName2"})

@ToString(exclude = {"fieldName1", "fieldName2"})

```


