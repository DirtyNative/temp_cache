## 0.0.1

Implemented basic functionality

## 0.0.5

Implemented function 'getWhere()' which helps retrieving the correct items

## 0.0.6

Made 'getAll()' and 'getWhere()' returning a nun-nullable List<T>. If no item was found, it returns now an empty List<T>

## 0.0.7

Partially reverted the last changes, but "get()" and "getWhere()" returns now null if the cache has never been used.