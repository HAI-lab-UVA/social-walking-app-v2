enum SWWalkPreference {
  slow("Slow Walk"),
  fast("Fast Walk"),
  jog("Jogging"),
  chatting("Chatting"),
  quiet("Quiet"),
  dogWalk("Walking the Dog"),
  scenery("Observing Scenery"),
  music("Listening to Music"),
  shopping("Going Shopping"),
  hiking("Hiking"),
  suburbs("In the Suburbs"),
  city("In the City"),
  nature("In Nature"),
  trails("On Trails");

  final String formattedName;
  const SWWalkPreference(this.formattedName);
}

extension SWWalkPreferenceExtension on SWWalkPreference {
  static SWWalkPreference? fromFormattedName(String name) {
    for (var value in SWWalkPreference.values) {
      if (value.formattedName == name) return value;
    }
    return null;
  }

  static List<String> formattedNames() {
    return SWWalkPreference.values.map((e) => e.formattedName).toList();
  }
}
