// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos.dart';

// ignore_for_file: type=lint
class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _limitDateMeta =
      const VerificationMeta('limitDate');
  @override
  late final GeneratedColumn<DateTime> limitDate = GeneratedColumn<DateTime>(
      'limit_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isNotifyMeta =
      const VerificationMeta('isNotify');
  @override
  late final GeneratedColumn<bool> isNotify = GeneratedColumn<bool>(
      'is_notify', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_notify" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [id, content, limitDate, isNotify];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('limit_date')) {
      context.handle(_limitDateMeta,
          limitDate.isAcceptableOrUnknown(data['limit_date']!, _limitDateMeta));
    } else if (isInserting) {
      context.missing(_limitDateMeta);
    }
    if (data.containsKey('is_notify')) {
      context.handle(_isNotifyMeta,
          isNotify.isAcceptableOrUnknown(data['is_notify']!, _isNotifyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Todo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      limitDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}limit_date'])!,
      isNotify: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_notify'])!,
    );
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(attachedDatabase, alias);
  }
}

class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String content;
  final DateTime limitDate;
  final bool isNotify;
  const Todo(
      {required this.id,
      required this.content,
      required this.limitDate,
      required this.isNotify});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['limit_date'] = Variable<DateTime>(limitDate);
    map['is_notify'] = Variable<bool>(isNotify);
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: Value(id),
      content: Value(content),
      limitDate: Value(limitDate),
      isNotify: Value(isNotify),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      limitDate: serializer.fromJson<DateTime>(json['limitDate']),
      isNotify: serializer.fromJson<bool>(json['isNotify']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'limitDate': serializer.toJson<DateTime>(limitDate),
      'isNotify': serializer.toJson<bool>(isNotify),
    };
  }

  Todo copyWith(
          {int? id, String? content, DateTime? limitDate, bool? isNotify}) =>
      Todo(
        id: id ?? this.id,
        content: content ?? this.content,
        limitDate: limitDate ?? this.limitDate,
        isNotify: isNotify ?? this.isNotify,
      );
  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('limitDate: $limitDate, ')
          ..write('isNotify: $isNotify')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, limitDate, isNotify);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.content == this.content &&
          other.limitDate == this.limitDate &&
          other.isNotify == this.isNotify);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> content;
  final Value<DateTime> limitDate;
  final Value<bool> isNotify;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.limitDate = const Value.absent(),
    this.isNotify = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    required DateTime limitDate,
    this.isNotify = const Value.absent(),
  })  : content = Value(content),
        limitDate = Value(limitDate);
  static Insertable<Todo> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<DateTime>? limitDate,
    Expression<bool>? isNotify,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (limitDate != null) 'limit_date': limitDate,
      if (isNotify != null) 'is_notify': isNotify,
    });
  }

  TodosCompanion copyWith(
      {Value<int>? id,
      Value<String>? content,
      Value<DateTime>? limitDate,
      Value<bool>? isNotify}) {
    return TodosCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      limitDate: limitDate ?? this.limitDate,
      isNotify: isNotify ?? this.isNotify,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (limitDate.present) {
      map['limit_date'] = Variable<DateTime>(limitDate.value);
    }
    if (isNotify.present) {
      map['is_notify'] = Variable<bool>(isNotify.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('limitDate: $limitDate, ')
          ..write('isNotify: $isNotify')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $TodosTable todos = $TodosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todos];
}
