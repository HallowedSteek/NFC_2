import 'dart:async';

import 'package:nfc_2/nfcmanager/repository/repository_impl.dart';
import 'package:nfc_2/nfcmanager/repository/repository_impl_demo.dart';

import '../model/write_record.dart';
import 'database.dart';



abstract class Repository {
  static Future<Repository> createInstance({bool isDemo = false}) async => isDemo
    ? RepositoryImplDemo()
    : RepositoryImpl(await getOrCreateDatabase());

  Stream<Iterable<WriteRecord>> subscribeWriteRecordList();

  Future<WriteRecord> createOrUpdateWriteRecord(WriteRecord record);

  Future<void> deleteWriteRecord(WriteRecord record);
}

class SubscriptionManager {
  final Map<int, StreamController> _controllers = {};
  final Map<int, StreamController> _subscribers = {};

  Stream<T> createStream<T>(Future<T> Function() fetcher) {
    final key = DateTime.now().microsecondsSinceEpoch;
    final controller = StreamController<T>(onCancel: () {
      _controllers.remove(key)?.close();
      _subscribers.remove(key)?.close();
    });
    void publisher(Future<T> future) => future
      .then(controller.add)
      .catchError(controller.addError);
    _subscribers[key] = StreamController(onListen: () => publisher(fetcher()))
      ..stream.listen((_) => publisher(fetcher()));
    _controllers[key] = controller;
    return controller.stream;
  }

  void publish() =>
    _subscribers.values.forEach((e) => e.add(null));
}
