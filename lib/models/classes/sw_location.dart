class SWLocation {
  final double latitude;
  final double longitude;
  final String? address;

  SWLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory SWLocation.fromJson(Map<String, dynamic> json) {
    return SWLocation(
      latitude: json["latitude"],
      longitude: json["longitude"],
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"latitude": latitude, "longitude": longitude, "address": address};
  }
}
