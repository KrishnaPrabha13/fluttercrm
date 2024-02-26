class WeeklyDataDetail {
  String days;
  String companyName;
  String probability;
  String businessUnit;
  String leadSource;
  String leadStatus;
  String leadowner;
  String leadlookingfor;
  String probailityofleadcloser;
  String country;

  WeeklyDataDetail(
      this.days,
      this.companyName,
      this.probability,
      this.businessUnit,
      this.leadSource,
      this.leadStatus,
      this.leadowner,
      this.leadlookingfor,
      this.probailityofleadcloser,
      this.country);

  Map toJson() => {
        'dayName': days,
        'Company': companyName,
        'Probability': probability,
        'Business Unit': businessUnit,
        'Lead Source': leadSource,
        'Lead Status': leadStatus,
        'Lead Owner': leadowner,
        'lead lookingfor': leadlookingfor,
        'Probabilityofleadcloser': probailityofleadcloser,
        'country': country
      };
}
