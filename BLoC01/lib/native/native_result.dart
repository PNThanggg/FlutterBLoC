class NativeResult {
  bool? success;
  String? code;
  String? message;
  dynamic data;

  NativeResult({
    this.success,
    this.code,
    this.message,
    this.data,
  });

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data,
      };
}
