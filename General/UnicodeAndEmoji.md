
# Unicode and Emoji

- Ref:
https://nurkiewicz.com/41

## Terms

- ASCII

The first commonly used attempt was called ASCII. American Standard Code for Information Interchange. In short, it’s a table of 127 symbols and their respective numbers. 

- UTF-8 ...

To save on storage we can use just two bytes for the majority of characters. But for these less frequent we use 4. So one character is sometimes encoded with 2, sometimes with 4 bytes. It’s more complicated, but saves a lot of space. Such encoding in named UTF-16. However, the most commonly used encoding is UTF-8. Which also happens to be the most complex one. It uses 1, 2, 3 or 4 bytes to represent one character. The decoding algorithm is a bit convoluted but UTF-8 has one major advantage: it is backward compatible with ASCII. This means that a UTF-8 document using only American chatacters can be opened as ASCII. That’s because Latin characters A through Z are encoded using just one byte. Just like ASCII. UTF-16 and UTF-32 opened as ASCII file will look like garbage.

## Notes:

- The decoding algorithm is a bit convoluted but UTF-8 has one major advantage: it is backward compatible with ASCII. This means that a UTF-8 document using only American chatacters can be opened as ASCII. That’s because Latin characters A through Z are encoded using just one byte. Just like ASCII. UTF-16 and UTF-32 opened as ASCII file will look like garbage.

- Emojis

To make matters worse, there are emojis. You know, tears of joy, heart, and poo pictograms. They are standardized as well! But to make things more complex, some emojis use multiple code points. For example there are skin tone modifiers that change the default yellow skin of emojis. Also, if you put a woman 👩 and a rocket 🚀 emoji next to each other, you’ll get a single emoji. A lady astronaut 👩‍🚀. I kid you not! It gets better. Placing a man 👨, a woman 👩, a girl 👧 and a boy 👦 next to each other renders as a one family emoji. All concatenated with special joiner character. This means that a single symbol can be encoded with as many as 7 code points. And 28 bytes in UTF-32. One emoji!

