# JPA / Hibernate CriteriaQuery — fetching a partial entity and child with joins using createTupleQuery

## The problem and solution

I recently worked through a N+1 queries problem with Hibernate that was a bit of a struggle, and involved a lot of trial and error, so I thought I'd share the results of my efforts. I wanted to fetch an entity, but only some of its fields. The fields I wanted included a simple field (a String), as well as a child object. And I wanted to get the whole thing in a single query.

I have a couple of Hibernate entities backed by a mysql database. Let's call them Book , Author , and Publisher . Here's the Book :

```
@Entity
public class Book {
  String title;
  String isbn;
  Long year;
  @OneToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "authorId")
  @Fetch(FetchMode.JOIN)
  private Author author;
  @OneToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "publisherId")
  @Fetch(FetchMode.JOIN)
  private Publisher publisher;
  public Book(String title, Author author) {
    this.title = title;
    this.author = author;
  }
  // other constructors
  // accessors
  // etc.
}

```

I was tasked with writing an API that returned the title and author of every book. In my case, Author and Publisher are complex entities, so I would like to not fetch the Publisher from the database if I can avoid it. Also, I don't need the parent object's isbn or year in this particular API response.

My initial code worked great and it looked like this:

```
// works, but has an N+1 problem.  probably don't do this
CriteriaBuilder cb = session.getCriteriaBuilder();
CriteriaQuery<Book> cq = cb.createQuery(Book.class);
Root<Book> entity = cq.from(Book.class);
Predicate predicate = entity.get("year").in(targetYear);
cq.where(predicate);
cq.multiselect(
  entity.get("title"),
  entity.get("author")
);
Stream<Book> = session.createQuery(cq).getResultStream();

```

Looks good and did everything I wanted it to do. I needed a Book constructor that accepted a title and an author, and it all worked. Product shipped, ticket closed.

Fast forward to a database with 10,000 books and the performance was terrible. By configuring JPA to log the queries being executed, I saw I had a classic N+1 query problem — Hibernate executed one query to get the books, and then one more query per book, to get the Authors. 10,001 queries to get 10,000 books.

I found lots of stackoverflow posts on this topic, but none of them worked for me. For one thing, they felt only partially complete — they advised creating a javax.persistence.criteria.join, but didn't provide enough information on what to with that join. When I tried it, N+1 remained:

```
// also works, but also has an N+1 problem. probably don't do this
// either
CriteriaBuilder cb = session.getCriteriaBuilder();
CriteriaQuery<Book> cq = cb.createQuery(Book.class);
Root<Book> entity = cq.from(Book.class);
Join<Book, Author> bookAuthorJoin =
    entity.join("author", JoinType.LEFT);
cq.multiselect(
  entity.get("title"),
  bookAuthorJoin
);
Stream<Book> = session.createQuery(cq).getResultStream();

```

Another common error I came across, as I tried different combinations of Join and Fetch and Subquery and setHint and everything else I saw mentioned on SO, was this one:

_query specified join fetching, but the owner of the fetched association was not present in the select list_

Most of the SO explanations indicated this is because we aren't really fetching a Book, but instead we are fetching a String (the title), along with the Author . But I couldn't translate that into a working method.

I finally find the right combination of things to make it work, and I hope this helps you with your project as well. createTupleQuery gave me what I needed, and I'll include a more compete example than what I could find online:

```
// fetches only the fields of Book that I ask for,
// and fetches all fields of the Author, in a single
// query
CriteriaBuilder cb = session.getCriteriaBuilder();
CriteriaQuery<Tuple> cq = cb.createTupleQuery();
Root<Book> entity = cq.from(Book.class);
Join<Book, Author> bookAuthorJoin =
    entity.join("author", JoinType.LEFT);
cq.multiselect(
  entity.get("title"),
  bookAuthorJoin
);
Stream<Book> result =
    session.createQuery(cq).getResultStream().map(tuple ->
      new Book(
        tuple.get(entity.get("title")),
        tuple.get(bookAuthorJoin)
      ));

```

There must be a lot of magic under the hood that this doesn't generate any type-safety warnings in my idea, but it works, runs a single query, and joins together the two hibernate entities while only fetching the parts that I need to build my API response.

The savings from solving the N+1 problem are huge. (In my real life case, with more complicated objects, query time when from 21,000ms to 950ms). As a practical matter, skipping the fetch of the Book.isbn and the Book.year saves me almost nothing, but not having to join on the Publisher table is definitely a win. If you're solving a similar problem, a **CriteriaQuery<Tuple>** might be the way to go.

## Ref:

https://mikekowdley.medium.com/hibernate-criteriaquery-fetching-a-partial-entity-and-child-with-joins-984987545dd2
