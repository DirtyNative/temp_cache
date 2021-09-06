import 'package:flutter_test/flutter_test.dart';
import 'package:temp_cache/temp_cache.dart';

void main() {
  test('Cache single', () {
    var cache = Cache<TestItem>();

    final item1 = TestItem('1', true);
    final item2 = TestItem('2', true);
    final item3 = TestItem('3', false);

    cache.put(item1.id, item1);
    cache.put(item2.id, item2);
    cache.put(item3.id, item3);

    expect(cache.get('1'), item1);
    expect(cache.get('2'), item2);
    expect(cache.get('3'), item3);
  });

  test('Cache multiple', () {
    var cache = Cache<TestItem>();

    final item1 = TestItem('1', true);
    final item2 = TestItem('2', true);
    final item3 = TestItem('3', false);

    final List<TestItem> items = [item1, item2, item3];

    cache.putMany(items, (item) => item.id);

    expect(cache.get('1'), item1);
    expect(cache.get('2'), item2);
    expect(cache.get('3'), item3);
  });

  test('Get all', () {
    var cache = Cache<TestItem>();

    final item1 = TestItem('1', true);
    final item2 = TestItem('2', true);
    final item3 = TestItem('3', false);

    final List<TestItem> items = [item1, item2, item3];

    cache.putMany(items, (item) => item.id);

    expect(cache.getAll(), [item3, item2, item1]);
  });

  test('Remove item', () {
    var cache = Cache<TestItem>();

    final item1 = TestItem('1', true);
    final item2 = TestItem('2', true);
    final item3 = TestItem('3', false);

    final List<TestItem> items = [item1, item2, item3];

    cache.putMany(items, (item) => item.id);

    cache.remove('1');

    expect(cache.get('1'), null);
  });
}

class TestItem {
  late final String id;
  late final bool isTrue;

  TestItem(this.id, this.isTrue);
}
