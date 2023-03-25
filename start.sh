#!/bin/sh

# RAILS_ENV環境変数がproductionの場合 => 本番環境の場合
# 環境変数はDockerfileで記載
if ["${RAILS_ENV}" = "production"]
then
    bundle exec rails assets:precompile
fi

bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0
