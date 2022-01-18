

# Run ELM


## Frontend:

https://github.com/nuonuoge/ionic6_angular10_elm

```
注意：由于涉及大量的 ES6/7 等新属性，node 需要 6.0 以上版本
npm install -g cordova ionic // 需要全局安装cordova ionic

git clone https://github.com/nuonuoge/ionic4_angular6_elm.git  

cd ionic4_angular6_elm

npm install

npm start

```


## Backend:

https://github.com/bailicangdu/node-elm


```
项目运行之前，请确保系统已经安装以下应用
1、node (6.0 及以上版本)
2、mongodb (开启状态)
3、GraphicsMagick (裁切图片)
git clone https://github.com/bailicangdu/node-elm  

cd node-elm

npm install 或 yarn(推荐)

npm run dev

访问: http://localhost:8001（如果已启动前台程序，则不需打开此地址）

```

- mongodb

general-info/mongodb/docker-compose-mongodb.yml


### Commands

```

sudo docker logs mongodb

sudo docker logs -f --tail 100 mongodb

sudo docker exec -it mongodb bash

docker cp /dev/elm/elm-db-bk mongodb:/elm-db-bk

sudo docker cp ~/Documents/dev/elm/elm-db-bk mongodb:/elm-db-bk

sudo docker exec -i mongodb /usr/bin/mongorestore --username root --password root --authenticationDatabase admin --db elm /elm-db-bk


```

