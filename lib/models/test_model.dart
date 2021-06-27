import 'dart:convert';

class TestModel {
  final String id;
  final String valueX;
  final String valueY;
  TestModel({
    required this.id,
    required this.valueX,
    required this.valueY,
  });

  TestModel copyWith({
    String? id,
    String? valueX,
    String? valueY,
  }) {
    return TestModel(
      id: id ?? this.id,
      valueX: valueX ?? this.valueX,
      valueY: valueY ?? this.valueY,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valueX': valueX,
      'valueY': valueY,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      id: map['id'],
      valueX: map['valueX'],
      valueY: map['valueY'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TestModel.fromJson(String source) => TestModel.fromMap(json.decode(source));

  @override
  String toString() => 'TestModel(id: $id, valueX: $valueX, valueY: $valueY)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TestModel &&
      other.id == id &&
      other.valueX == valueX &&
      other.valueY == valueY;
  }

  @override
  int get hashCode => id.hashCode ^ valueX.hashCode ^ valueY.hashCode;
}
