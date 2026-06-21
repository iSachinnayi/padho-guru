import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// पढ़ो गुरु — Local Storage Service
/// Uses SharedPreferences for offline chapter data + user prefs.
class StorageService {
  static const String _downloadedChapters = 'downloaded_chapters';

  // ─── Download Chapter (mark as offline) ──────────────────
  Future<void> downloadChapter(String chapterId) async {
    final prefs = await SharedPreferences.getInstance();
    final downloaded = await getDownloadedChapters();
    if (!downloaded.contains(chapterId)) {
      downloaded.add(chapterId);
      await prefs.setString(_downloadedChapters, jsonEncode(downloaded));
    }
  }

  // ─── Remove Chapter (remove from offline) ────────────────
  Future<void> removeChapter(String chapterId) async {
    final prefs = await SharedPreferences.getInstance();
    final downloaded = await getDownloadedChapters();
    downloaded.remove(chapterId);
    await prefs.setString(_downloadedChapters, jsonEncode(downloaded));
  }

  // ─── Get Downloaded Chapter IDs ──────────────────────────
  Future<List<String>> getDownloadedChapters() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_downloadedChapters);
    if (data == null) return [];
    return (jsonDecode(data) as List).cast<String>();
  }

  // ─── Check if Chapter is Downloaded ──────────────────────
  Future<bool> isChapterDownloaded(String chapterId) async {
    final downloaded = await getDownloadedChapters();
    return downloaded.contains(chapterId);
  }

  // ─── Toggle Download ─────────────────────────────────────
  Future<bool> toggleDownload(String chapterId) async {
    final downloaded = await getDownloadedChapters();
    if (downloaded.contains(chapterId)) {
      await removeChapter(chapterId);
      return false;
    } else {
      await downloadChapter(chapterId);
      return true;
    }
  }

  // ─── User Preferences ────────────────────────────────────
  Future<void> setUserPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getUserPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // ─── Clear All Local Data ────────────────────────────────
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
