#!/bin/bash

# 快速部署脚本 - 使用 npx 避免权限问题

set -e

echo "🚀 快速部署到 GitHub 和 Vercel"
echo "================================"
echo ""

cd "$(dirname "$0")"

# 步骤 1: GitHub 部署
echo "📦 步骤 1: 部署到 GitHub"
echo ""

# 检查 GitHub CLI
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI 未安装，请运行: brew install gh"
    exit 1
fi

# 检查认证
if ! gh auth status &> /dev/null; then
    echo "⚠️  需要登录 GitHub..."
    echo "请按照浏览器提示完成登录："
    gh auth login --web
    echo ""
fi

# 检查远程仓库
if ! git remote | grep -q "^origin$"; then
    echo "创建 GitHub 仓库..."
    REPO_NAME="luckypacket-landing-pages"
    gh repo create "$REPO_NAME" --public --source=. --remote=origin --push --confirm
    echo "✅ 仓库已创建并推送！"
else
    echo "推送到现有仓库..."
    git push origin main || git push origin master || git push -u origin main
    echo "✅ 代码已推送到 GitHub！"
fi

echo ""
echo ""

# 步骤 2: Vercel 部署
echo "🌐 步骤 2: 部署到 Vercel"
echo ""

# 使用 npx 运行 Vercel（不需要全局安装）
echo "使用 Vercel CLI 部署（通过 npx）..."
echo ""

read -p "是否现在部署到 Vercel? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    echo "🔐 如果提示登录，请按照浏览器指示完成登录..."
    echo ""
    npx vercel --prod --yes
    
    echo ""
    echo "✅ 部署完成！"
else
    echo ""
    echo "您可以稍后运行以下命令部署："
    echo "  npx vercel --prod"
    echo ""
    echo "或者访问 https://vercel.com 使用 Web 界面部署"
fi

echo ""
echo "🎉 完成！"
echo ""
echo "📝 总结："
echo "  ✅ 代码已推送到 GitHub"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "  ✅ 已部署到 Vercel"
else
    echo "  ⏸️  Vercel 部署待完成"
fi
echo ""
echo "查看您的项目："
gh repo view --web 2>/dev/null || echo "  GitHub: $(git remote get-url origin 2>/dev/null || echo '需要设置远程仓库')"

