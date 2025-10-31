import 'dart:convert';

class ProducerUpdateDocumentResponse {
  final int? status;
  final String? message;
  final ProducerDocumentData? data;

  ProducerUpdateDocumentResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ProducerUpdateDocumentResponse.fromJson(dynamic json) {
    if (json is String) {
      json = jsonDecode(json);
    }

    return ProducerUpdateDocumentResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? ProducerDocumentData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };

  static ProducerUpdateDocumentResponse fromJsonString(String str) =>
      ProducerUpdateDocumentResponse.fromJson(json.decode(str));

  String toJsonString() => json.encode(toJson());
}

class ProducerDocumentData {
  final String? document1;
  final DateTime? document1Expiry;
  final String? document2;
  final DateTime? document2Expiry;

  ProducerDocumentData({
    this.document1,
    this.document1Expiry,
    this.document2,
    this.document2Expiry,
  });

  factory ProducerDocumentData.fromJson(Map<String, dynamic> json) {
    return ProducerDocumentData(
      document1: json['document1'],
      document1Expiry: json['document1Expiry'] != null
          ? DateTime.tryParse(json['document1Expiry'])
          : null,
      document2: json['document2'],
      document2Expiry: json['document2Expiry'] != null
          ? DateTime.tryParse(json['document2Expiry'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'document1': document1,
    'document1Expiry': document1Expiry?.toIso8601String(),
    'document2': document2,
    'document2Expiry': document2Expiry?.toIso8601String(),
  };
}
