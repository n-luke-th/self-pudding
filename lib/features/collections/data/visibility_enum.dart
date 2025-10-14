enum VisibilityEnum {
  private,
  public;

  static String getStr(VisibilityEnum v) {
    return v.name;
  }

  static VisibilityEnum getEnum(String str) {
    switch (str) {
      case "public":
        return VisibilityEnum.public;
      default:
        return VisibilityEnum.private;
    }
  }
}
