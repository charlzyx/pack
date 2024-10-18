#!/bin/bash

# 模拟 GitHub Actions 环境
export GITHUB_OUTPUT="github_output.txt"
export GITHUB_ENV="github_env.txt"

# 测试不同的标签
test_tag() {
    local tag=$1
    echo "测试标签: $tag"
    export GITHUB_REF="refs/tags/$tag"
    
    # 运行 action.sh
    ./action.sh
    
    # 显示输出
    echo "GITHUB_OUTPUT 内容:"
    cat $GITHUB_OUTPUT
    echo "GITHUB_ENV 内容:"
    cat $GITHUB_ENV
    echo "-------------------"
}

# 清理函数
cleanup() {
    rm -f $GITHUB_OUTPUT $GITHUB_ENV
}

# 运行测试
test_tag "node14"
cleanup

test_tag "node16-bun1.0.0-python3.9-bullseye-slim"
cleanup

test_tag "node10"
cleanup

test_tag "node18.15.0-bun0.5.7-python3.10"
cleanup

echo "测试完成"