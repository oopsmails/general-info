
# Understanding Public and Private Keys


## Concepts

- Public key is used to decrypt information
- Private key is used to encrypt information

## The process

Sender: If A wants to broadcast an information, he needs to do:

- Prepare the information, 
- Hash the information, message digest, ?, for indexing, make it faster for everyone to retrieve. More importantly, this is the only index to the information, cannot be interchanged.
Hashing algorithm (e.g., CRC, MD5, SHA1, SHA256, etc)
- Encrypt it and generate an encoded message (secret message)
- Need to broadcast
    - the information
    - the public key
    - the secret

Receiver: If B wants to retrieve the information and verify it is really from A, needs to do

- Retrieve the information
- Hash the information to get FIRST message digest
- Retrieve the public kay and the secret
- Decrypt the secret with the public key, to get SECOND message digest
- Compare the FIRST and the SECOND messages, if same, then consider the message is really from A, because the SECOND is encrypted from a private key only holding by A



- 



