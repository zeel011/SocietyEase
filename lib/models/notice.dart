class Notice {
  final String id;
  final String title;
  final String content;
  final DateTime postedDate;
  final String? author;
  final bool isImportant;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.postedDate,
    this.author,
    this.isImportant = false,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      postedDate: DateTime.parse(json['postedDate']),
      author: json['author'],
      isImportant: json['isImportant'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'postedDate': postedDate.toIso8601String(),
      'author': author,
      'isImportant': isImportant,
    };
  }
}
