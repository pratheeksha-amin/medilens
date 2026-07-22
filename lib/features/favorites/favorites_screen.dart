import 'package:flutter/material.dart';
import '../../services/medicine_storage_service.dart';


class FavoritesScreen extends StatefulWidget {

  const FavoritesScreen({super.key});


  @override
  State<FavoritesScreen> createState() =>
      _FavoritesScreenState();

}



class _FavoritesScreenState extends State<FavoritesScreen> {

  List<Map<String,dynamic>> medicines = [];


  @override
  void initState() {
    super.initState();
    loadFavorites();
  }


  Future<void> loadFavorites() async {

    final data =
    await MedicineStorageService.getFavourite();

    setState(() {
      medicines = data;
    });

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Favorites"),
      ),


      body: medicines.isEmpty

          ? const Center(
        child: Text(
          "No favorite medicines",
        ),
      )


          : ListView.builder(

        itemCount: medicines.length,

        itemBuilder: (context,index){

          return Card(

            child: ListTile(

              leading: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),

              title: Text(
                medicines[index]["name"]
                    .toString(),
              ),

            ),

          );

        },

      ),

    );

  }

}