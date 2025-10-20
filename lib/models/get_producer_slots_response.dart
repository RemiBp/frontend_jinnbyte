class GetProducerSlotsResponse {
  final List<DaySlot> data;

  GetProducerSlotsResponse({
    required this.data,
  });

  factory GetProducerSlotsResponse.fromJson(Map<String, dynamic> json) {
    return GetProducerSlotsResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => DaySlot.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class DaySlot {
  final String day;
  final List<Slot> slots;

  DaySlot({
    required this.day,
    required this.slots,
  });

  factory DaySlot.fromJson(Map<String, dynamic> json) {
    return DaySlot(
      day: json['day'] as String,
      slots: (json['slots'] as List<dynamic>)
          .map((item) => Slot.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'slots': slots.map((item) => item.toJson()).toList(),
    };
  }
}

class Slot {
  final int id;
  final String day;
  final String startTime;
  final String endTime;
  final int userId;
  final bool isDeleted;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  Slot({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.userId,
    required this.isDeleted,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      id: json['id'] as int,
      day: json['day'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      userId: json['userId'] as int,
      isDeleted: json['isDeleted'] as bool,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
