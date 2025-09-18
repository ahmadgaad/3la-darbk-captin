
class ResponseModel  {
  final dynamic data;
  final String? message;
  final String? token;
  final dynamic code;
  final String? status;
  final bool? success;

  const ResponseModel({
    this.data,
    this.code,
    this.message,
    this.success,
    this.status,
    this.token,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      data: json['data'],
      code: json['code'],
      token: json['token'],
      success: json["success"],
      status: json["status"],
      message: json["message"],
    );
  }

}
