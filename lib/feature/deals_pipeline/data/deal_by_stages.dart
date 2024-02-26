class DealByStages {
  String dealbystage;
  int count;
  int orderbystatus;

  DealByStages(this.dealbystage, this.count, this.orderbystatus);

  Map toJson() => {
        'dealbystage': dealbystage,
        'count': count,
        'orderbystatus': orderbystatus
      };
}
