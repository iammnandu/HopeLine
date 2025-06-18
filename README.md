 # HopeLine

## Abstract
HopeLine is a mobile application designed to support individuals recovering from drug addiction through an AI-powered unique mix of tools, mental health support, and engaging interactive features. The application raises awareness and promotes prevention through recovery-oriented support and engagement activities that come with a rewarding system inspired by popular subscription models such as BookMyShow, Spotify, and YouTube.

---

## Key Features

### 1. AI-Powered Mental Health Chatbot (Lifeline)
- Real-time empathetic support and counseling.
- Tailored coping and relapse prevention strategies.

### 2. Addiction Awareness Games & Quizzes
- Engaging AI-driven games and quizzes to spread awareness about addiction and mental health.
- Users can earn reward points for correct answers and active participation, redeemable for app features or perks.

### 3. Milestone Tracking & Achievement System
- Tracks user progress on their recovery journey with personalized milestones.
- Rewards users with badges, points, or exclusive content for achieving recovery goals.

### 4. Mindfulness & Meditation Tools
- Provides guided meditation and mindfulness exercises to manage stress and improve mental well-being.
- Tailored exercises based on the user's emotional state and recovery phase.

### 5. Subscription-Style Rewards System
- Points-based rewards system inspired by services like BookMyShow, Spotify, and YouTube.
- Allows users to unlock premium content, personalization, and meditation exercises through active engagement.

### 6. Community Engagement & Social Sharing
- Connects users to support groups and forums to share experiences and motivate one another.
- AI-suggested events, workshops, and initiatives tailored to user preferences and progress.

### 7. Family & Caregiver Support
- Tools for families to track their loved one's recovery and access resources and guidance.
- Collaborative dashboards for families to stay updated on progress, milestones, and challenges.

---

## Implemented Features

- **User Authentication**: Secure sign-up and login functionality.
- **User Homepage**: Displays personalized user data and quick links to core features.
- **Profile Section**: Users can manage their personal details and preferences.
- **Meditation Section**: Includes guided exercises tailored to users' recovery phases.
- **Music Player**: Allows users to play relaxing tracks for mindfulness and stress relief.
- **Reward Pages**: Tracks points and achievements, showcasing available rewards.
- **Personalized Recovery Companion**: AI-driven tools to provide custom advice and coping strategies.
- **Quiz App**: Analyzes the user’s mental state and provides feedback through interactive quizzes.
- **Community Section**: A forum for users to connect, share, and support each other.

---

## Project Structure

### Frontend
Developed using **Flutter**.

```
lib/
├── core
├── features
│   ├── authentication
│   ├── meditation
│   ├── music
│   ├── quiz
├── presentation
│   ├── authentication
│   ├── bottomNavBar
│   ├── community
│   ├── homepage
│   ├── onBoarding
│   ├── quiz
│   ├── disha
│       ├── providers
│       ├── screens
│       ├── services
│       ├── theme
```

### Backend
Developed using **Node.js**.

```
backend/
├── adapters
├── application
├── domain
├── infrastructure
├── media
├── middleware
├── models
├── routes
├── database.sqlite
├── config.js
├── index.js
├── .env
```

---

## Technologies Used

### Frontend
- **Flutter**: For building a responsive and interactive mobile application.

### Backend
- **Node.js**: For handling server-side operations.
- **SQLite**: Lightweight database for data storage.

### Other Tools
- **Figma**: For designing the app prototype.
- **AI Tools**: Integrated into features like the chatbot, quiz, and meditation.

---

## Installation and Setup

### Frontend
1. Install Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).
2. Navigate to the `hopeline/` folder.
3. Run the following commands:
   ```bash
   flutter pub get
   flutter run
   ```

### Backend
1. Navigate to the `backend/` folder.
2. Install dependencies:
   ```bash
   npm install
   ```
3. Set up environment variables in `.env`.
4. Start the server:
   ```bash
   node index.js
   ```

---

## Future Enhancements

1. **Advanced Analytics**: AI-driven insights to track user progress and suggest improvements.
2. **Live Expert Sessions**: Integration of live workshops and expert talks.
3. **Multi-language Support**: Expand the app’s reach by supporting multiple languages.
4. **Offline Mode**: Enable key features to work without an internet connection.

---

## Contributing
Contributions are welcome! Please create a pull request or raise an issue for discussions.

---
