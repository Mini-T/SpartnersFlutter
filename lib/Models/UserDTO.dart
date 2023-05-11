

class UserDTO{
  String firstname = '';
  String lastname = '';
  String email = '';
  String sex = '';
  String city = '';
  String level = '';
  String objective = '';
  String description = '';

  UserDTO(
      {this.firstname = '',
       this.lastname = '',
       this.email = '',
       this.sex = '',
       this.city = '',
       this.level = '',
       this.objective = '',
       this.description = ''
      });

  Map<String, String> toMap(){
    return {
      'firstname' : firstname,
      'lastname' : lastname,
      'email' : email,
      'sex' : sex,
      'city' : city,
      'level' : level,
      'objective' : objective,
      'description' : description,
    };
  }
}
