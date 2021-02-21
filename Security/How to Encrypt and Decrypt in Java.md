
# Keystore, OpenSSL and Keytool

## General,

- Public key should be given to someone, which will be used to encrypt the data.
Private will be used to decrypt the data.


## Example 1: How to Encrypt/Decrypt text in a file in Java

https://stackoverflow.com/questions/34121787/how-to-encrypt-decrypt-text-in-a-file-in-java


- Sender:

```

UPDATE:

Now I can decrypt the simmetric key using the receiver's private key. But I dont know how to create a decoder using the same argument when I encrypted the message.

Sender's code to encrypt plain text.

    String key = "Bar12345Bar12345"; // 128 bit key
    String initVector = "RandomInitVector"; // 16 bytes IV
    IvParameterSpec iv = new IvParameterSpec(initVector.getBytes("UTF-8"));
    System.out.println(iv.getIV());
    SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
    Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
    cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
    byte[] ciphertext = cipher.doFinal(plainText);
Receiver's decryption 1

    SecretKeySpec keySpec = new SecretKeySpec(decryptedKeySpec, "AES");
    Cipher decoder = Cipher.getInstance("AES");
    decoder.init(Cipher.DECRYPT_MODE, keyspec);
    byte[] original = descipher.doFinal(message);
ERROR: Given final block not properly padded

Receiver's decryption 2

    SecretKeySpec keySpec = new SecretKeySpec(decryptedKeySpec, "AES");
    Cipher decoder = Cipher.getInstance("AES/CBC/PKCS5PADDING");
    decoder.init(Cipher.DECRYPT_MODE, keyspec);
    byte[] original = descipher.doFinal(message);
ERROR: Parameters missing

```

Ok i got it, i was not receiving a different text, it was the text i wanted but it was Base64, so, the only thing i had to do was convert it to String like this: new String(myBase64), I will update the code here so people can get it. 


## Example 2: Extracting a Private Key From the Java Keystore (JKS)

https://dzone.com/articles/extracting-a-private-key-from-java-keystore-jks


To begin with, let's create a simple KeyStore:

1
keytool -genkeypair -alias notebook -keyalg RSA -dname "CN=rajind,OU=dev,O=bft,L=mt,C=Srilanka" -keystore identity.jks -keypass keypassword -storepass storepassword


Extracting the Private Key With OpenSSL and Keytool
1. Convert JKS to the PKCS12 format:

1
keytool -importkeystore -srckeystore identity.jks -srcstorepass storepassword -srckeypass keypassword -srcalias notebook -destalias notebook -destkeystore identity.p12 -deststoretype PKCS12 -deststorepass password -destkeypass password


Note that we have given the destkeypass and deststore pass the same value. This is a requirement of PKCS12 as it does not support different passwords for key store and key. If you try to give different passwords, you’ll get a warning as follows as the destkeypass will be ignored.

1
Warning: Different store and key passwords not supported for PKCS12 KeyStores. Ignoring user-specified -destkeypass value.


The final result of this step would be an identity.p12 file.

2. Exporting the private key from the PKCS12 format keystore:

1
openssl pkcs12 -in identity.p12 -nodes -nocerts -out private_key.pem


Once you enter this command, you will be prompted for the password, and once the password (in this case ‘password’) is given, the private key will be saved to a file by the named private_key.pem.

Note that in this command, nodes means ‘don’t encrypt private keys’ and nocerts means ‘don’t output certificates,’ which are the public keys.

Use the following help commands to get more details on them.

1
keytool -importkeystore –help
2
openssl pkcs12 –help


Exporting the Public Key:

1
openssl pkcs12 -in identity.p12 -nokeys -out cert.pem


Happy extracting!







