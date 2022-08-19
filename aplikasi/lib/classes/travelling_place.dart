import 'dart:convert';

import 'package:hive/hive.dart';

part "travelling_place.g.dart";

@HiveType(typeId: 1)
class TravellingPlace{
  @HiveField(0)
  int placeId;

  @HiveField(1)
  String placeName;

  @HiveField(2)
  String description;

  @HiveField(3)
  String category;

  @HiveField(4)
  String city;

  @HiveField(5)
  int? price;

  @HiveField(6)
  double? rating;

  @HiveField(7)
  double? timeMinutes;

  @HiveField(8)
  double? latitude;

  @HiveField(9)
  double? longitude;

  @HiveField(10)
  String? summarizedDescription;

  TravellingPlace({
    required this.placeId,
    required this.placeName,
    required this.description,
    required this.category,
    required this.city,
    this.price,
    this.rating,
    this.latitude,
    this.longitude,
    this.timeMinutes,
    this.summarizedDescription
  });

  String getRating(){
    if (rating == null){
      return "Unknown";
    }
    else{
      return rating.toString();
    }
  }

  String getPrice(){
    if (price == null){
      return "Unknown";
    }
    else if (price == 0){
      return "Gratis";
    }
    else{
      return price.toString();
    }
  }

  String getSummarizedDescription(){
    if (summarizedDescription == null){
      return "Tidak ada deskripsi";
    }
    else{
      return summarizedDescription.toString();
    }
  }

  factory TravellingPlace.setFromJSON(Map<String, dynamic> jsonDatum){
    String coordinate = jsonDatum["coordinate"];
    coordinate = coordinate.replaceAll("'", '"');
    Map<String, dynamic> coordinateJSON = jsonDecode(coordinate);

    return TravellingPlace(
      placeId: jsonDatum["place_id"],
      placeName: jsonDatum["place_name"],
      description: jsonDatum["description"],
      category: jsonDatum["category"],
      city: jsonDatum["city"],
      rating: jsonDatum["rating"],
      price: jsonDatum["price"],
      latitude: coordinateJSON['lat'],
      longitude: coordinateJSON['lng'],
      timeMinutes: jsonDatum["time_minutes"],
      summarizedDescription: jsonDatum["summarized_description"]
    );
  }
}