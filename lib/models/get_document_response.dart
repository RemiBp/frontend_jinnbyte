class GetDocumentsResponse {
  int? status;
  String? message;
  DocumentsData? data;

  GetDocumentsResponse({
    this.status,
    this.message,
    this.data,
  });

  factory GetDocumentsResponse.fromJson(Map<String, dynamic> json) {
    return GetDocumentsResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? DocumentsData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class DocumentsData {
  String? document1;
  String? document1Expiry;
  String? document2;
  String? document2Expiry;

  DocumentsData({
    this.document1,
    this.document1Expiry,
    this.document2,
    this.document2Expiry,
  });

  factory DocumentsData.fromJson(Map<String, dynamic> json) {
    return DocumentsData(
      document1: json['document1'],
      document1Expiry: json['document1Expiry'],
      document2: json['document2'],
      document2Expiry: json['document2Expiry'],
    );
  }

  Map<String, dynamic> toJson() => {
    'document1': document1,
    'document1Expiry': document1Expiry,
    'document2': document2,
    'document2Expiry': document2Expiry,
  };
}
