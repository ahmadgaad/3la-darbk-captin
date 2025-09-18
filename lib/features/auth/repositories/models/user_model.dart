import 'dart:io';


import '../../../../core/utils/heplers/file_utils.dart';

class UserModel  {
  final int? id;
  final String? image;
  final String? password;
  final File? imageFile;
  final String? name;
  final String? mobile;
  final String? address;
  final String? dateOfBirth;
  final String? nationalNumber;
  final String? licenseExpiration;
  final String? nameBank;
  final String? bankAccountNumber;
  final String? typeCar;
  final String? categoryCar;
  final String? yearManufacture;
  final String? platesNumber;
  final String? platesString;
  final String? imageCar;
  final File? imageCarFile;
  final int? status;
  final int? workValid;
  final int? canEdit;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    this.id,
    this.workValid,
    this.canEdit,
    this.password,
    this.imageFile,
    this.image,
    this.name,
    this.mobile,
    this.address,
    this.dateOfBirth,
    this.nationalNumber,
    this.licenseExpiration,
    this.nameBank,
    this.bankAccountNumber,
    this.typeCar,
    this.categoryCar,
    this.yearManufacture,
    this.platesNumber,
    this.platesString,
    this.imageCar,
    this.imageCarFile,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  const UserModel.register({
    this.id,
    required this.imageFile,
    this.canEdit,
    this.image,
    this.workValid,
    this.password,
    required this.name,
    required this.mobile,
    required this.address,
    required this.dateOfBirth,
    required this.nationalNumber,
    required this.licenseExpiration,
    required this.nameBank,
    required this.bankAccountNumber,
    required this.typeCar,
    required this.categoryCar,
    required this.yearManufacture,
    required this.platesNumber,
    required this.platesString,
    this.imageCar,
    required this.imageCarFile,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  UserModel copyWith({
    int? id,
    File? imageFile,
    String? image,
    String? name,
    String? mobile,
    String? address,
    String? dateOfBirth,
    String? nationalNumber,
    String? licenseExpiration,
    String? nameBank,
    String? bankAccountNumber,
    String? typeCar,
    String? categoryCar,
    String? yearManufacture,
    String? platesNumber,
    String? platesString,
    String? imageCar,
    File? imageCarFile,
    int? status,
    int? workValid,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        workValid: workValid ?? this.workValid,
        image: image ?? this.image,
        name: name ?? this.name,
        imageFile: imageFile ?? this.imageFile,
        mobile: mobile ?? this.mobile,
        address: address ?? this.address,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        nationalNumber: nationalNumber ?? this.nationalNumber,
        licenseExpiration: licenseExpiration ?? this.licenseExpiration,
        nameBank: nameBank ?? this.nameBank,
        bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
        typeCar: typeCar ?? this.typeCar,
        categoryCar: categoryCar ?? this.categoryCar,
        yearManufacture: yearManufacture ?? this.yearManufacture,
        platesNumber: platesNumber ?? this.platesNumber,
        platesString: platesString ?? this.platesString,
        imageCar: imageCar ?? this.imageCar,
        imageCarFile: imageCarFile ?? this.imageCarFile,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        dateOfBirth: json["date_of_birth"],
        nationalNumber: json["national_number"],
        licenseExpiration: json["license_expiration"],
        nameBank: json["name_bank"],
        bankAccountNumber: json["bank_account_number"],
        typeCar: json["type_car"],
        categoryCar: json["category_car"],
        yearManufacture: json["year_manufacture"],
        platesNumber: json["plates_number"],
        platesString: json["plates_string"],
        imageCar: json["image_car"],
        status: json["status"],
        canEdit: json["can_edit"],
        workValid: json["work_valid"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (imageFile != null)
          "image":FileUtils.getMultiPartFile(imageFile),
        if (name != null) "name": name,
        if (mobile != null) "mobile": mobile,
        if (address != null) "address": address,
        if (dateOfBirth != null) "date_of_birth": dateOfBirth,
        if (nationalNumber != null) "national_number": nationalNumber,
        if (licenseExpiration != null) "license_expiration": licenseExpiration,
        if (nameBank != null) "name_bank": nameBank,
        if (bankAccountNumber != null) "bank_account_number": bankAccountNumber,
        if (typeCar != null) "type_car": typeCar,
        if (categoryCar != null) "category_car": categoryCar,
        if (yearManufacture != null) "year_manufacture": yearManufacture,
        if (platesNumber != null) "plates_number": platesNumber,
        if (platesString != null) "plates_string": platesString,
        if (password != null) 'password': password,
        if (imageCarFile != null)
          "image_car":  FileUtils.getMultiPartFile(imageCarFile),
        if (workValid != null) "work_valid": workValid,
      };

 
}
