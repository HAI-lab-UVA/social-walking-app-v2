enum SWGender {
  male("Male"),
  female("Female"),
  nonbinary("Non-Binary"),
  other("Other"),
  preferNotToSay("Prefer Not To Say");

  final String formattedName;
  const SWGender(this.formattedName);
}

extension SWGenderExtension on SWGender {
  static SWGender? fromFormattedName(String name) {
    for (var value in SWGender.values) {
      if (value.formattedName == name) return value;
    }
    return null;
  }

  static List<String> formattedNames() {
    return SWGender.values.map((e) => e.formattedName).toList();
  }
}

final pronounsList = [
  "she/her",
  "he/him",
  "they/them",
  "she/they",
  "he/they",
  "they/she",
  "they/he",
  "she/he",
  "he/she",
  "Any Pronouns",
  "Prefer Not To Say",
];
