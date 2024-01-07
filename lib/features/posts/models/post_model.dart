class PostModel {
  final String id;
  final String description;
  final int mood;
  final int createdAt;
  final int updatedAt;

  PostModel({
    required this.id,
    required this.description,
    required this.mood,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'mood': mood,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      description: json['description'],
      mood: json['mood'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
