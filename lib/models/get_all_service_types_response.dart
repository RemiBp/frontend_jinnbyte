class GetAllServiceTypesResponse {
  final String message;
  final List<EventType> eventTypes;

  GetAllServiceTypesResponse({
    required this.message,
    required this.eventTypes,
  });

  factory GetAllServiceTypesResponse.fromJson(Map<String, dynamic> json) {
    return GetAllServiceTypesResponse(
      message: json['message'] as String,
      eventTypes: (json['eventTypes'] as List<dynamic>)
          .map((item) => EventType.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'eventTypes': eventTypes.map((item) => item.toJson()).toList(),
    };
  }
}

class EventType {
  final int id;
  final String name;
  final List<String> criteria;
  final String createdAt;
  final String updatedAt;

  EventType({
    required this.id,
    required this.name,
    required this.criteria,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventType.fromJson(Map<String, dynamic> json) {
    return EventType(
      id: json['id'] as int,
      name: json['name'] as String,
      criteria: (json['criteria'] as List<dynamic>)
          .map((item) => item as String)
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'criteria': criteria,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
