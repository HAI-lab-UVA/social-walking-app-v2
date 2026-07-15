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
  String get formattedName {
    switch (this) {
      case SWGender.male:
        return "Male";
      case SWGender.female:
        return "Female";
      case SWGender.nonbinary:
        return "Non-Binary";
      case SWGender.other:
        return "Other";
      case SWGender.preferNotToSay:
        return "Prefer Not To Say";
    }
  }
}
