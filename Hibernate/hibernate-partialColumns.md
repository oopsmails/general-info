# How to fetch only selected attributes of an entity using Spring JPA?

I'm using Spring Boot (1.3.3.RELEASE) and Hibernate JPA in my project. My entity looks like this:

```
@Data
@NoArgsConstructor
@Entity
@Table(name = "rule")
public class RuleVO {

    @Id
    @GeneratedValue
    private Long id;

    @Column(name = "name", length = 128, nullable = false, unique = true)
    private String name;

    @Column(name = "tag", length = 256)
    private String tag;

    @OneToMany(mappedBy = "rule", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RuleOutputArticleVO> outputArticles;

    @OneToMany(mappedBy = "rule", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RuleInputArticleVO> inputArticles;
}
```

My repository looks like this:

```
@Repository
public interface RuleRepository extends JpaRepository<RuleVO, Long> {
}
```

In some cases I need to fetch only id and name attributes of entity RuleVO. How can I achieve this? I found a notice it should be doable using Criteria API and Projections but how? Many thanks in advance. Vojtech

## Solution

### s1

As has been pointed out to me, I'm lazy and this can very well be done hence I'm updating my answer after having looked around the web for a proper one.

Here's an example of how to get only the id's and only the names:

```
@Repository
public interface RuleRepository extends JpaRepository<RuleVO, Long> {

    @Query("SELECT r.id FROM RuleVo r where r.name = :name")
    List<Long> findIdByName(@Param("name") String name);

    @Query("SELECT r.name FROM RuleVo r where r.id = :id")
    String findNameById(@Param("id") Long id);
}
```

### s2

You can also define custom constructor to fetch specific columns using JPQL.

Example:

Replace {javaPackagePath} with complete java package path of the class use as a constructor in JPQL.

```
public class RuleVO {
   public RuleVO(Long id, String name) {
    this.id = id;
    this.name = name;
   }
}


@Repository
public interface RuleRepository extends JpaRepository<RuleVO, Long> {

    @Query("SELECT new {javaPackagePath}.RuleVO(r.id, r.name) FROM RuleVo r where r.name = :name")
    List<RuleVO> findIdByName(@Param("name") String name);
}

```

### s3

Yes, you can achieve it with projections. You have many ways to apply them:

Another option, if you want to avoid using DTO class names in your queries, is to implement your own query method using QueryDSL. With Spring Data JPA, you have to:

Create a new interface with the new method. Ex:

```
public interface RuleRepositoryCustom {
   public List<RuleProjection> findAllWithProjection();
}

```

Change your repository to extend the new interface. Ex:

```
public interface RuleRepository extends JpaRepository<RuleVO, Long>, RuleRepositoryCustom {
...

```

Create an implementation of the Custom repository using the Spring Data JPA QueryDSL support. You have to previously generate the Q clases of QueryDSL, using its Maven plugin. Ex:

```
public class RuleRepositoryImpl {

    public List<RuleProjection> findAllWithProjection() {
        QRuleVO rule = QRuleVO.ruleVO;
        JPQLQuery query = getQueryFrom(rule);
        query.orderBy(rule.name.asc());
        return query.list(ConstructorExpression.create(RuleProjection.class, rule.id, rule.name));
    }
}
```

https://stackoverflow.com/questions/37167422/how-to-fetch-only-selected-attributes-of-an-entity-using-spring-jpa
