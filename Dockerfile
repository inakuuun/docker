# ベースのイメージを指定
FROM ruby:2.7

# 環境変数を設定する定義
ENV RAILS_ENV=production

# javascript関連のライブラリをインストール
# YarnリポジトリのGPGキーの追加とソースURLの追加
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \ 
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  # アップデート可能なパッケージリスト(tee/etc/apt/source.list.d/yarn.list)を更新する =>http://www.ifelse.jp/blog/ubuntu-02
  # 実際のパッケージのインストール、アップグレードは行わない
  # --qq = エラーメッセージ以外の出力を抑制する => https://maku.blog/p/rdq2cnx/
  && apt-get update -qq \
  # Node.jsとyarnのインストール
  # -y = インタラクティブに「yes」と答える => https://webkaru.net/linux/apt-get-command/
  && apt-get install -y nodejs yarn

# ワークディレクトリを作成
WORKDIR /app

# src配下ローカルのソースコード(これから書いていくrailsのソースコード)をワークディレクトリ配下にコピー
COPY ./src /app

# ライブラリのインストール先を指定してruby関連の(Gemfile)を一括でインストールする
RUN bundle config --local set path './vendor/bundle' \
 && bundle install

# 作成したファイルをsrc直下にコピー
COPY start.sh /start.sh
# ファイルに実行権限を付与
RUN chmod 744 /start.sh
# start.shファイルを実行
CMD ["sh", "/start.sh"]
