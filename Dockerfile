# ベースのイメージを指定
FROM ruby:2.7
# javascript関連のライブラリをインストール
    # YarnリポジトリのGPGキーの追加とソースURLの追加
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \ 
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  # アップデート可能なパッケージリスト(tee/etc/apt/source.list.d/yarn.list)を更新する =>http://www.ifelse.jp/blog/ubuntu-02
  # 実際のパッケージのインストール、アップグレードは行わない
  && apt-get update -qq \
  # --qq = エラーメッセージ以外の出力を抑制する => https://maku.blog/p/rdq2cnx/
  # Node.jsとyarnのインストール
  && apt-get install -y nodejs yarn
  # -y = インタラクティブに「yes」と答える => https://webkaru.net/linux/apt-get-command/
# ワークディレクトリを作成
WORKDIR /app
# src配下ローカルのソースコード(これから書いていくrailsのソースコード)をワークディレクトリ配下にコピー
COPY ./src /app
# ライブラリのインストール先を指定してruby関連の(Gemfile)を一括でインストールする
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install
