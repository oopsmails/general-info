
https://stackoverflow.com/questions/19225115/how-to-do-conditional-auto-wiring-in-spring


```

In your @Configuration class declare a bean to be conditionally created:

@Bean
@Conditional(CustomFeatureCondition.class)
public Stuff stuff() {
    return new Stuff ();
}
In the place of using just @Autowire it with required = false option:

@Component
@Setter(onMethod_ = @Autowired(required = false))
public class AnotherStuff {
    private Stuff stuff;
    // do stuff here
}
This way you'll get Stuff bean if it exists in the context and stuff = null if it doesn't.

```


```
I suppose the simpest way:

@Autowired @Lazy
protected A a;

@Autowired @Lazy
protected B b;

void do(){
  if(...) { // any condition
     // use a
  } else {
     // use b
  }
}
In case you do not declare nessassary bean, Spring throws at runtime NoSuchBeanDefinitionException
```


```
Factory bean
You can implement simple factory bean to do the conditional wiring. Such factory bean can contain complex conditioning logic:

public MyBeanFactoryBean implements FactoryBean<MyBean> {

    // Using app context instead of bean references so that the unused 
    // dependency can be left uninitialized if it is lazily initialized
    @Autowired
    private ApplicationContext applicationContext;

    public MyBean getObject() {
        MyBean myBean = new MyBean();
        if (true /* some condition */) {
            myBean.setDependency(applicationContext.getBean(DependencyX.class));
        } else {
            myBean.setDependency(applicationContext.getBean(DependencyY.class));
        }
        return myBean;
    }

    // Implementation of isSingleton => false and getObjectType

}
Maybe a bit better approach is if you use factory bean to create the dependency bean in case you want to have only one such bean in your application context:

public MyDependencyFactoryBean implements FactoryBean<MyDependency> {

    public MyDependency getObject() {
        if (true /* some condition */) {
            return new MyDependencyX();
        } else {
            return new MyDependencyY();
        }
    }

    // Implementation of isSingleton => false and getObjectType

}
```

