import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'todos.g.dart';

// データベースのテーブルを定義
class Todos extends Table {
  // IntColumnでintの値
  // autoIncrement = データ追加時にidを自動で生成してくれます
  IntColumn get id => integer().autoIncrement()();
  // TextColumnでStringの値
  TextColumn get content => text()();
}

// データベースクラスの定義
@DriftDatabase(tables: [Todos])
class MyDatabase extends _$MyDatabase {
  // データベースのインスタンス生成と同時にデータベースとの接続処理を行います
  MyDatabase() : super(_openConnection());

  @override
  // データベースのバージョン指定部分
  int get schemaVersion => 1;

  // Streamでのデータ取得
  Stream<List<Todo>> watchEntries() {
    // selectでテーブルを選択
    // watchでデータクラスであるTodoのリストをStreamで返します
    return (select(todos)).watch();
  }

  // データ取得
  Future<List<Todo>> get allTodoEntries =>
      select(todos).get(); // selectでテーブルを選択 // getでデータを取得

  // データ検索
  Future<List<Todo>> searchTodo(String query) {
    return (select(todos)
          // where以下で入力した文字がcontentに含まれているデータを探します
          ..where((tbl) => tbl.content.like('%$query%')))
        .get();
  }

  // データの追加
  Future<int> addTodo(String content) {
    // intoでデータを追加するテーブルを指定
    return into(todos)
        // insertでデータクラスであるTodosCompanionを追加
        .insert(
            // TodosCompanionはデータの挿入や更新に有用なデータクラス
            // このデータクラスを使うことにより、idを指定せずにデータを追加したい時など、一部のデータだけ追加することができます
            TodosCompanion(content: Value(content)));
  }

  // データ更新
  Future<int> updateTodo(Todo todo, String content) {
    // update(todos)でテーブルを指定
    return (update(todos)
          // where以下で引数のTodo インスタンスとidが一致する物を探します
          ..where((tbl) => tbl.id.equals(todo.id)))
        // 探索で見つかった行を、write で上書き
        .write(
      TodosCompanion(
        content: Value(content),
      ),
    );
  }

  // データ削除
  Future<void> deleteTodo(Todo todo) {
    // delete(todos)でテーブルを指定
    return (delete(todos)
          // where以下で引数のTodo インスタンスとidが一致する物を探します
          ..where((tbl) => tbl.id.equals(todo.id)))
        // 探索で見つかった行を、go で削除実行する
        .go();
  }
}

// データベースの保存位置を取得し設定する
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
