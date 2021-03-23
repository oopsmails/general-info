
# The difference between Encryption, Hashing and Salting

- Ref:

https://www.thesslstore.com/blog/difference-encryption-hashing-salting/


## In Summary

- Encryption is a two-way function where information is scrambled in such a way that it can be unscrambled later.
- Hashing is a one-way function where data is mapped to a fixed-length value. Hashing is primarily used for authentication.
- Salting is an additional step during hashing, typically seen in association to hashed passwords, that adds an additional value to the end of the password that changes the hash value produced.


## What is Encryption?

Encryption is the practice of scrambling information in a way that only someone with a corresponding key can unscramble and read it. Encryption is a two-way function. When you encrypt something, you’re doing so with the intention of decrypting it later.

This is a key distinction between encryption and hashing.

### Historical encryption algorithms

- Ciphers

### Modern Encryption

- Asymmetric Encryption – This is the Public Key example we just gave. One key encrypts, the other key decrypts. The encryption only goes one way. This is the concept that forms the foundation for PKI (public key infrastructure), which is the trust model that undergirds SSL/TLS.

- Symmetric Encryption – This is closer to a form of private key encryption. Each party has its own key that can both encrypt and decrypt. As we discussed in the example above, after the asymmetric encryption that occurs in the SSL handshake, the browser and server communicate using the symmetric session key that is passed along

- Modern Encryption Algorithms: 
    - AES (Advanced Encryption Standard)
    - RSA – RSA stands for Rivest-Shamir-Adlemen, after its creators, it is a public key encryption algorithm (asymmetric) that has been around since 1978 and is still widely used today.
    - ECC – ECC stands for Elliptic Curve Cryptography, which relies on the algebraic structure of elliptical curves over finite fields. Although ECC has been around since 1985, it’s only been in use since about 2004. ECC has distinct advantages over RSA and is likely going to play a more prominent role in the future of SSL/TLS.
    - PGP – PGP stands for Pretty Good Privacy

### When should encryption be used?
As we discussed earlier, encryption is a two-way function. You encrypt information with the intention of decrypting it later. So, correspondence with someone online, protecting your cloud data or transmitting financial data are all examples of times when encryption is appropriate.


## What is Hashing?

The key is that encryption is reversible. Hashing is not.

### Common Hashing Algorithms

MD4, MD5, SHA ...


## What is Salting?

Salting is a concept that typically pertains to password hashing. Essentially, it’s a unique value that can be added to the end of the password to create a different hash value. 



