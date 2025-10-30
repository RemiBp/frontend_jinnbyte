class GetProducerOperationalHoursResponse {
  GetProducerOperationalHoursResponse({
    required this.data,
  });

  final List<ProducerOperationalHour> data;

  factory GetProducerOperationalHoursResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    final List<dynamic> list = (json['data'] as List<dynamic>? ?? <dynamic>[]);
    return GetProducerOperationalHoursResponse(
      data: list
          .map((dynamic e) => ProducerOperationalHour.fromJson(
                e as Map<String, dynamic>,
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'data': data.map((e) => e.toJson()).toList(),
      };
}

class ProducerOperationalHour {
  ProducerOperationalHour({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.userId,
    required this.isDeleted,
    required this.isActive,
    required this.isClosed,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String day;
  final String? startTime; // e.g., "10:00:00" or null
  final String? endTime; // e.g., "12:30:00" or null
  final int userId;
  final bool isDeleted;
  final bool isActive;
  final bool isClosed;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ProducerOperationalHour.fromJson(Map<String, dynamic> json) {
    return ProducerOperationalHour(
      id: (json['id'] as num).toInt(),
      day: json['day'] as String? ?? '',
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      userId: (json['userId'] as num).toInt(),
      isDeleted: json['isDeleted'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,
      isClosed: json['isClosed'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'day': day,
        'startTime': startTime,
        'endTime': endTime,
        'userId': userId,
        'isDeleted': isDeleted,
        'isActive': isActive,
        'isClosed': isClosed,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
