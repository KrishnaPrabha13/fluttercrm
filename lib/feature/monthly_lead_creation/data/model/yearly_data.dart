class YearlyData {
  String? months;
  int? count;
  String? year;

  YearlyData(this.months, this.count, this.year);

  Map toJson() => {
        'months': months,
        'count': count,
        'year': year,
      };
}
