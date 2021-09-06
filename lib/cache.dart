import 'dart:async';
import 'package:collection/collection.dart';

import 'package:temp_cache/cache_item.dart';

class Cache<T> {
  /// The time how long the objects are stored
  late Duration _duration;

  /// The cache itself
  final List<CacheItem<T>> _cache = [];

  /// The timer which handles the loop
  Timer? _timer;

  Cache({Duration? duration}) {
    _duration = duration ?? Duration(minutes: 60);
  }

  /// Gets a cached item with the given key
  T? get(String key) {
    final CacheItem<T>? cacheItem =
        _cache.firstWhereOrNull((element) => element.key == key);

    // If there is no item cached
    if (cacheItem == null) {
      return null;
    }

    // If the items cache duration is over
    if (_isItemOutdated(cacheItem)) {
      remove(key);
      return null;
    }

    return cacheItem.item;
  }

  /// Gets all cached items
  List<T>? getAll() {
    List<T>? list;

    for (int index = _cache.length - 1; index >= 0; index--) {
      var item = _cache[index];

      if (_isItemOutdated(item)) {
        removeItem(item);
      } else {
        list ??= [];
        list.add(item.item);
      }
    }

    return list;
  }

  /// Inserts an item with the given key into the cache
  void put(String key, T item) {
    putWithDuration(key, item, _duration);
  }

  /// Inserts an item with the given key and duration into the cache
  void putWithDuration(String key, T item, Duration duration) {
    var endTime = _nowInSeconds() + duration.inSeconds;

    final CacheItem<T> cacheItem = CacheItem<T>(key, item, endTime);
    _cache.add(cacheItem);

    // Try to start the timer if not done yet
    _tryStartTimer();
  }

  /// Inserts many items into the cache
  void putMany(List<T> items, String Function(T item) getKey) {
    putManyWithDuration(items, getKey, _duration);
  }

  /// Inserts many items into the cache with the given duration
  void putManyWithDuration(
      List<T> items, String Function(T item) getKey, Duration duration) {
    var endTime = _nowInSeconds() + duration.inSeconds;

    items.forEach((item) {
      var key = getKey(item);
      final CacheItem<T> cacheItem = CacheItem<T>(key, item, endTime);
      _cache.add(cacheItem);
    });

    // Try to start the timer if not done yet
    _tryStartTimer();
  }

  /// Removes the item with the given key from the cache
  void remove(String key) {
    _cache.removeWhere((element) => element.key == key);
  }

  /// Removes the given item from the cache
  void removeItem(CacheItem item) {
    _cache.remove(item);
  }

  /// Removes all items from the cache
  void removeAll() {
    _cache.clear();
  }

  /// Sets a new default duration
  set duration(Duration dur) {
    _duration = dur;
  }

  /// Checks if the item is outdated
  bool _isItemOutdated(CacheItem<T> item) => item.endTime <= _nowInSeconds();

  void _tryStartTimer() {
    if (_cache.isEmpty || (_timer != null && _timer!.isActive)) {
      return;
    }

    _timer = Timer.periodic(Duration(seconds: 10), _timerCallBack);
  }

  void _timerCallBack(Timer timer) {
    if (_cache.isEmpty) {
      _timer?.cancel();
      return;
    }
  }

  int _nowInSeconds() {
    return (DateTime.now().millisecondsSinceEpoch / 1000).round();
  }
}
