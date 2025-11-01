#!/bin/bash

# 自动化部署脚本 - GitHub & Vercel
# 这个脚本会自动安装必要的工具并引导您完成部署

set -e

echo "🚀 LuckyPacket 自动化部署脚本"
echo "================================"
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查是否在正确的目录
if [ ! -f "README.md" ]; then
    echo -e "${RED}❌ 错误: 请在项目根目录运行此脚本${NC}"
    exit 1
fi

# 1. 检查并安装 GitHub CLI
echo "📦 步骤 1: 检查 GitHub CLI..."
if ! command -v gh &> /dev/null; then
    echo -e "${YELLOW}⚠️  GitHub CLI 未安装，正在安装...${NC}"
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &> /dev/null; then
            echo "使用 Homebrew 安装 GitHub CLI..."
            brew install gh
        else
            echo -e "${RED}请先安装 Homebrew: https://brew.sh${NC}"
            echo "或者手动安装 GitHub CLI: https://cli.github.com"
            exit 1
        fi
    else
        echo -e "${RED}请手动安装 GitHub CLI: https://cli.github.com${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✅ GitHub CLI 已安装${NC}"
fi

# 2. 检查 GitHub 认证
echo ""
echo "🔐 步骤 2: 检查 GitHub 认证..."
if ! gh auth status &> /dev/null; then
    echo -e "${YELLOW}⚠️  需要登录 GitHub...${NC}"
    echo "请按照提示完成 GitHub 登录："
    gh auth login
else
    echo -e "${GREEN}✅ GitHub 已认证${NC}"
    gh auth status
fi

# 3. 检查远程仓库
echo ""
echo "📡 步骤 3: 检查远程仓库..."
if git remote | grep -q "^origin$"; then
    REMOTE_URL=$(git remote get-url origin)
    echo -e "${GREEN}✅ 已配置远程仓库: $REMOTE_URL${NC}"
else
    echo -e "${YELLOW}⚠️  未找到远程仓库${NC}"
    echo ""
    read -p "请输入 GitHub 仓库名称 (例如: username/luckypacket-landing): " REPO_NAME
    
    if [ -z "$REPO_NAME" ]; then
        echo -e "${YELLOW}正在创建新的 GitHub 仓库...${NC}"
        REPO_NAME="luckypacket-landing-pages"
        gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
        echo -e "${GREEN}✅ 仓库已创建并推送！${NC}"
    else
        echo "添加远程仓库..."
        git remote add origin "https://github.com/$REPO_NAME.git"
    fi
fi

# 4. 确保所有更改已提交
echo ""
echo "📝 步骤 4: 检查未提交的更改..."
if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}发现未提交的更改，正在提交...${NC}"
    git add .
    git commit -m "Auto-deploy: Update project files"
fi

# 5. 推送到 GitHub
echo ""
echo "📤 步骤 5: 推送到 GitHub..."
BRANCH=$(git branch --show-current)
echo "当前分支: $BRANCH"

if git push -u origin "$BRANCH" 2>&1; then
    echo -e "${GREEN}✅ 代码已成功推送到 GitHub！${NC}"
else
    echo -e "${YELLOW}⚠️  推送失败，可能是第一次推送${NC}"
    echo "尝试强制推送主分支..."
    git branch -M main
    git push -u origin main || git push -u origin master
fi

# 6. 检查并安装 Vercel CLI
echo ""
echo "📦 步骤 6: 检查 Vercel CLI..."
if ! command -v vercel &> /dev/null; then
    echo -e "${YELLOW}⚠️  Vercel CLI 未安装，正在安装...${NC}"
    npm install -g vercel || {
        echo -e "${RED}安装失败，请手动安装: npm install -g vercel${NC}"
        echo "或者访问 https://vercel.com 使用 Web 界面部署"
        exit 1
    }
else
    echo -e "${GREEN}✅ Vercel CLI 已安装${NC}"
fi

# 7. 检查 Vercel 认证
echo ""
echo "🔐 步骤 7: 检查 Vercel 认证..."
if ! vercel whoami &> /dev/null; then
    echo -e "${YELLOW}⚠️  需要登录 Vercel...${NC}"
    echo "请按照提示完成 Vercel 登录："
    vercel login
else
    echo -e "${GREEN}✅ Vercel 已认证${NC}"
    vercel whoami
fi

# 8. 部署到 Vercel
echo ""
echo "🚀 步骤 8: 部署到 Vercel..."
echo ""

read -p "是否现在部署到 Vercel? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "开始部署..."
    vercel --prod
    
    echo ""
    echo -e "${GREEN}🎉 部署完成！${NC}"
    echo ""
    echo "您的网站应该已经可以在线访问了！"
    echo "查看部署状态: https://vercel.com/dashboard"
else
    echo ""
    echo "您可以选择稍后部署："
    echo "  1. 运行: vercel --prod"
    echo "  2. 或者访问: https://vercel.com 使用 Web 界面部署"
fi

echo ""
echo "✅ 所有步骤完成！"
echo ""
echo "📝 总结："
echo "  ✓ 代码已推送到 GitHub"
echo "  ✓ 准备部署到 Vercel"
echo ""
echo "🔗 有用的链接："
echo "  - GitHub: https://github.com/$(gh repo view --json owner -q .owner.login)/$(gh repo view --json name -q .name)"
echo "  - Vercel Dashboard: https://vercel.com/dashboard"

