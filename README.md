# [Fat Recipe]
![スクリーンショット 2023-11-30 16 39 46](https://github.com/sakamoto-kohei-44/Fat-Recipe/assets/130162997/d5e5b684-da65-4da6-9b00-93fedc7483b0)

[![Ruby](https://img.shields.io/badge/Ruby-v3.2.2-CC342D?logo=Ruby&logoColor=CC342D)](https://www.ruby-lang.org/ja/news/2023/03/30/ruby-3-2-2-released)
[![Rails](https://img.shields.io/badge/Rails-v7.0.8-CC0000?logo=Ruby-on-Rails&logoColor=CC0000)](https://rubyonrails.org/2023/3/13/Rails-7-0-4-3-and-6-1-7-3-have-been-released)
![TailwindCSS](https://img.shields.io/badge/tailwindcss-%2338B2AC.svg?style=flat&logo=tailwind-css&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=flat&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=flat&logo=docker&logoColor=white)
![RSpec](https://img.shields.io/badge/-RSpec-red?logo=ruby&logoColor=white&style=flat)
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=flat&logo=github&logoColor=white)
![Render](https://img.shields.io/badge/Render-%46E3B7.svg?style=flat&logo=render&logoColor=white)
## サービス概要
「Fat Recipe」は、食が細い、あるいは体質的に痩せ型の人々が
健康的な体重増加を目指したいが何を食べればいいか悩む人のために
サポートを行うOpen AI×レシピ提供サービスです。

## 想定されるユーザー層
・10代～40代のある程度料理ができる男女。<br>
・食事の量が少なく、体が細く悩んでいる人。<br>
・適切な食事を取りたいがどのような料理を作ればいいかわからない人<br>
・細マッチョに憧れて食生活を見直したい人。<br>
## サービスコンセプト
多くの人が体重を落としたいと考える現代社会ですが、体重を増やしたいと感じている人も多く存在します。<br>
特に、食事の量や質に挑戦している人、体質的に太りにくいと感じている人が、ただ増量を目的とした食事を取るだけでは十分な結果を得ることはなかなか難しくモチベーション管理も大変です。<br>
栄養バランス、カロリー摂取量、食事のタイミングや頻度など、体重を増やすための効果的なアプローチには幅広い知識が求められます。<br>
そこで、標準体重に近づきたいが何を食べればいいかわからない人向けに、AIを利用した適切な食事や体重管理を提供するサービスを提案します。<br>
売りや差別化のポイントとしては<br>
・ほとんどの健康・食事アプリは減量をメインにしていますが、このサービスは増量を目指す人に特化している点が最大の売りです。<br>
・ユーザーの体質、目標に応じてカスタマイズされた食事プランのアドバイスを提供することで、一人ひとりのニーズに合わせたサポートを実現します。<br>
・メニュー作成時に、ユーザーが嫌いな食材を避けながら、それでもバランスの取れた食事プランを提案する。これにより、食事を続けるモチベーションを維持しやすくします。<br>
・競合サービスとの差別化ポイントとして、いくつかの献立アプリでは、主に食材を指定して一週間分のレシピをAIが自動生成する機能がメインですが、カロリー管理や増量を目的としたレシピの生成機能はありません。<br>
一方、筋トレアプリではカロリー管理や体重管理をグラフ等で視覚化する機能は備えていますが、増量のための適切なレシピを生成する機能はありません。<br>
このアプリでは、カロリー情報や体重管理をグラフなどで視覚化する機能、増量のための適切なレシピを生成する機能の両方を組み合わせることで、二つのアプリの長所を取り入れた形となっており、これが最大の差別化ポイントです。<br>

## サービスの利用イメージ<br>
* 利用方法<br>
  初回アクセス時には使ってみるボタンとログインボタンを提示。<br>
メールアドレスとLINEでのログインを可能とし、ゲストユーザーも大体の機能利用を許可。<br>
ユーザーは目標体型の選択後、性別、身長、体重、活動レベルを入力して基礎代謝や一日に必要なカロリーを算出。<br>
入力データは保存され、必要な日常のカロリーやレシピ提供に利用。<br>

* ダッシュボード:<br>
ユーザーの基本情報や基礎代謝、一日に必要なカロリーを表示。<br>
体重変化推移をグラフで表示。<br>

* 献立提案:<br>
ユーザーの目標に基づく一日の献立をOpen AIにより提案。<br>

* 検索:
料理名や材料によるレシピ検索。<br>
## 実装を予定している機能

### MVP
* 会員登録
* ログイン/ログアウト機能
* ユーザーのプロフィール編集
* アレルギー項目の設定
* 目標（標準体重を目指す、細マッチョを目指す)、性別、身長、体重、目標体重、活動レベルの入力
* TDEE、必要カロリー、基礎代謝の計算(プロフィール情報を元に算出)
* ユーザーの情報と目標に合わせたOpen AIによる適切な食事の提案
* プロフィール編集画面より体重を編集し、推移をグラフで表示
* ステップ入力・確認画面
* マルチ検索・オートコンプリート
  ユーザーが簡単に食材やレシピを検索できるようにする
* 嫌いな食材設定機能：(嫌いな食材を選択)
### その後の機能
* LINE認証
* 管理者画面
* Rspec
* ローディングスピナーの実装: 「レシピを生成中...」のようなメッセージの表示。
* 利用規約、プライバシーポリシー
* 退会処理機能
* レスポンシブ対応
* 独自ドメイン取得

### 使用するAPI
* Spoonacular API
* LINE Developers API
* Open AI API(GPT-4)
* DeepL API
### [Figma画面遷移図](https://www.figma.com/file/mL0abUN3kCBi2m0N5zho9w/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0%3A1&mode=design&t=5YZK4sMShNtMJ1Uk-1)
### ER図
![スクリーンショット 2023-12-01 13 04 32](https://github.com/sakamoto-kohei-44/Fat-Recipe/assets/130162997/32f84e47-33ea-4707-9f27-d970e1acaa19)
### 技術選定<br>
* フロントエンド<br>
  JavaScript<br>
  Node.js6.17.0<br>
* CSSフレームワーク<br>
  Tailwind css<br>
* バックエンド<br>
  Ruby on Rails 7.0.8<br>
  Ruby 3.2.2<br>
* RDS<br>
  PostgreSQL<br>
* 認証・認可<br>
  Sorcery<br>
* デプロイ<br>
  Heroku<br>
* 環境構築<br>
  Docker<br>
* バージョン管理<br>
  GitHub<br>
* テスティング<br>
   RSpec<br>
   Capybara<br>
   rubocop
