class CityModel {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String latitude;
  final String longitude;

  CityModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.latitude,
    required this.longitude,
  });

  CityModel copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? latitude,
    String? longitude,
  }) => CityModel(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
  );

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }
}
