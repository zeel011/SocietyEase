# SocietyEase - Residential Society Management App

A cross-platform mobile application built with Flutter for managing residential society operations, including maintenance bills, notices, and announcements.

## 🎯 Features

### 🏠 Home Dashboard
- Personalized greeting with user name
- Overview cards showing:
  - Total unpaid maintenance bills
  - Latest notices with posting dates
  - Complaint status summary
- Modern card-based UI with icons and clean design
- Loading shimmer effects for better UX

### 💰 Maintenance Bill Management
- Complete list of maintenance bills with details
- Bill information includes:
  - Title and amount
  - Month and due date
  - Payment status (Paid/Unpaid/Overdue)
- Status tags with color coding
- Payment options (UPI integration ready)
- Receipt download functionality
- Filter bills by status (All/Paid/Unpaid)

### 📢 Notice Board & Announcements
- Display notice cards with title, date, and content
- Expandable notice content (tap to expand/collapse)
- Important notice indicators
- Search functionality
- Filter by notice type (All/Important/Regular)
- Admin placeholder for adding new notices

## 🛠️ Technical Features

- **Cross-platform**: Works on iOS and Android
- **Material Design 3**: Modern UI with Material 3 components
- **Theme Support**: Light and dark theme support
- **Responsive Design**: Adapts to different screen sizes
- **Loading States**: Shimmer loading effects
- **Navigation**: Bottom navigation bar for easy switching
- **State Management**: Provider pattern ready

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── bill.dart            # Bill data model
│   └── notice.dart          # Notice data model
├── screens/
│   ├── home_screen.dart     # Dashboard screen
│   ├── maintenance_screen.dart  # Bills management
│   └── notice_board_screen.dart # Notices screen
├── widgets/
│   ├── overview_card.dart   # Dashboard overview cards
│   ├── bill_card.dart       # Individual bill display
│   ├── notice_card.dart     # Individual notice display
│   └── notice_preview_card.dart # Notice preview for dashboard
└── data/
    └── mock_data.dart       # Sample data provider

assets/
├── data/
│   ├── bills.json          # Sample bill data
│   └── notices.json        # Sample notice data
└── images/                 # App images (placeholder)
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android SDK (for Android development)
- Xcode (for iOS development, macOS only)

### Installation

1. **Clone the repository**
   ```bash
   git clone
   cd SocietyEase
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Dependencies

The app uses the following key dependencies:

- `flutter`: Core Flutter framework
- `provider`: State management
- `intl`: Internationalization and date formatting
- `shimmer`: Loading shimmer effects
- `http`: HTTP requests (for future API integration)
- `shared_preferences`: Local data storage
- `flutter_pdfview`: PDF viewing (for receipts)
- `path_provider`: File system access

## 📱 Screenshots

### Home Dashboard
- Personalized greeting
- Overview cards with statistics
- Latest notices preview
- Modern gradient design

### Maintenance Bills
- Bill list with status indicators
- Payment options (UPI ready)
- Receipt download functionality
- Filter and search capabilities

### Notice Board
- Expandable notice cards
- Important notice indicators
- Search and filter options
- Admin features placeholder

## 🎨 Design Features

- **Material Design 3**: Latest Material Design guidelines
- **Color Scheme**: Dynamic color theming
- **Typography**: Consistent text hierarchy
- **Spacing**: Proper padding and margins
- **Icons**: Material Design icons
- **Animations**: Smooth transitions and loading states

## 🔧 Configuration

### Theme Configuration
The app uses Material 3 theming with:
- Primary color: Blue (#2196F3)
- Light and dark theme support
- Dynamic color adaptation

### Mock Data
Sample data is provided in:
- `assets/data/bills.json` - Sample bill data
- `assets/data/notices.json` - Sample notice data
- `lib/data/mock_data.dart` - Data provider

## 🚧 Future Enhancements

### Planned Features
- [ ] User authentication and authorization
- [ ] Real-time notifications
- [ ] Online payment integration
- [ ] Complaint management system
- [ ] Visitor management
- [ ] Parking management
- [ ] Event calendar
- [ ] Document sharing
- [ ] Push notifications
- [ ] Offline support

### Technical Improvements
- [ ] API integration
- [ ] Database implementation
- [ ] State management with Provider/Riverpod
- [ ] Unit and widget tests
- [ ] CI/CD pipeline
- [ ] App store deployment

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---


**SocietyEase** - Making society management easier, one app at a time! 🏠✨ 
