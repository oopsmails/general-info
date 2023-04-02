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

### Q; could you list all commonly used accessibility attributes? I know beside role, there are aria-labelledby, aria-readonly, etc.

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
