
# Redis on Windows Docker

- First, 

https://redislabs.com/blog/redis-on-windows-10/

Windows 10 users run Redis on their own dev machines. Yes, you heard right. Starting with Windows 10 (v1709 – 2017-09, Fall Creators Update), you can run at least a half-dozen flavors of Linux on the Windows Subsystem for Linux (WSL), and you can run Redis on top of them. No VM required. No Docker. No joke!

============================================

https://koukia.ca/installing-redis-on-windows-using-docker-containers-7737d2ebc25e

## Pull redis image

docker pull redis

## Run redis image

docker run --name some-redis -d redis

This image includes EXPOSE 6379 (the redis port), so standard container linking will make it automatically available to the linked containers (as the following examples illustrate).

docker run --name redis -p 6379:6379 redis
docker run --name redis -d -p 6379:6379 redis

## Test Redis (Not working)

- Connect to the Redis server
In order to connect to this instance that we just setup, you need to install Redis Client for windows.

https://redislabs.com/blog/get-redis-cli-without-installing-redis-server/



- Then you can try Redis commands to save values in Redis and get them.
Try commands like the following:
c:\> redis-cli
127.0.0.1:6379> set yourkey "your test value"
OK
127.0.0.1:6379> get yourkey
"your test value"
127.0.0.1:6379>


## Test Redis (working): using npm

https://www.npmjs.com/package/redis-cli

- rdcli -h 192.168.99.100

PS C:\Users\liu\Downloads\Software\Redis-x64-3.0.504> npm install -g redis-cli
C:\nodejs\rdcli -> C:\nodejs\node_modules\redis-cli\bin\rdcli

> core-js@3.1.4 postinstall C:\nodejs\node_modules\redis-cli\node_modules\core-js
> node scripts/postinstall || echo "ignore"

Thank you for using core-js ( https://github.com/zloirock/core-js ) for polyfilling JavaScript standard library!

The project needs your help! Please consider supporting of core-js on Open Collective or Patreon:
> https://opencollective.com/core-js
> https://www.patreon.com/zloirock

Also, the author of core-js ( https://github.com/zloirock ) is looking for a good job -)

+ redis-cli@1.3.1
added 12 packages from 16 contributors in 12.032s
PS C:\Users\liu\Downloads\Software\Redis-x64-3.0.504> rdcli
127.0.0.1:6379> (error) Redis connection to 127.0.0.1:6379 failed - connect ECONNREFUSED 127.0.0.1:6379
PS C:\Users\liu\Downloads\Software\Redis-x64-3.0.504> (error) Redis connection to 127.0.0.1:6379 failed - connect ECONNREFUSED 127.0.0.1:6379^C
PS C:\Users\liu\Downloads\Software\Redis-x64-3.0.504>
PS C:\Users\liu\Downloads\Software\Redis-x64-3.0.504>
PS C:\Users\liu\Downloads\Software\Redis-x64-3.0.504>
PS C:\Users\liu\Downloads\Software\Redis-x64-3.0.504> rdcli -h 192.168.99.100
192.168.99.100:6379> set yourkey "your test value"
OK
192.168.99.100:6379> get yourkey
your test value
192.168.99.100:6379>



## Connect to Redis bash:
winpty docker exec -it redis bash

## Redis commands:

`redis-cli FLUSHALL -> flushall`

`redis-cli FLUSHDB -> flushdb`

Delete all keys of the specified Redis database:

`redis-cli -n <database_number> FLUSHDB`

