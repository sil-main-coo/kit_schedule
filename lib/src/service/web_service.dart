import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:schedule/src/models/data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class WebService {
   String scheduleJson;

  Future<int> fetchSchudeleData(String account, String password) async {
    try {
      var response  = await http.get(
          "http://schedulekma.herokuapp.com/api/kma?username=$account&password=$password",
          headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 20));
      this.handleResponseException(response);
      Data data = Data.fromJson(json.decode(response.body));
      if (data.error == "error") {
        return 0;
      } else if (data == null) {
        return -1;
      } else {
        persistData("data", response.body);
        return 1;
      }
    } catch (e) {
      throw e;
    }

  }

   Future<void> persistData(String key, String value) async {
     final storage = new FlutterSecureStorage();

     return storage.write(key: key, value: value);
   }

   // Get value from SecureStorage
   Future<String> retrieveData(String key) async {
     final storage = new FlutterSecureStorage();
     this.scheduleJson = await storage.read(key: key);
     return  this.scheduleJson;
   }

   Future<void> deleteData(String key) async {
     final storage = new FlutterSecureStorage();
     storage.delete(key: key);
     this.scheduleJson = null;
   }

   void handleResponseException(response) {

     if (response != null && response.statusCode != 200) {
       String errorResponse = response.body;

       if (errorResponse.contains('message')) {
         try {
           var  errorJson = json.decode(errorResponse);

           String messageOut = errorJson['message'];
           throw Exception(messageOut);

         } on Exception catch (e) {
           throw e;

         }
       }
     } else if (response == null) {
       throw Exception('Error happened when get quote id for customer error code ${response.statusCode.toString()}');
     }

   }
}