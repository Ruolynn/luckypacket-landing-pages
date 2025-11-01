# 部署指南 - GitHub & Vercel

本指南将帮助您将 LuckyPacket 项目同步到 GitHub 并部署到 Vercel。

## 📋 准备工作

### 1. 确保 Git 已配置

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## 🚀 步骤 1: 推送到 GitHub

### 方法 A: 在 GitHub 上创建新仓库（推荐）

1. **在 GitHub 上创建新仓库**
   - 访问 https://github.com/new
   - 仓库名称：`luckypacket-landing-pages` (或您喜欢的名称)
   - 选择 **Public** 或 **Private**
   - **不要**初始化 README、.gitignore 或 license（我们已经有了）
   - 点击 "Create repository"

2. **连接本地仓库到 GitHub**
   ```bash
   cd /Users/ruolynnchen/Downloads/stitch_lp_design_stitch
   
   # 添加远程仓库（替换 YOUR_USERNAME 和 REPO_NAME）
   git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git
   
   # 推送代码
   git branch -M main
   git push -u origin main
   ```

### 方法 B: 使用 GitHub CLI（如果已安装）

```bash
# 在项目目录中
cd /Users/ruolynnchen/Downloads/stitch_lp_design_stitch

# 创建 GitHub 仓库并推送
gh repo create luckypacket-landing-pages --public --source=. --remote=origin --push
```

### 方法 C: 手动创建并推送

如果您已经有 GitHub 仓库 URL，使用：

```bash
cd /Users/ruolynnchen/Downloads/stitch_lp_design_stitch

# 添加远程仓库
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git

# 重命名分支为 main（如果需要）
git branch -M main

# 推送代码
git push -u origin main
```

## 🌐 步骤 2: 部署到 Vercel

### 方法 A: 通过 Vercel Dashboard（最简单）

1. **登录 Vercel**
   - 访问 https://vercel.com
   - 使用 GitHub 账号登录（推荐）

2. **导入项目**
   - 点击 "Add New..." → "Project"
   - 选择您的 GitHub 仓库（`luckypacket-landing-pages`）
   - 点击 "Import"

3. **配置项目**
   - **Framework Preset**: 选择 "Other" 或 "HTML"
   - **Root Directory**: `./` (默认)
   - **Build Command**: 留空（静态 HTML，无需构建）
   - **Output Directory**: `./` (默认)
   - **Install Command**: 留空

4. **部署设置**
   - Vercel 会自动检测 `vercel.json` 配置文件
   - 点击 "Deploy"

5. **完成**
   - 等待部署完成（通常 1-2 分钟）
   - Vercel 会提供一个 URL，例如：`https://your-project.vercel.app`

### 方法 B: 使用 Vercel CLI

```bash
# 安装 Vercel CLI（如果未安装）
npm i -g vercel

# 在项目目录中
cd /Users/ruolynnchen/Downloads/stitch_lp_design_stitch

# 登录 Vercel
vercel login

# 部署项目
vercel

# 部署到生产环境
vercel --prod
```

### Vercel 配置说明

项目已包含 `vercel.json` 配置文件：

```json
{
  "version": 2,
  "builds": [
    {
      "src": "**/*.html",
      "use": "@vercel/static"
    }
  ]
}
```

这个配置告诉 Vercel：
- 将所有 HTML 文件作为静态文件提供
- 无需构建步骤
- 直接部署所有 HTML 页面

## 📝 验证部署

### 测试本地 Git 状态

```bash
cd /Users/ruolynnchen/Downloads/stitch_lp_design_stitch
git status
git log --oneline
```

### 检查远程仓库连接

```bash
git remote -v
```

### 访问部署的网站

部署完成后，访问 Vercel 提供的 URL，例如：
- `https://your-project.vercel.app`
- `https://your-project.vercel.app/luckypacket_home_1/code.html`
- `https://your-project.vercel.app/test_responsive.html`

## 🔄 更新部署

当您修改代码后：

```bash
# 1. 提交更改
git add .
git commit -m "描述您的更改"

# 2. 推送到 GitHub
git push origin main

# 3. Vercel 会自动检测并重新部署
# （如果使用 Vercel Dashboard 方式）
```

如果使用 Vercel CLI：

```bash
vercel --prod
```

## 🎯 自定义域名（可选）

在 Vercel Dashboard 中：
1. 进入项目设置
2. 选择 "Domains"
3. 添加您的自定义域名
4. 按照提示配置 DNS

## 📊 项目结构说明

```
stitch_lp_design_stitch/
├── .gitignore          # Git 忽略文件（排除图片）
├── README.md           # 项目说明
├── vercel.json         # Vercel 配置
├── DEPLOYMENT.md       # 本部署指南
├── *.html              # 各种页面文件
└── [各种目录]/         # 页面目录
```

## ❓ 常见问题

### Q: 图片文件在哪里？
A: 图片文件（.png）已被 `.gitignore` 排除，因为它们很大。代码使用外部图片 URL，所以不影响功能。

### Q: 如何添加自定义域名？
A: 在 Vercel Dashboard → Settings → Domains 中添加。

### Q: 如何回滚到之前的版本？
A: 在 Vercel Dashboard → Deployments 中选择之前的部署，点击 "..." → "Promote to Production"。

### Q: 部署失败怎么办？
A: 检查 Vercel Dashboard 中的构建日志，通常是路径或配置问题。

## 🎉 完成！

完成以上步骤后，您的网站将：
- ✅ 托管在 GitHub
- ✅ 部署在 Vercel
- ✅ 拥有可访问的 URL
- ✅ 支持自动部署（推送代码时自动更新）

如有问题，请检查：
- GitHub 仓库是否正确设置
- Vercel 项目是否正确连接
- `vercel.json` 配置文件是否正确

