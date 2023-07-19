import 'dart:collection';

class CacheObject {
  final dynamic data;
  final DateTime fetchTime;

  CacheObject(this.data) : fetchTime = DateTime.now();
}

class MemoryCache {
  static const MAX_CACHE_AGE = Duration(minutes: 5);

  final _cacheData = HashMap<String, CacheObject>();

  Future<dynamic> get(String key, Future<dynamic> Function() fetch) async {
    final existing = _cacheData[key];
    // Check if data exists in cache and is not too old.
    if (existing != null &&
        DateTime.now().difference(existing.fetchTime) < MAX_CACHE_AGE) {
      return existing.data;
    } else {
      // Fetch data and store in cache.
      final data = await fetch();
      _cacheData[key] = CacheObject(data);
      return data;
    }
  }
}
