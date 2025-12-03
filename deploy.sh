#!/bin/bash

set -e

npm run build

# 確保 gh-pages 目錄存在
if [ ! -d "./gh-pages" ]; then
  echo "gh-pages worktree not found. Please run:"
  echo "git worktree add gh-pages gh-pages"
  exit 1
fi

# 清空 gh-pages 分支內容（保留 .git）
rm -rf gh-pages/*

# 複製 dist 的所有內容
cp -r dist/* gh-pages/

# 加上 .nojekyll 以避免底線資料夾被 Jekyll 擋住
touch gh-pages/.nojekyll

cd gh-pages
git add .
git commit -m "deploy"
git push origin +gh-pages
cd ..
