class SWFitnessGoal {
  final int goal;
  final int current;

  SWFitnessGoal({required this.goal, required this.current});

  factory SWFitnessGoal.fromString(String str) {
    final split = str.split("/");
    final current = int.parse(split[0]);
    final goal = int.parse(split[1]);
    return SWFitnessGoal(goal: goal, current: current);
  }

  @override
  String toString() {
    return "$current/$goal";
  }
}
