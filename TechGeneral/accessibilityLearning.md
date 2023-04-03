## Cell phone

- using Accessibility, voice assistant

- For iOS phones, go to Settings > General >Accessibility > VoiceOver > Turn VoiceOver on.

tabindex=0, will make separate clickable

https://indepth.dev/posts/1152/angular-a11y-11-tips-on-how-to-make-your-apps-more-accessible

https://developers.google.com/web/fundamentals/accessibility/how-to-review

## Web Page

- using JAWS for Windows

## Accessibility Terms

### Q: so, we can define the name of role ... it is just feeding to screen reader .... am I understanding it correctly?

A: Yes, you are correct. The role attribute in HTML is used to define the role or type of an element on the web page, and it is primarily used to provide additional semantic information to assistive technologies, such as screen readers.

By specifying a role for an element, you can help assistive technologies to better understand the purpose and function of that element, and to present the content to users in a more accessible way. For example, if you use role="button" on a clickable element that is not a standard button element, it will be read out as a button by a screen reader.

The role attribute can be used on any HTML element, and it is possible to define custom roles if needed. However, it is important to use the correct role for the element to ensure proper accessibility. Defining the correct role attribute can make a significant difference in the usability and accessibility of your web page for users with disabilities.

### Q: could you list all commonly used accessibility attributes? I know beside role, there are aria-labelledby, aria-readonly, etc.

A: Sure, here are some commonly used accessibility attributes in HTML:

- aria-label - used to provide a text label for an element that is not visible on the screen or that does not have a visible label.
- aria-labelledby - used to associate an element with one or more labels elsewhere in the document.
- aria-describedby - used to describe the purpose or function of an element, often in greater detail than an aria-label.
- aria-hidden - used to indicate that an element and its content are not relevant or important to the current context and should be hidden from assistive technologies.
- aria-expanded - used to indicate whether a collapsible element is currently expanded or collapsed.
- aria-selected - used to indicate whether an element is selected or not, such as in a list or dropdown menu.
- aria-disabled - used to indicate that an element is disabled and cannot be interacted with.
- aria-readonly - used to indicate that an element is read-only and cannot be modified by the user.
- aria-live - used to indicate that an element's content is dynamic and should be announced to the user as it changes.
- aria-controls - used to indicate the ID of an element that controls the behavior or state of another element.

These attributes, along with the role attribute, are used to provide additional semantic information about the purpose and behavior of elements on the web page, and help to improve the accessibility of the content for users with disabilities.

### Q: generally, if I put role=row on tr, do I still need to put role on td? e.g, role=gridcell

If you are using role="row" on the tr element, you do not necessarily need to use role="gridcell" on the td element, as the td element is already semantically associated with the tr element as a cell within the row.

However, you may still want to use role="gridcell" on the td element in some cases, such as when you have a complex table structure with cells that span multiple rows or columns. In these cases, using role="gridcell" on the td element can provide additional semantic information about the structure of the table and improve accessibility.

It is important to note that the use of role attributes should be done judiciously, and only when necessary to improve accessibility. Overuse of role attributes can actually make the content less accessible by confusing assistive technologies and making it harder for them to understand the structure of the page.

### Q: normally, what html tags need to add accessibility attributes?

All HTML tags can benefit from the addition of accessibility attributes, as they help to provide additional semantic information to assistive technologies and improve the accessibility of the content. However, some HTML tags are more commonly associated with accessibility attributes than others.

Here are some examples of HTML tags that commonly benefit from accessibility attributes:

- img - should include an alt attribute that describes the content of the image for users who cannot see it.
- a - should include a title attribute that provides additional information about the purpose of the link, and may also include an aria-label attribute for more descriptive information.
- input - should include a label element that describes the purpose of the input field, and may also include additional attributes such as aria-label or aria-describedby to provide more information.
- table, tr, td, and th - should include appropriate role attributes to describe the structure and purpose of the table and its cells.
- form - should include appropriate label elements to describe the purpose of the form fields and may also include aria-label or aria-describedby attributes for additional information.
- button - should include a title attribute that provides additional information about the purpose of the button, and may also include an aria-label attribute for more descriptive information.
- select - should include a label element that describes the purpose of the select field, and may also include additional attributes such as aria-label or aria-describedby to provide more information.

These are just a few examples, but the principle holds true for all HTML tags: adding appropriate accessibility attributes can help to make the content more accessible to users with disabilities.

### Q: aria-label vs aria-labelledby

aria-label can be used in cases where text that could label the element is not visible. If there is visible text that labels an element, use aria-labelledby instead. The purpose of aria-label is the same as aria-labelledby . Both provide an accessible name for an element

aria-label and aria-labelledby are both attributes that can be used to provide accessible names for HTML elements, but they work in different ways.

aria-label is used to provide a text alternative for an element, independent of any other text on the page. It should be used when an element has no visible label or when the visible label is insufficient to convey the element's purpose to users of assistive technologies. For example, if you have an icon that serves as a button but has no text label, you can use aria-label to provide a text alternative that describes the button's purpose.

Example usage:

```
<button aria-label="Search"><i class="fa fa-search"></i></button>
```

In the above example, the aria-label attribute provides a text label for the search button.

aria-labelledby, on the other hand, is used to associate an element with one or more labels elsewhere in the document. It takes a space-separated list of IDs of elements that contain text labels for the element. This is useful when the label for an element is visible elsewhere on the page, such as in a label element or a heading.

Example usage:

```
<div id="title">Search</div>
<input type="text" aria-labelledby="title">
```

In the above example, the input element is associated with the title element using the aria-labelledby attribute, which indicates that the title element serves as the label for the input element.

In summary, aria-label should be used when an element has no visible label or when the visible label is insufficient to convey the element's purpose, while aria-labelledby should be used when an element is associated with one or more visible labels elsewhere on the page.

### Q: should I use aria-label="add new row" or aria-label="add-new-row"?

When using aria-label, it is generally recommended to use plain text and avoid special characters such as hyphens or underscores. Therefore, in your example, aria-label="add new row" would be the preferred option.

Using plain text is generally easier for screen readers and other assistive technologies to understand and interpret, as they are designed to read and process natural language text. Using special characters such as hyphens or underscores may introduce confusion and make it harder for these technologies to interpret the label correctly.

In summary, when using aria-label, it's best to keep it simple and use plain text labels that accurately describe the purpose or function of the element.

### Q: so, aria-label="addNewRow" might be better? because screen reader will not read space out?

While it's true that screen readers will not read spaces out loud when reading aria-label values, it's still generally recommended to use plain text and separate words with spaces rather than camelCase or other alternatives. This is because plain text is easier to read and understand for most users, including those with cognitive disabilities, learning difficulties, or non-native language speakers.

In addition, using spaces to separate words in aria-label values can still provide some benefit, as some screen readers may pause slightly between words, which can help to make the label easier to understand and parse.

So in your example, aria-label="add new row" would still be the preferred option, as it provides a clear, simple label that accurately describes the purpose of the element in natural language text.
