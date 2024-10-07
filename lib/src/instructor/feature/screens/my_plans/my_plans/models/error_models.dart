class PermissionError {
  final String detail;

  PermissionError({required this.detail});

  factory PermissionError.fromJson(Map<String, dynamic> json) {
    return PermissionError(
      detail: json['detail'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    return data;
  }
}
