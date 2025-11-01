#!/bin/bash

# LuckyPacket 部署脚本
# 用于快速推送到 GitHub

set -e

echo "🚀 LuckyPacket 部署脚本"
echo "======================"
echo ""

# 检查是否在正确的目录
if [ ! -f "README.md" ]; then
    echo "❌ 错误: 请在项目根目录运行此脚本"
    exit 1
fi

# 检查 Git 是否已初始化
if [ ! -d ".git" ]; then
    echo "❌ 错误: Git 仓库未初始化"
    exit 1
fi

# 显示当前状态
echo "📊 当前 Git 状态:"
git status --short
echo ""

# 检查是否有未提交的更改
if ! git diff-index --quiet HEAD --; then
    echo "⚠️  发现未提交的更改"
    read -p "是否要提交这些更改? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "请输入提交信息: " commit_msg
        if [ -z "$commit_msg" ]; then
            commit_msg="Update project files"
        fi
        git add .
        git commit -m "$commit_msg"
    fi
fi

# 检查远程仓库
if git remote | grep -q "^origin$"; then
    REMOTE_URL=$(git remote get-url origin)
    echo "✅ 已配置远程仓库: $REMOTE_URL"
    echo ""
    
    # 询问是否推送
    read -p "是否要推送到 GitHub? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "📤 推送代码到 GitHub..."
        git push origin main || git push origin master
        echo "✅ 推送完成!"
    fi
else
    echo "⚠️  未配置远程仓库"
    echo ""
    echo "请先创建 GitHub 仓库，然后运行以下命令："
    echo ""
    echo "  git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git"
    echo "  git branch -M main"
    echo "  git push -u origin main"
    echo ""
    echo "或者访问: https://github.com/new 创建新仓库"
fi

echo ""
echo "📝 下一步：部署到 Vercel"
echo "   1. 访问 https://vercel.com"
echo "   2. 登录并导入您的 GitHub 仓库"
echo "   3. 点击 'Deploy'"
echo ""
echo "详细步骤请查看 DEPLOYMENT.md"
echo ""

