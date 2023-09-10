import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
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
    getNewsByWord(widget.query);
  }

  Future<void> getNewsByQuery(String query) async {
    String url;
    if (query == "Top News") {
      url = "https://newsapi.org/v2/top-headlines?country=in&category=general&apiKey=43031493986f4ecabe0c218c63472343";
    }
    else 
    {
      url = url = "https://newsapi.org/v2/top-headlines?country=in&category=$query&apiKey=43031493986f4ecabe0c218c63472343";
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
  
  Future<void> getNewsByWord(String query) async {
    String url;
    if (query == "Top News") {
      url = "https://newsapi.org/v2/top-headlines?country=in&category=general&apiKey=43031493986f4ecabe0c218c63472343";
    }
    else 
    {
      url = url = "https://newsapi.org/v2/top-headlines?country=in&category=$query&apiKey=43031493986f4ecabe0c218c63472343";
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
                         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                         child: Card(
                           shape: RoundedRectangleBorder(
                             side: const BorderSide(
                               color: Colors.greenAccent,
                             ),
                             borderRadius: BorderRadius.circular(20.0),
                           ),
                           elevation: 1.0,
                           child: GestureDetector(
                              onTap: () async {
    // Handle tap action here to open the URL in a web browser
                                    final url = Uri.parse(newsModelList[index].newsUrl);
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                    },
                             child: Stack(
                               children: [
                                 ClipRRect(
                                   borderRadius: BorderRadius.circular(20.0),
                                   child: FadeInImage.assetNetwork(
                                     placeholder: 'assets/images/news.jpg',
                                     image: newsModelList[index].newsImg,
                                     fit: BoxFit.cover,
                                     imageErrorBuilder: (context, error, stackTrace) {
                                       return Image.asset(
                                         'assets/images/news.jpg', // Replace with your error placeholder image asset path
                                         fit: BoxFit.cover,
                                       );
                                     },
                                   ),
                                 ),
                                 Positioned(
                                   left: 0,
                                   right: 0,
                                   bottom: 0,
                                   child: Container(
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(20),
                                       gradient: LinearGradient(
                                         colors: [
                                           Colors.black12.withOpacity(0),
                                           Colors.black
                                         ],
                                         begin: Alignment.topCenter,
                                         end: Alignment.bottomCenter,
                                       ),
                                     ),
                                     padding: const EdgeInsets.fromLTRB(15, 15, 10, 8),
                                     child: Column(
                                       children: [
                                         Text(
                                           newsModelList[index].newsHead,
                                           style: const TextStyle(
                                             fontWeight: FontWeight.bold,
                                             color: Colors.white,
                                             fontSize: 14,
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       );
                     },
                   ),

          
          ])),
     ),
    );
  }
}