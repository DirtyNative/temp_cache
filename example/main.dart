import 'package:temp_cache/cache.dart';

void main(List<String> args) {
  final cache = Cache<TestItem>();
  final item1 = TestItem('1');
  final item2 = TestItem('2');
  final item3 = TestItem('3');

  // put one
  cache.put(item1.id, item1);

  // put many
  final List<TestItem> items = [item2, item3];
  cache.putMany(items, (item) => item.id);

  // get one
  // ignore: unused_local_variable
  final i1 = cache.get('1');

  // get all
  // ignore: unused_local_variable
  final retrievedList = cache.getAll();
}

class TestItem {
  late final String id;
  late final bool isTrue;

  TestItem(this.id);
}
