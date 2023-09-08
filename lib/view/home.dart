import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';



class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {


    var cityName = ["Bankok", "Delhi", "Asia", "London", "USA", "China"];
    final random = Random();
    var city = cityName[random.nextInt(cityName.length)];
    List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
    List<String> navbarItem = [
      "TopNews",
      "Health",
      "Finance",
      "Cricket",
      "Devotion"
    ];

   
     Future<void> getNewsByQuery(String query) async {
   
      final url = Uri.parse("https://newsapi.org/v2/everything?q=tesla&from=2023-08-08&sortBy=publishedAt&apiKey=43031493986f4ecabe0c218c63472343");
      
      try {
      final response = await http.get(url);

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
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search $city for News"),
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
                        debugPrint(navbarItem[index]),
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

            child: CarouselSlider(
              options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true),
              items: items.map((i) {
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
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset("assets/images/news.jpg",fit: BoxFit.fitHeight,height: double.infinity,),
                             ),
                             Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Container(
                                   decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
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
                                    child: const Text("Current News HeadLine",style:TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),), 
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
                                child: Image.network(newsModelList[index].newsImg),
                              ),
                               Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
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
