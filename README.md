# Live-chat-app
WebSocket通信を使用したチャットアプリケーション
<img width="1636" alt="スクリーンショット 2022-07-14 13 51 51" src="https://user-images.githubusercontent.com/65525612/178901939-b762fd9b-6424-44b5-8fba-22d0044932de.png">

## 使用技術
- フロントエンド
    - Vue.js 2.6.14
- バックエンド
    - Ruby on Rails 6.x.x
- 主要ライブラリ
    - axios
    - actioncable
    - vuetify

## ディレクトリ構造
```
.
├── README.md
├── api
│   ├── Dockerfile
│   └── ...
│
├── docker-compose.yml
└── front
    └── Dockerfile
    └── ...
```

## テストユーザー
rails cコマンドでユーザーを作成してください

## 環境構築

```bash
docker-compose build
docker-compose up -d
docker-compose exec api rails db:migrate
docker-compose exec api rails db:seed
```
