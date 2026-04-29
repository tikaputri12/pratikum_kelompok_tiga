class ApiModel {
  final String message;
  ApiModel({required this.message});

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(message: json['message'] ?? '');
  }
}