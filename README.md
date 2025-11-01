# LuckyPacket - Landing Page Design

A complete landing page design system for LuckyPacket, a Web3 social Lucky Packet application built on the Base blockchain.

## 🎨 Features

- **109+ Responsive HTML Pages**: Fully responsive design with mobile-first approach
- **Modern UI/UX**: Clean and intuitive interface design
- **Consistent Design System**: Unified color scheme and component library
- **Onboarding Flow**: Complete user onboarding experience including Terms of Service
- **Multiple Page Types**: Home, Profiles, Packet Details, Settings, Notifications, and more

## 📁 Project Structure

```
├── luckypacket_home_*/          # Home page variants
├── create_red_packet_*/         # Packet creation pages
├── red_packet_detail_*/         # Packet detail pages
├── user_profile_*/              # User profile pages
├── welcome_to_luckypacket_*/    # Welcome/onboarding pages
├── accept_terms_of_service/     # Terms of Service page
├── wallet_connect_*/            # Wallet connection pages
├── notification_*/              # Notification pages
└── ...                          # Additional page types
```

## 🚀 Quick Start

### Local Development

1. Clone the repository:
```bash
git clone <your-repo-url>
cd stitch_lp_design_stitch
```

2. Serve locally:
```bash
# Using Python
python3 -m http.server 8000

# Or using Node.js http-server
npx http-server -p 8000
```

3. Open in browser:
```
http://localhost:8000
```

## 🎨 Design System

### Colors
- **Primary**: `#ea2a33` / `#f42525` / `#E53935`
- **Accent Blue**: `#007AFF`
- **Accent Green**: `#34C759`
- **Accent Orange**: `#FF9500`
- **Background Light**: `#f8f5f5` / `#F5F5F5`
- **Background Dark**: `#121212` / `#211111`

### Typography
- **Font Family**: Plus Jakarta Sans
- **Icon Font**: Material Symbols Outlined

### Responsive Breakpoints
- **Mobile**: < 640px
- **Tablet**: 640px - 1024px
- **Desktop**: > 1024px

## 📱 Key Pages

### Onboarding Flow
1. `welcome_to_luckypacket_*` - Introduction slides
2. `accept_terms_of_service` - Terms acceptance (required)
3. `get_started_with_luckypacket_*` - Get started page
4. `wallet_connect_*` - Wallet connection

### Main Features
- **Home**: `luckypacket_home_*`
- **Create Packet**: `create_red_packet_*`
- **Packet Details**: `red_packet_detail_*`
- **User Profile**: `user_profile_*`

## 🔧 Technologies

- **HTML5**: Semantic markup
- **Tailwind CSS**: Utility-first CSS framework
- **Material Symbols**: Icon library
- **Responsive Design**: Mobile-first approach

## 📝 Recent Updates

- ✅ Enhanced responsive design across all pages
- ✅ Integrated Terms of Service into onboarding flow
- ✅ Replaced "Red Packet" with "Lucky Packet" throughout
- ✅ Optimized for mobile, tablet, and desktop devices

## 🌐 Deployment

### Vercel Deployment

This project is ready for deployment on Vercel:

1. Connect your GitHub repository to Vercel
2. Vercel will automatically detect the static HTML files
3. No build configuration needed
4. Deploy and share your site!

## 📄 License

All rights reserved.

## 👥 Contributors

Designed and developed for LuckyPacket.

