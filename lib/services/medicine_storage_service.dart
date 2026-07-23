import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class MedicineStorageService {

  static const String historyKey = "medicine_history";
  static const String favouriteKey = "medicine_favourite";


  // Save History
  static Future<void> addToHistory(
      Map<String, dynamic> medicine) async {

    final prefs = await SharedPreferences.getInstance();

    List<String> history =
        prefs.getStringList(historyKey) ?? [];

    history.add(jsonEncode(medicine));

    await prefs.setStringList(
      historyKey,
      history,
    );
  }



  // Get History
  static Future<List<Map<String,dynamic>>> getHistory() async {

    final prefs = await SharedPreferences.getInstance();

    List<String> history =
        prefs.getStringList(historyKey) ?? [];


    return history.map((item) {

      return jsonDecode(item)
      as Map<String,dynamic>;

    }).toList();

  }




  // Add Favourite
  static Future<void> addFavourite(
      Map<String,dynamic> medicine) async {

    final prefs = await SharedPreferences.getInstance();


    List<String> favourites =
        prefs.getStringList(favouriteKey) ?? [];


    favourites.add(jsonEncode(medicine));


    await prefs.setStringList(
      favouriteKey,
      favourites,
    );

  }





  // Get Favourite
  static Future<List<Map<String,dynamic>>> getFavourite() async {


    final prefs = await SharedPreferences.getInstance();


    List<String> favourites =
        prefs.getStringList(favouriteKey) ?? [];



    return favourites.map((item){

      return jsonDecode(item)
      as Map<String,dynamic>;

    }).toList();

  }

}