# temp_cache

A package which provides functionality to store objects inside a temporary cache within memory

## Getting Started

Import the package within your **pubspec.yaml**

```yaml
temp_cache:
```

Then you can use the classes via importing the lib:

``` dart
import 'package:temp_cache/temp_cache.dart';
```

Store objects:

``` dart
var cache = Cache<TestItem>();
final item1 = TestItem('1');
final item2 = TestItem('2');
final item3 = TestItem('3');

cache.put(item1.id, item1);
cache.put(item2.id, item2);
cache.put(item3.id, item3);

// or

final List<TestItem> items = [item1, item2, item3];
cache.putMany(items, (item) => item.id);
```

Get objects:

``` dart
cache.get('1')

// or

cache.getAll()
```

## Buy me a Coffee if you like this package

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/donate?hosted_button_id=Q4QALYJXEDH5Q)
