class Launch {
  final String missionName;

  const Launch({
    required this.missionName,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      missionName: json['mission_name'],
    );
  }
}