import 'package:drift/drift.dart';
import 'dart:convert';

class ListBoolConverter extends TypeConverter<List<bool>, String> {
  const ListBoolConverter();

  @override
  List<bool> fromSql(String fromDb) {
    List<dynamic> jsonList = json.decode(fromDb);
    return jsonList.map((item) => item as bool).toList();
  }

  @override
  String toSql(List<bool> value) {
    return json.encode(value);
  }
}

class ListStringConverter extends TypeConverter<List<String>, String> {
  const ListStringConverter();

  @override
  List<String> fromSql(String fromDb) {
    List<dynamic> jsonList = json.decode(fromDb);
    return jsonList.map((item) => item as String).toList();
  }

  @override
  String toSql(List<String> value) {
    return json.encode(value);
  }
}
