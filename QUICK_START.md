# 🚀 快速部署指南（5分钟完成）

由于自动化部署需要交互式认证，这里提供最简单的手动步骤：

## 方法一：使用 GitHub Web 界面（最简单）

### 1. 创建 GitHub 仓库

1. 访问 https://github.com/new
2. 仓库名称：`luckypacket-landing-pages`
3. **不要**勾选任何初始化选项（README、.gitignore、license）
4. 点击 "Create repository"

### 2. 推送代码（复制粘贴以下命令）

```bash
cd /Users/ruolynnchen/Downloads/stitch_lp_design_stitch

# 添加远程仓库（替换 YOUR_USERNAME 为您的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/luckypacket-landing-pages.git

# 推送代码
git branch -M main
git push -u origin main
```

如果提示输入密码，使用 **Personal Access Token**（见下方说明）

### 3. 部署到 Vercel

1. 访问 https://vercel.com
2. 点击 "Sign Up" 或 "Log In"
3. 选择 "Continue with GitHub"
4. 点击 "Add New..." → "Project"
5. 选择您的仓库 `luckypacket-landing-pages`
6. 点击 "Import"
7. **配置**：
   - Framework Preset: 选择 "Other"
   - Build Command: **留空**
   - Output Directory: **留空** 或输入 `.`
8. 点击 "Deploy"

✅ 完成！您的网站将在 1-2 分钟内上线！

---

## 方法二：使用 GitHub Token（如果方法一失败）

### 1. 创建 GitHub Personal Access Token

1. 访问 https://github.com/settings/tokens
2. 点击 "Generate new token" → "Generate new token (classic)"
3. 名称：`LuckyPacket Deploy`
4. 权限：勾选 `repo` (完整仓库权限)
5. 点击 "Generate token"
6. **立即复制 token**（只显示一次！）

### 2. 使用 Token 推送

```bash
cd /Users/ruolynnchen/Downloads/stitch_lp_design_stitch

# 设置远程仓库（替换 YOUR_USERNAME）
git remote add origin https://github.com/YOUR_USERNAME/luckypacket-landing-pages.git

# 推送时使用 token 作为密码
git push -u origin main
# 用户名：您的 GitHub 用户名
# 密码：粘贴刚才复制的 token
```

### 3. 部署到 Vercel（同方法一第3步）

---

## 方法三：使用命令行（需要安装工具）

如果您想完全自动化：

```bash
# 1. 登录 GitHub CLI
gh auth login

# 2. 创建仓库并推送
cd /Users/ruolynnchen/Downloads/stitch_lp_design_stitch
gh repo create luckypacket-landing-pages --public --source=. --remote=origin --push

# 3. 部署到 Vercel（使用 npx，无需安装）
npx vercel --prod
```

---

## ✅ 验证部署

部署完成后，访问：
- Vercel 会自动提供一个 URL，例如：`https://luckypacket-landing-pages.vercel.app`
- 或者您可以在 Vercel Dashboard 查看

测试页面：
- 主页：`https://your-url.vercel.app/luckypacket_home_1/code.html`
- 测试页：`https://your-url.vercel.app/test_responsive.html`

---

## 💡 提示

- 如果遇到问题，Vercel Dashboard 的日志会显示详细错误信息
- 所有 HTML 文件都是静态的，不需要构建过程
- 图片使用外部 URL，无需担心图片文件大小

---

## 🎉 完成后的工作流

每次更新代码后：

```bash
git add .
git commit -m "描述您的更改"
git push origin main
```

Vercel 会自动检测 GitHub 更新并重新部署！

