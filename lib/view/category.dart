import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:my_app/model/newsModel.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  final String query;

  Category({required this.query});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];

  @override
  void initState() {
    super.initState();
    getNewsByQuery(widget.query);
  }

  Future<void> getNewsByQuery(String query) async {
    String url;
    if (query == "Top News") {
      url = "https://newsapi.org/v2/top-headlines?country=in&category=general&apiKey=43031493986f4ecabe0c218c63472343";
    } else if(query=="Business"){
      url = "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=43031493986f4ecabe0c218c63472343";
    }
    else if(query=="Entertainment") {
      url = "https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=43031493986f4ecabe0c218c63472343";
    }
   else if(query=="Sports") {
      url = "https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=43031493986f4ecabe0c218c63472343";
    }
   else if(query=="Technology"){
      url = "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=43031493986f4ecabe0c218c63472343";
    }
   else if(query=="Health"){
      url = "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=43031493986f4ecabe0c218c63472343";
    }
    else 
    {
      url = "https://newsapi.org/v2/everything?q=$query&apiKey=43031493986f4ecabe0c218c63472343";
    }

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final articles = jsonData["articles"] as List<dynamic>;

        setState(() {
          newsModelList.clear(); // Clear the list before adding new data

          for (var element in articles) {
            final newsQueryModel = NewsQueryModel.fromJson(element);
            newsModelList.add(newsQueryModel);
          }
        });
      } else {
        // Handle error here if the request is not successful
        debugPrint('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions here
      debugPrint('Error: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("News-Ley"),
        centerTitle: true,
       
        backgroundColor: const Color.fromARGB(255, 163, 214, 255),
        

      ),
      body: SingleChildScrollView(
      child:Container(
              
              child : Column(
              children :[ 

               const SizedBox(width: 15,),
                Container(
                 margin: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                  child : Row(
                  
                   mainAxisAlignment: MainAxisAlignment.start,
                 
                  children: [
                             
                           Container( 
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child :Text( widget.query ,
                            style: const  TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black)
                            ), 
                   )],
                 ),
                ),
                
                  ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsModelList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.greenAccent,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 1.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child:FadeInImage.assetNetwork(
                                   placeholder: 'assets/images/news.jpg', 
                                   image: newsModelList[index].newsImg,
                                   fit: BoxFit.cover, 
                                 
                                   imageErrorBuilder: (context, error, stackTrace) {
                                    
                                     return Image.asset(
                                       'assets/images/news.jpg', // Replace with your error placeholder image asset path
                                       fit: BoxFit.cover,
                                  
                                     );
                                   },
                                 )
                              ),
                               Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(colors: [
                                        Colors.black12.withOpacity(0),
                                        Colors.black
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                      )
                                    ), 
                                    padding: const EdgeInsets.fromLTRB(15,15,10,8),
                                    child:  Column( 
                                    children:[
                                    Text(
                                       newsModelList[index].newsHead,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                 
                                ] 
                               ))),
                            ],
                          ),
                        ));
                  }),

                Container(
                      // Set a specific height to constrain the button
                     margin:const EdgeInsets.fromLTRB(0, 5, 0, 10),

                     child: ElevatedButton(
                      
                       onPressed: () {
                         // Button's onPressed logic
                       },
                         style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Set the background color here
                         ),
                        child:const Text('Show More',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 18)),
                     ),
                   )
          ])),
     ),
    );
  }
}