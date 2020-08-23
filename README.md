ブラウザのADsenceをOFFしてください

# init
### docker-compose編集
cdから先をプロジェクト名に
'''
    command: >
      bash -c "cd phase_nuxt_sample&&
      npm run dev"
'''

### docker-composeイメージ作成
`$ docker-compose build`

### docker シェル
`docker-compose run nuxt.js bash`

### 初期プロジェクト作成
`yarn create nuxt-app <project-name>`
質問内容は以下を参照
[nuxt install](https://ja.nuxtjs.org/guide/installation/)

# ローカルで動作確認(別コンソール)
### dockerイメージ再構築
`$ docker-compose build`

### サーバ起動
```
# コンテナ起動
$ docker-compose up -d

# サーバの状態確認
$ docker-compose ps
```

### localhostで確認
ブラウザで
`http://localhost:3100/`


# firebaseプロジェクト作成
### ブラウザから準備
[firebase](https://firebase.google.com/?hl=ja)からプロジェクト作成
アプリ名を設定後、Webを作成

### firestone
アプリ作成後、Databaseからデータベース作成

# firebase　deploy(shで確認)
### firebase-toolsをnode(docker)に追加
`$ yarn global add firebase-tools`

### firebase login 
`$ firebase login --no-localhost`
firebase loginし、トークン取得し、ターミナルに貼り付け

### firebase init 
`$ firebase init`
Firestore,Hostingを選択

公開ディレクトリを`dust`に設定
`? What do you want to use as your public directory? (public) dist`

SPA として設定するか? y
`? Configure as a single-page app (rewrite all urls to /index.html)? (y/N) y`

### アプリケーションをビルド
`$ npm run generate`
か
`$ yarn generate`

### firebase deploy
`$ firebase deploy`

# 確認
firebase console
開発 > HostingからURL確認し確認

ブラウザからインストール可能

またスマホから確認し、ホームに追加が可能

# アプリの変更を反映させる方法
### アプリケーションをビルド
`$ npm run generate`
か
`$ yarn generate`

### firebase deploy
`$ firebase deploy`

# 参考元
[dockerでnuxt.jsの環境を作ってみる](https://qiita.com/reflet/items/e7c33f84ab43ab237ee4)<br>
[Nuxt.js プロジェクトを Firebase Hosting にデプロイして公開する方法](https://upd.world/nuxtjs-deploy-firebase-hosting/)<br>
[Nuxt.js で PWA(Progressive Web Apps) のベースアプリを作る](https://riotz.works/articles/lulzneko/2019/05/09/develop-base-app-for-pwa-with-nuxtjs/)<br>
[作りながら学ぶVue！Slack風クローンアプリを作ろう【JS初心者でも可】](https://note.com/cohki0305/n/ne21cd96137ec)<br>
[Docker×Nuxt×Firebaseを使ってSPAxPWAのWEBアプリ開発環境を構築する](https://www.bravesoft.co.jp/blog/archives/3942)
