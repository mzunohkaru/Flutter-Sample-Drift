import 'package:drift_sample/pages/search_page.dart';
import 'package:drift_sample/src/drift/todos.dart';
import 'package:drift_sample/widgets/snackbar_helper.dart';
import 'package:flutter/material.dart';

class DriftSample extends StatefulWidget {
  final MyDatabase database;

  const DriftSample({super.key, required this.database});

  @override
  State<DriftSample> createState() => _DriftSampleState();
}

class _DriftSampleState extends State<DriftSample> {
  final controllerDB = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drift Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => SearchPage(
                          database: widget.database,
                        )),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              // データベース内のデータを全件取得
              final list = await widget.database.allTodoEntries;
              if (list.isNotEmpty) {
                // 一番最後のデータを削除する
                await widget.database.deleteTodo(list[list.length - 1]);
                setState(() {
                  SnackBarHelper.show(context, '削除を完了しました');
                });
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StreamBuilder(
                  // database.watchEntriesメソッドによりデータの取得
                  stream: widget.database.watchEntries(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Todo>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      // エラーが発生したときはエラーメッセージを表示
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        // snapshot.dataにはList<Todo>の型のデータが入っている
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: Text(snapshot.data![index].id.toString()),
                          title: Text(snapshot.data![index].content),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await widget.database.updateTodo(
                                snapshot.data![index],
                                controllerDB.text,
                              );
                              setState(() {
                                SnackBarHelper.show(context, '変更を完了しました');
                                controllerDB.clear();
                              });
                            }
                          },
                          onLongPress: () async {
                            // データベース内のデータを全件取得
                            final list = await widget.database.allTodoEntries;
                            if (list.isNotEmpty) {
                              await widget.database.deleteTodo(list[index]);

                              setState(() {
                                SnackBarHelper.show(context,
                                    'データID ${snapshot.data![index].id} 削除を完了しました');
                              });
                            }
                          },
                        ),
                      );
                    } else {
                      // データがないときは空のコンテナを表示
                      return const Center(
                        child: Text('データがありません'),
                      );
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: TextFormField(
                        controller: controllerDB,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '入力されていません';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await widget.database.addTodo(controllerDB.text);
                          setState(() {
                            SnackBarHelper.show(context, 'データを追加しました');
                            controllerDB.clear();
                          });
                        }
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
