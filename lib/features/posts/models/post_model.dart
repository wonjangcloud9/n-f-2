class PostModel {
  final String description;
  final int mood;
  final int createdAt;
  final int updatedAt;

  PostModel({
    required this.description,
    required this.mood,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'mood': mood,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      description: json['description'],
      mood: json['mood'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
