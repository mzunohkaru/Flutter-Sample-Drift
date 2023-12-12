import 'package:drift_sample/src/drift/todos.dart';
import 'package:drift_sample/widgets/snackbar_helper.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final MyDatabase database;

  const SearchPage({super.key, required this.database});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controllerDB = TextEditingController();
  final controllerSearch = TextEditingController();
  List<Todo> searchResults = [];

  Future searchData() async {
    searchResults = await widget.database.searchTodo(controllerSearch.text);
  }

  Future loadData() async {
    searchResults = await widget.database.searchTodo(controllerSearch.text);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controllerSearch,
          decoration: const InputDecoration(
            hintText: 'Search...',
          ),
          onChanged: (_) {
            searchData();
            setState(() {});
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(searchResults[index].id.toString()),
                  title: Text(searchResults[index].content),
                  onTap: () async {
                    await widget.database.updateTodo(
                      searchResults[index],
                      controllerDB.text,
                    );
                    setState(() {
                      SnackBarHelper.show(context, '変更を完了しました');
                      controllerDB.clear();
                      searchData();
                    });
                  },
                  onLongPress: () async {
                    // データベース内のデータを全件取得
                    final list = await widget.database.allTodoEntries;
                    if (list.isNotEmpty) {
                      await widget.database.deleteTodo(list[index]);

                      setState(() {
                        SnackBarHelper.show(context,
                            'データID ${searchResults[index].id} 削除を完了しました');
                        searchData();
                      });
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: controllerDB,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
