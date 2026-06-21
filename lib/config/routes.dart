import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/camera_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/syllabus_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/history_screen.dart';
import '../screens/bookmarks_screen.dart';
import '../screens/achievements_screen.dart';
import '../screens/practice_screen.dart';
import '../screens/settings_screen.dart';

/// पढ़ो गुरु — Route Configuration (GoRouter)
class AppRoutes {
  AppRoutes._();

  // ─── Route Paths ──────────────────────────────────────────
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String camera = '/camera';
  static const String chat = '/chat';
  static const String chatWithId = '/chat/:questionId';
  static const String syllabus = '/syllabus';
  static const String profile = '/profile';
  static const String history = '/history';
  static const String bookmarks = '/bookmarks';
  static const String achievements = '/achievements';
  static const String practice = '/practice';
  static const String settings = '/settings';

  // ─── GoRouter ─────────────────────────────────────────────
  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: camera,
        name: 'camera',
        builder: (context, state) => const CameraScreen(),
      ),
      GoRoute(
        path: chat,
        name: 'chat',
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: chatWithId,
        name: 'chatWithId',
        builder: (context, state) {
          final questionId = state.pathParameters['questionId'] ?? '';
          return ChatScreen(questionId: questionId);
        },
      ),
      GoRoute(
        path: syllabus,
        name: 'syllabus',
        builder: (context, state) => const SyllabusScreen(),
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: history,
        name: 'history',
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: bookmarks,
        name: 'bookmarks',
        builder: (context, state) => const BookmarksScreen(),
      ),
      GoRoute(
        path: achievements,
        name: 'achievements',
        builder: (context, state) => const AchievementsScreen(),
      ),
      GoRoute(
        path: practice,
        name: 'practice',
        builder: (context, state) => const PracticeScreen(),
      ),
      GoRoute(
        path: settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
