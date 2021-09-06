class CacheItem<T> {
  /// The key which can be referenced to get the item
  final String _key;

  /// The object to cache
  final T _item;

  /// The time when this item will be invalidated in seconds
  final int _endTime;

  CacheItem(this._key, this._item, this._endTime);

  String get key => _key;
  T get item => _item;
  int get endTime => _endTime;
}
