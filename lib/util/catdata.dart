class CatData {
  String statement;

  CatData(this.statement);

  Map<String, dynamic> toJson() {
    return {"statement": this.statement};
  }
}
