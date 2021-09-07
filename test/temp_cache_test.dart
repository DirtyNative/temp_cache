import 'package:flutter_test/flutter_test.dart';
import 'package:temp_cache/temp_cache.dart';

void main() {
  test('Cache single', () {
    final cache = Cache<TestItem>();

    final item1 = TestItem('1');
    final item2 = TestItem('2');
    final item3 = TestItem('3');

    cache.put(item1.id, item1);
    cache.put(item2.id, item2);
    cache.put(item3.id, item3);

    expect(cache.get('1'), item1);
    expect(cache.get('2'), item2);
    expect(cache.get('3'), item3);
  });

  test('Cache multiple', () {
    final cache = Cache<TestItem>();

    final item1 = TestItem('1');
    final item2 = TestItem('2');
    final item3 = TestItem('3');

    final List<TestItem> items = [item1, item2, item3];

    cache.putMany(items, (item) => item.id);

    expect(cache.get('1'), item1);
    expect(cache.get('2'), item2);
    expect(cache.get('3'), item3);
  });

  test('Get all', () {
    final cache = Cache<TestItem>();

    final item1 = TestItem('1');
    final item2 = TestItem('2');
    final item3 = TestItem('3');

    final List<TestItem> items = [item1, item2, item3];

    cache.putMany(items, (item) => item.id);

    expect(cache.getAll(), [item3, item2, item1]);
  });

  test('Get where', () {
    final cache = Cache<TestItem2>();

    final item1 = TestItem2('1', 10);
    final item2 = TestItem2('2', 20);
    final item3 = TestItem2('3', 30);

    final List<TestItem2> items = [item1, item2, item3];

    cache.putMany(items, (item) => item.id);

    final retrievedItems = cache.getWhere((item) => item.item.number > 15);

    expect(retrievedItems, [item2, item3]);
  });

  test('Remove item', () {
    final cache = Cache<TestItem>();

    final item1 = TestItem('1');
    final item2 = TestItem('2');
    final item3 = TestItem('3');

    final List<TestItem> items = [item1, item2, item3];

    cache.putMany(items, (item) => item.id);

    cache.remove('1');

    expect(cache.get('1'), null);
  });
}

class TestItem {
  late final String id;

  TestItem(this.id);
}

class TestItem2 {
  late final String id;
  late final int number;

  TestItem2(this.id, this.number);
}
