class ProducerDeleteDocumentResponse {
  final int? status;
  final String? message;
  final DeleteDocumentData? data;

  ProducerDeleteDocumentResponse({this.status, this.message, this.data});

  factory ProducerDeleteDocumentResponse.fromJson(Map<String, dynamic> json) {
    return ProducerDeleteDocumentResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? DeleteDocumentData.fromJson(json['data'])
          : null,
    );
  }
}

class DeleteDocumentData {
  final int? id;
  final String? deletedField;

  DeleteDocumentData({this.id, this.deletedField});

  factory DeleteDocumentData.fromJson(Map<String, dynamic> json) {
    return DeleteDocumentData(
      id: json['id'],
      deletedField: json['deletedField'],
    );
  }
}
