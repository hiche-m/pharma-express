import 'package:code/Models/phone_number.dart';
import 'package:code/Utils/parameters.dart';

class UserObj {
  final String uid;
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime birthDate;
  final String? pictureUrl;
  final String? email;
  final PhoneNumberObj? phoneNumber;

  UserObj({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDate,
    this.pictureUrl,
    this.email,
    this.phoneNumber,
  }) {
    if (email == null && phoneNumber == null) {
      throw Exception(
          "UserObj: ($firstName $lastName)\n\nAn email or a phone number must be provided!");
    }
  }

  UserObj.fromMap(Map map)
      : uid = map["uid"].toString(),
        firstName = map["firstName"].toString(),
        lastName = map["lastName"].toString(),
        gender = map["gender"].toString(),
        birthDate = Params.defaultDateFormat.parse(map["birthDate"]),
        pictureUrl = map["pictureUrl"].toString(),
        email = map["email"].toString(),
        phoneNumber = map["phoneNumber"] != null
            ? PhoneNumberObj(
                number: int.parse(map["phoneNumber"].toString().split(";")[1]),
                countryCode:
                    int.parse(map["phoneNumber"].toString().split(";")[0]),
              )
            : null;

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "birthDate": Params.defaultDateFormat.format(birthDate),
      "pictureUrl": pictureUrl,
      "email": email,
      "phoneNumber": phoneNumber != null
          ? "${phoneNumber!.countryCode};${phoneNumber!.number}"
          : null,
    };
  }
}
