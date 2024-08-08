import 'package:code/Models/instructions_object.dart';
import 'package:code/Models/phone_local.dart';
import 'package:code/Models/transaction_object.dart';

class FakeData {
  static Map userInfo = {
    "uid": "QSD5qs65zsxdcsq",
    "firstName": "FirstName",
    "lastName": "LastName",
    "gender": "Male",
    "birthDate": "29-10-2001 10:00:00.000",
    "pictureUrl": "url.com",
    "email": "email@adress.com",
    "phoneNumber": "213;784397078",
    "token": "2525GGDI23551ZXX0001",
  };

  static Map<String, InstructionsObj?> instructions = {
    "515Fdjk7": InstructionsObj.fromMap({
      "duration": 30,
      "tpd": 2,
      "ppt": 0.5,
      "time": 0,
    }),
    "d4qsd65K": InstructionsObj.fromMap({
      "duration": 15,
      "tpd": 3,
      "ppt": 1,
      "time": 1,
    }),
    "SQqsd45QSD": InstructionsObj.fromMap({
      "duration": 15,
      "tpd": 1,
      "ppt": 1,
      "time": 2,
    })
  };

  static var notifications = [
    TransactionObj.fromMap({
      "source": "El Hanaa",
      "location": "Boulevard des lions, Oran",
      "timestamp": "24-07-2024 10:00:00.000",
      "total": 500,
    }, instructions),
    TransactionObj.fromMap({
      "source": "Al Rahma",
      "location": "USTO, Oran",
      "timestamp": "23-07-2024 10:00:00.000",
      "openedAt": "24-07-2024 08:05:00.000",
      "total": 970,
    }, instructions),
    TransactionObj.fromMap({
      "source": "Abou Baker",
      "location": "Les Palmiers, Oran",
      "timestamp": "21-07-2024 10:00:00.000",
      "openedAt": "21-07-2024 10:15:53.000",
    }, instructions),
  ];

  static List<PhoneLocal> supportedLocales = [
    PhoneLocal(
        countryCode: 213,
        countryLocal: "dz",
        flagPath: "lib/Assets/Vectors/dz.svg"),
    PhoneLocal(
        countryCode: 33,
        countryLocal: "fr",
        flagPath: "lib/Assets/Vectors/fr.svg"),
  ];
}
