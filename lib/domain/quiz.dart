class Quiz {
  final int id;
  final String answer;
  final String question;
  final QuizCategory category2;

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
final QuizCategory quizCategory = ${category2.id}
    """;
  }

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      answer: json['answer'],
      question: json['question'],
      category2: QuizCategory.fromJson(json['category']),
    );
  }
}

class QuizCategory {
  final int id;
  final String title;

  const QuizCategory({
    required this.id,
    required this.title,
  });

  factory QuizCategory.fromJson(Map<String, dynamic> json) {
    return QuizCategory(
      id: json['id'],
      title: json['title'],
    );
  }
}
