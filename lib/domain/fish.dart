class Fish {
  final String text;


  const Fish({
    required this.text,
  });

  factory Fish.fromJson(Map<String, dynamic> json) {
    return Fish(
      text: json['Species Name'],

    );
  }
}