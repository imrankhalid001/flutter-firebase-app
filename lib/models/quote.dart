class Quote {
  String id;
  String title;

  Quote({required this.id, required this.title});

  // Convert a Quote into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  // Create a Quote from a Map
  static Quote fromMap(String id, Map<String, dynamic> map) {
    return Quote(
      id: id,
      title: map['title'],
    );
  }
}
