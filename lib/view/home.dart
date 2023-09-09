import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_app/model/newsModel.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_app/view/category.dart';




class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyHome> {


    var cityName = ["Bankok", "Delhi", "Asia", "London", "USA", "China"];
    final random = Random();
    //var city = cityName[random.nextInt(cityName.length)];
  
    List<String> navbarItem = [
      "Top News",
      "Business",
      "Entertainment",
      "Sports",
      "Technology",
      "Health"
    ];

   
     bool isLoading = true;
      List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
      List<NewsQueryModel> newsCountry = <NewsQueryModel>[];

  @override
  void initState() {
    super.initState();
    getNews();
    getNewsByCountry();
  }

  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=43031493986f4ecabe0c218c63472343";
    
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
          isLoading = false;
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
  
   Future<void> getNewsByCountry() async {
    String url = "https://newsapi.org/v2/top-headlines?country=in&category=general&apiKey=43031493986f4ecabe0c218c63472343";
    
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final articles = jsonData["articles"] as List<dynamic>;

        setState(() {
          newsCountry.clear(); // Clear the list before adding new data

          for (var element in articles) {
            final newsQueryModel = NewsQueryModel.fromJson(element);
            newsCountry.add(newsQueryModel);
          }
          isLoading = false;
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
        title: const Text("News-Ley"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 163, 214, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => {},
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                      child: const Icon(
                        Icons.search,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: SearchController(),
                      textInputAction: TextInputAction.search,
                      decoration: const  InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search City for News"),
                    ),
                  )
                ],
              ),
            ),

            //Navbar Creation ...

            Container(
              height: 50,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: navbarItem.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => {
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>Category(query: navbarItem[index]))),
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            navbarItem[index],
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),

            Container(  
             
             margin: const EdgeInsets.symmetric(vertical: 15),
             child:isLoading ?Center(child:CircularProgressIndicator()):CarouselSlider  (
              options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true),
              items: newsCountry.map((instance) {
                 
                return Builder(
                  builder: (BuildContext context) {
                    
                    return Container(
                    
                      child: Card(
                         shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                         ),
                        child: Stack(
                          
                          children: [
                           
                           ClipRRect(
                                   borderRadius: BorderRadius.circular(10),
                                   child: CachedNetworkImage(
                                     placeholder: (context, url) => Image.asset(
                                       'assets/images/news.jpg', // Placeholder image asset path
                                       fit: BoxFit.cover,
                                     ),
                                     imageUrl: instance.newsImg,
                                     fit: BoxFit.cover,
                                     
                                     errorWidget: (context, url, error) => Image.asset(
                                       'assets/images/news.jpg', // Error placeholder image asset path
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                 ),
                             Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                   decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                       begin: Alignment.topCenter,
                                       end: Alignment.bottomCenter,
                                        colors: [Colors.greenAccent.withOpacity(0),
                                                  Colors.green
                                               ],
                                      
                                    )
                                   ),
                                  child: Container(
                                    padding: const  EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                    child:  Text(instance.newsHead,style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),), 
                             ))),
                          ],
                        ) 
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),

            Container(
              
              child : Column(
              children :[ 

                Container(
                 margin: const EdgeInsets.fromLTRB(15, 25, 0, 0),
                  child : const Row(
                  
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                                     
                            Text  ("Latest News Updates",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black)), 
                  ],
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
          ],
        ),
      ),
    );
  }

  final List items = [
    Colors.orange,
    Colors.black,
    Colors.blueAccent,
    Colors.red,
    Colors.green
  ];
}
