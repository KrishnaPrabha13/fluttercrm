class LeadBySourceData {
  String leadbysource;
  double count;

  LeadBySourceData(this.leadbysource, this.count);

  Map toJson() => {
        'leadbysource': leadbysource,
        'count': count,
      };
}
