import 'package:drift_sample/src/drift/todos.dart';
import 'package:flutter/material.dart';

void main() {
  final database = MyDatabase();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final MyDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // データベースインスタンスを親から子に受け渡します
      home: DriftSample(database: database),
    );
  }
}

class DriftSample extends StatelessWidget {
  final MyDatabase database;

  const DriftSample({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StreamBuilder(
                // database.watchEntriesメソッドによりデータの取得
                stream: database.watchEntries(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    // snapshot.dataにはList<Todo>の型のデータが入っている
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Text(snapshot.data![index].id.toString()),
                      title: Text(snapshot.data![index].content),
                      onTap: () async {
                        await database.updateTodo(
                          snapshot.data![index],
                          'updated',
                        );
                      },
                      onLongPress: () async {
                        // データベース内のデータを全件取得
                        final list = await database.allTodoEntries;
                        if (list.isNotEmpty) {
                          // 一番最後のデータを削除する
                          await database.deleteTodo(list[index]);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: const Text('追加'),
                      onPressed: () async {
                        await database.addTodo(
                          'test test',
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: const Text('remove'),
                      onPressed: () async {
                        // データベース内のデータを全件取得
                        final list = await database.allTodoEntries;
                        if (list.isNotEmpty) {
                          // 一番最後のデータを削除する
                          await database.deleteTodo(list[list.length - 1]);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
