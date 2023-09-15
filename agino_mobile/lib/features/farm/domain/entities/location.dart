class LocationEntity {
  final int postcode;
  final String city;
  final String country;
  final String displayName;

  LocationEntity(
      {
      required this.postcode,
      required this.city,
      required this.displayName,
      required this.country});
}
