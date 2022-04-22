// {
// "id": 92576,
// "answer": "7",
// "question": "When writing, many Europeans cross it; most Americans don't",
// "value": 800,
// "airdate": "2008-12-08T12:00:00.000Z",
// "created_at": "2014-02-14T01:58:09.356Z",
// "updated_at": "2014-02-14T01:58:09.356Z",
// "category_id": 8472,
// "game_id": null,
// "invalid_count": null,
// "category": {
// "id": 8472,
// "title": "a number from 1 to 10",
// "created_at": "2014-02-11T23:28:10.844Z",
// "updated_at": "2014-02-11T23:28:10.844Z",
// "clues_count": 10
// }
// }

class Quiz {
  final int id;
  final String answer;
  final String question;
  final Category2 category2;

  Quiz({
    required this.id,
    required this.answer,
    required this.question,
    required this.category2,
  });

  String showQuiz() {
    return """
final int id = $id
final String answer = $answer
final String question = $question
final Category2 category2 = ${category2.id}
    """;
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      answer: json['answer'],
      question: json['question'],
      category2: Category2.fromJson(json['category']),
    );
  }
}

class Category2 {
  final int id;
  final String title;

  const Category2({
    required this.id,
    required this.title,
  });

  factory Category2.fromJson(Map<String, dynamic> json) {
    return Category2(
      id: json['id'],
      title: json['title'],
    );
  }
}
