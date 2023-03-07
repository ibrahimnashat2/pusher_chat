import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../print.dart';

typedef QueryParam<T> = QueryBuilder<T, T, QWhere>;
typedef QueryReturnType<T> = QueryBuilder<T, T, QAfterFilterCondition>;
typedef QueryType<T> = QueryReturnType<T> Function(QueryParam<T> isa);

abstract class Isaar {
  Future<Isar> openObject({
    required List<CollectionSchema> schemas,
    required String name,
  });

  Future<bool> closeObject();

  IsarCollection<T> getCollection<T>();

  QueryBuilder<T, T, QWhere> getWhereQuery<T>();

  Future<List<int>> writeOrUpdateAll<T>({required List<T> objects});

  Future<int> writeOrUpdate<T>({required T object});

  Future<bool> deleteById<T>({required dynamic id});

  Future<T?> getById<T>({required dynamic id});

  Future<int> deleteAll<T>();

  Future<int> deleteAllWithQuery<T>({required QueryType<T> query});

  Future<bool> deleteOneWithQuery<T>({required QueryType<T> query});

  Future<List<T>> getAll<T>();

  Future<List<T>> getAllWithQuery<T>({required QueryType<T> query});

  Future<T?> getOneWithQuery<T>({required QueryType<T> query});
  Future<void> clear();
}

@LazySingleton(as: Isaar)
class IsaarImpl implements Isaar {
  late Isar _isar;

  @override
  Future<Isar> openObject({
    required List<CollectionSchema> schemas,
    required String name,
  }) async {
    var dbPath = (await getApplicationDocumentsDirectory()).path;

    // if(!_isar.isOpen){
    _isar = await Isar.open(
      schemas,
      name: name,
      relaxedDurability: false,
      directory: dbPath,
    );
    kPrint('isar name : ${_isar.name}');
    // }
    return _isar;
  }

  @override
  Future<T?> getById<T>({required dynamic id}) async {
    return await _isar.writeTxn<T?>(() async {
      return await _isar.collection<T>().get(id);
    });
  }

  @override
  Future<bool> deleteById<T>({required dynamic id}) async {
    return await _isar.writeTxn<bool>(() async {
      return await _isar.collection<T>().delete(id);
    });
  }

  @override
  QueryBuilder<T, T, QWhere> getWhereQuery<T>() {
    return _isar.collection<T>().where();
  }

  @override
  IsarCollection<T> getCollection<T>() {
    return _isar.collection<T>();
  }

  @override
  Future<int> writeOrUpdate<T>({required T object}) async {
    return await _isar.writeTxn<int>(() async {
      return await _isar.collection<T>().put(object);
    });
  }

  @override
  Future<List<int>> writeOrUpdateAll<T>({required List<T> objects}) async {
    return await _isar.writeTxn<List<int>>(() async {
      final collection = _isar.collection<T>();
      List<int> ints = await collection.putAll(objects);
      kPrint('ints length : ${ints.length}');
      return ints;
    });
  }

  @override
  Future<int> deleteAll<T>() async {
    return await _isar.writeTxn<int>(() async {
      return await _isar.collection<T>().where().deleteAll();
    });
  }

  @override
  Future<int> deleteAllWithQuery<T>({required QueryType<T> query}) async {
    return await _isar.writeTxn<int>(() async {
      return await query(_isar.collection<T>().where()).deleteAll();
    });
  }

  @override
  Future<bool> deleteOneWithQuery<T>({required QueryType<T> query}) async {
    return await _isar.writeTxn<bool>(() async {
      return await query(_isar.collection<T>().where()).deleteFirst();
    });
  }

  @override
  Future<List<T>> getAll<T>() async {
    return await _isar.writeTxn<List<T>>(() async {
      var data = await _isar.collection<T>().where().findAll();
      kPrint('data length : ${data.length}');
      return data;
    });
  }

  @override
  Future<List<T>> getAllWithQuery<T>({required QueryType<T> query}) async {
    return await _isar.writeTxn<List<T>>(() async {
      List<T> allObjects = await query(_isar.collection<T>().where()).findAll();
      kPrint('allObjects length : ${allObjects.length}');
      return allObjects;
    });
  }

  @override
  Future<T?> getOneWithQuery<T>({required QueryType<T> query}) async {
    return await _isar.writeTxn<T?>(() async {
      return await query(_isar.collection<T>().where()).findFirst();
    });
  }

  @override
  Future<bool> closeObject() async {
    return await _isar.close();
  }

  @override
  Future<void> clear() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }
}
