# pack

## node 基础打包环境

bun / npm / yarn / python3

- charlzyx/pack:node10-buster
- charlzyx/pack:node10-buster-slim
- charlzyx/pack:node12-bullseye
- charlzyx/pack:node12-bullseye-slim
- charlzyx/pack:node14-bullseye
- charlzyx/pack:node14-bullseye-slim
- charlzyx/pack:node16-bullseye
- charlzyx/pack:node16-bullseye-slim
- charlzyx/pack:node18-bullseye
- charlzyx/pack:node18-bullseye-slim
- charlzyx/pack:node20-bullseye
- charlzyx/pack:node20-bullseye-slim

base on

- node:10-buster
- node:10-buster-slim
- node:12~20-bullseye
- node:12~20-bullseye-slim

## 自定义 ${PWD}/build.sh

```bash
docker run -v "$PWD":/app --rm -it chaogpt/pack:node16-slim bash -lc "ls -al && ./build.sh"
```
