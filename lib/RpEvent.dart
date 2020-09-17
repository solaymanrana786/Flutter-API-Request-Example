// To parse this JSON data, do
//
//     final rpEvent = rpEventFromJson(jsonString);

import 'dart:convert';

RpEvent rpEventFromJson(String str) => RpEvent.fromJson(json.decode(str));

String rpEventToJson(RpEvent data) => json.encode(data.toJson());

class RpEvent {
  RpEvent({
    this.data,
  });

  List<Datum> data;

  factory RpEvent.fromJson(Map<String, dynamic> json) => RpEvent(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.title,
    this.slug,
    this.image,
    this.location,
    this.startDate,
    this.endDate,
    this.description,
    this.fullUrl,
  });

  String title;
  String slug;
  String image;
  String location;
  DateTime startDate;
  DateTime endDate;
  String description;
  String fullUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"] == null ? null : json["title"],
    slug: json["slug"] == null ? null : json["slug"],
    image: json["image"] == null ? null : json["image"],
    location: json["location"] == null ? null : json["location"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    description: json["description"] == null ? null : json["description"],
    fullUrl: json["FullUrl"] == null ? null : json["FullUrl"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
    "image": image == null ? null : image,
    "location": location == null ? null : location,
    "start_date": startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
    "end_date": endDate == null ? null : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "description": description == null ? null : description,
    "FullUrl": fullUrl == null ? null : fullUrl,
  };
}
