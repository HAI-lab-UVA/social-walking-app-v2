enum SWGender {
  male("Male"),
  female("Female"),
  nonbinary("Non-Binary"),
  other("Other"),
  preferNotToSay("Prefer Not To Say");

  final String name;
  const SWGender(this.name);
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
