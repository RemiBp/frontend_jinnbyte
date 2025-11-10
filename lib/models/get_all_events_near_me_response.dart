class GetEventsNearMeResponse {
  int? status;
  String? message;
  List<EventData>? data;

  GetEventsNearMeResponse({this.status, this.message, this.data});

  GetEventsNearMeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<EventData>.from(json['data'].map((v) => EventData.fromJson(v)));
    }
  }
}

class EventData {
  int? id;
  String? title;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  String? venueName;
  String? location;
  String? latitude;
  String? longitude;
  String? serviceType;
  String? pricePerGuest;
  List<String>? eventImages;

  EventData({
    this.id,
    this.title,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.venueName,
    this.location,
    this.latitude,
    this.longitude,
    this.serviceType,
    this.pricePerGuest,
    this.eventImages,
  });

  EventData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    venueName = json['venueName'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    serviceType = json['serviceType'];
    pricePerGuest = json['pricePerGuest'];
    if (json['eventImages'] != null) {
      eventImages = List<String>.from(json['eventImages']);
    }
  }
}
