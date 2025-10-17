import '../../../auth/repositories/models/user_model.dart';
import 'city_model.dart';

class TripModel {
  final int? id;
  final int? cityFromId;
  final int? cityToId;
  final String? numTrip;
  final String? date;
  final String? time;
  final dynamic endDate;
  final int? driverId;
  final int? status;
  final String? latitude;
  final String? longitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final CityModel? cityFrom;
  final CityModel? cityTo;
  final UserModel? driver;

  TripModel({
    this.id,
    this.cityFromId,
    this.cityToId,
    this.numTrip,
    this.date,
    this.time,
    this.endDate,
    this.driverId,
    this.status,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.cityFrom,
    this.cityTo,
    this.driver,
  });

  TripModel copyWith({
    int? id,
    int? cityFromId,
    int? cityToId,
    String? numTrip,
    String? date,
    String? time,
    dynamic endDate,
    int? driverId,
    int? status,
    String? driverLat,
    String? driverLng,
    DateTime? createdAt,
    DateTime? updatedAt,
    CityModel? cityFrom,
    CityModel? cityTo,
    UserModel? driver,
  }) => TripModel(
    id: id ?? this.id,
    cityFromId: cityFromId ?? this.cityFromId,
    cityToId: cityToId ?? this.cityToId,
    numTrip: numTrip ?? this.numTrip,
    date: date ?? this.date,
    time: time ?? this.time,
    endDate: endDate ?? this.endDate,
    driverId: driverId ?? this.driverId,
    status: status ?? this.status,
    latitude: driverLat ?? latitude,
    longitude: driverLng ?? longitude,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    cityFrom: cityFrom ?? this.cityFrom,
    cityTo: cityTo ?? this.cityTo,
    driver: driver ?? this.driver,
  );

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
    id: json["id"],
    cityFromId: json["city_from_id"],
    cityToId: json["city_to_id"],
    numTrip: json["num_trip"],
    date: json["date"],
    time: json["time"],
    endDate: json["end_date"],
    driverId: json["driver_id"],
    status: int.tryParse(json["status"].toString()),
    latitude: json["driver_lat"]?.toString(),
    longitude: json["driver_lng"]?.toString(),
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    cityFrom:
        json["city_from"] == null
            ? null
            : CityModel.fromJson(json["city_from"]),
    cityTo:
        json["city_to"] == null ? null : CityModel.fromJson(json["city_to"]),
    driver: json["driver"] == null ? null : UserModel.fromJson(json["driver"]),
  );

  Map<String, dynamic> toJson() => {
    "city_from_id": cityFromId,
    "city_to_id": cityToId,
    "date": date,
    "time": time,
    if (latitude != null) "latitude": latitude,
    if (longitude != null) "longitude": longitude,
  };
}
