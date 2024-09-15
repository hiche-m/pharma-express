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
      "label": "Doliprane 500mg",
      "duration": 30,
      "tpd": 2,
      "ppt": 1,
      "time": 1,
    }),
    "d4qsd65K": InstructionsObj.fromMap({
      "label": "MED1",
      "duration": 15,
      "tpd": 1,
      "ppt": 0.5,
      "time": 2,
    }),
    "SQqsd45QSD": InstructionsObj.fromMap({
      "label": "MED2",
      "duration": 15,
      "tpd": 2,
      "ppt": 1,
      "time": 1,
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

  static Map pharmaciesLocation = {
    'A1B2C3': {
      "name": "Bouziane Pharmacy",
      "longtitude": 35.697262607077086,
      "latitude": -0.6072347962559662,
    },
    'D4E5F6': {
      "name": "Center Exploration Cardiovascular Dr Handoumeh Wassim",
      "longtitude": 35.69519235599149,
      "latitude": -0.616543627070969,
    },
    'G7H8I9': {
      "name": "Pharmacie CHELLAL S Oran",
      "longtitude": 35.691508970520694,
      "latitude": -0.6129866838338345,
    },
    'J1K2L3': {
      "name": "PHARMACIE Dr. BOUKALKHA",
      "longtitude": 35.70311360377163,
      "latitude": -0.6102816760420045,
    },
  };
}
