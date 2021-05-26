import 'dart:async';
import 'package:rxdart/rxdart.dart';

/// Виджет
class CounterBloc {
  /// Приватная переменная счетчика
  int _counter = 0;

  CounterBloc() {
    /// Запуск прослушивания потока
    _actionController.stream.listen(_increaseStream);
  }

  /// Контроллер, расширяющий возможности StreamController'а.
  /// Захватывает последний элемент, полученный контроллером и отдает его слушателям как первый элемент.
  /// Указываем начальное значение для слушателей.
  final _counterStream = BehaviorSubject<int>.seeded(0);

  /// Поток, видимый всем
  Stream get pressedCount => _counterStream.stream;
  /// Хранилище данных потока
  Sink get _addValue => _counterStream.sink;

  /// Контроллер потока
  StreamController _actionController = StreamController();
  /// Объект, принимающий события потока
  StreamSink get incrementCounter => _actionController.sink;

  /// Метод, вызываямый при регистрации события
  void _increaseStream(data) {
    /// Изменение приватной переменной счетчика
    _counter += 1;
    /// Сохранение нового значение в хранилище данных
    _addValue.add(_counter);
  }

  void dispose() {
    /// Закрытие потока и контроллера при уничтожении виджета
    _counterStream.close();
    _actionController.close();
  }
}
