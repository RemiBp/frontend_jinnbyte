class GetProducerOperationalHoursResponse {
  final List<OperationalHour> operationalHours;

  GetProducerOperationalHoursResponse({
    required this.operationalHours,
  });

  factory GetProducerOperationalHoursResponse.fromJson(List<dynamic> json) {
    return GetProducerOperationalHoursResponse(
      operationalHours: json.map((item) => OperationalHour.fromJson(item)).toList(),
    );
  }

  List<dynamic> toJson() {
    return operationalHours.map((item) => item.toJson()).toList();
  }
}

class OperationalHour {
  final int? id;
  final String? day;
  final String? startTime;
  final String? endTime;
  final int? userId;
  final bool? isDeleted;
  final bool? isActive;
  final bool? isClosed;
  final String? createdAt;
  final String? updatedAt;

  OperationalHour({
    this.id,
    this.day,
    this.startTime,
    this.endTime,
    this.userId,
    this.isDeleted,
    this.isActive,
    this.isClosed,
    this.createdAt,
    this.updatedAt,
  });

  factory OperationalHour.fromJson(Map<String, dynamic> json) {
    return OperationalHour(
      id: json['id'] as int?,
      day: json['day'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      userId: json['userId'] as int?,
      isDeleted: json['isDeleted'] as bool?,
      isActive: json['isActive'] as bool?,
      isClosed: json['isClosed'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'userId': userId,
      'isDeleted': isDeleted,
      'isActive': isActive,
      'isClosed': isClosed,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}