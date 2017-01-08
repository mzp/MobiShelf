# fumi\*fumi
[![Build status](https://g.codefresh.io/api/badges/build?branch=master&repoName=fumifumi&repoOwner=mzp&pipelineName=spec&accountName=mzp)](https://g.codefresh.io/repositories/mzp/fumifumi/builds?filter=trigger:build)

fumi\*fumi is web app to manage ebooks, especially comic magazine. It imports magazines, splits these, and merges with same author.

## Setup

### Development

```sh
docker-compose build

# prepare frontend asset
docker-compose run js yarn install
docker-compose run js yarn build:js

# prepare rails env
docker-compose run app bash -i -c bundle
docker-compose run app bash -i -c './bin/rails db:setup'

# launch app/job container
docker-compose up app
docker-compose up job
```

## Usage
TBD

## LICENSE
MIT LICENSE

## Acknowledge
### `spec/fixtures/files/saint_oniisan.epub`
[聖☆おにいさん 第1話「ブッダの休日」](http://morningmanga.com/st023cc/) by 中村光 is licensed under a [Creative Commons 表示 - 改変禁止 2.1 日本 License](https://creativecommons.org/licenses/by-nd/2.1/jp/).
