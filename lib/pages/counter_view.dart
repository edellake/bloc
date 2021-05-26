import 'package:flutter/material.dart';
import 'package:bloc/models/counter_bloc.dart';

/// Экран счетчика (счетчик обновляется через поток, а не через изменение состояния)
class CounterView extends StatelessWidget {
  /// Объект логики счетчика
  final CounterBloc counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Счетчик на BLoC'),
      ),
      body: Center(
        /// Виджет отслеживания потока
        child: StreamBuilder<int>(
          /// Поток изменения счетчика
          stream: counterBloc.pressedCount,
          builder: (context, snapshot) {
            /// Виджеты, отрисовыванные с данными из потока
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  snapshot.data == 0 ? 'Нажмите кнопку!' : 'Вы нажимали кнопку столько раз:',
                ),
                if (snapshot.data != 0)
                  Text(
                    '${snapshot.data.toString()}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: () {
            /// Изменяет состояние счетчика, вызывая событие в потоке
            counterBloc.incrementCounter.add(null);
          },
          tooltip: 'Увеличить счетчик',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
