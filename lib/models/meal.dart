class Meal {
  final String time;
  final String image;
  final String name;
  final String calories;
  final String portion;
  final List<String> ingredients;

  const Meal({
    required this.time,
    required this.image,
    required this.name,
    required this.calories,
    required this.portion,
    required this.ingredients,
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      time: map['time'] as String,
      image: map['image'] as String,
      name: map['name'] as String,
      calories: map['calories'] as String,
      portion: map['portion'] as String,
      ingredients: List<String>.from(map['ingredients'] as List),
    );
  }
}
