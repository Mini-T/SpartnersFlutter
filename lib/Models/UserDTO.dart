

class UserDTO{
  String firstname = '';
  String lastname = '';
  String email = '';
  String sex = '';
  String city = '';
  String level = '';
  String objective = '';
  String description = '';
  double? latitude;
  double? longitude;
  int? sportsHall;
  int? age = null;
  String joinDate = '';
  bool visible = false;

  UserDTO(
      {this.firstname = '',
       this.lastname = '',
       this.email = '',
       this.sex = '',
       this.city = '',
       this.level = '',
       this.objective = '',
       this.description = '',
        this.age = 16,
        this.joinDate = '',
        this.sportsHall = null,
        this.latitude = 0,
        this.longitude = 0,
        this.visible = false,
      });

  String getJoinDateInSentence(){
    Map<String, String> monthMap = {
      '01': 'Janvier',
      '02': 'Février',
      '03': 'Mars',
      '04': 'Avril',
      '05': 'Mai',
      '06': 'Juin',
      '07': 'Juillet',
      '08': 'Août',
      '09': 'Septembre',
      '10': 'Octobre',
      '11': 'Novembre',
      '12': 'Décembre',
    };
    List<String> formattedDate = this.joinDate.split('-');
    print(formattedDate);
    String day = formattedDate[2].toString();
    String? month = monthMap[formattedDate[1]];
    String year = formattedDate[0];
    return "$day $month $year";
  }

  Map<String, dynamic> toMap(){
    return {
      'firstname' : firstname,
      'lastname' : lastname,
      'email' : email,
      'sex' : sex,
      'city' : city,
      'level' : level,
      'objective' : objective,
      'description' : description,
      'age': age,
      'joinDate' : joinDate,
      'longitude' : longitude,
      'sportsHall' : sportsHall,
      'latitude' : latitude,
      'visible' : visible,
    };
  }
}
