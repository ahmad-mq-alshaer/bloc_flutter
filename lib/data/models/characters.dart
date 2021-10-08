class Character{
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String statusIfDeadOrAlive;
  late List<dynamic> appearanceOfSeasons;
  late String actorName;
  late String categoryOfTowSeries;
  late List<dynamic> betterCallSaulappearance;

  Character.fromJson(Map<String , dynamic> json){
    charId = json["char_id"];
    name = json["name"];
    nickName = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    statusIfDeadOrAlive = json["status"];
    appearanceOfSeasons = json["appearance"];
    actorName = json["portrayed"];
    categoryOfTowSeries = json["category"];
    betterCallSaulappearance = json["better_call_saul_appearance"];
  }
}