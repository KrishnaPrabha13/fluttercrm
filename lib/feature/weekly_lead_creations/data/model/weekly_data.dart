class WeeklyData {
  String days;
  int count;

  WeeklyData(this.days, this.count);

  Map toJson() => {
    'dayName': days,
    'count': count,
  };
}