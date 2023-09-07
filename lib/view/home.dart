import 'dart:math';

import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    
    var city_name =["Bankok","Delhi","Asia","London","USA","China"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)]; 
    List<String> navbar_item =["TopNews","Health","Finance","Cricket","Devotion"];
 
    return  Scaffold(
        appBar: AppBar(
          title: Text("News-Ley"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 163, 214, 255),
        ),
       
        body: Column(
            children: [
             Container(
               
                padding: EdgeInsets.symmetric(horizontal:8.0),
                margin: EdgeInsets.symmetric(horizontal:24,vertical: 20),
                decoration: BoxDecoration(
             
                   color: Colors.transparent,
                  
                   ),
                child: Row(
                 children: [
                     GestureDetector(
                       onTap: ()=>{},
                       child:Container(child:Icon(Icons.search,color: Colors.lightBlue,),margin: EdgeInsets.fromLTRB(3, 0, 7, 0),),
                     ),
                     Expanded(
                      child: TextField(
                         controller: SearchController(),
                         textInputAction: TextInputAction.search,

                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search $city for News"
                          ),
                      ),
                      )
                  ],
                ) , 
              ),
             
              //Navbar Creation ...

              Container(
                height: 50,
                
              child:ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: navbar_item.length,
                itemBuilder:(context,index){
                return 
               InkWell(
                        onTap: ()=>{
                            print(navbar_item[index]),
                        },
                   child: Container(
                       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                       margin: EdgeInsets.symmetric(horizontal:5),
                       decoration:BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(25),
                       ) ,

                       child:Center(
                       child: Text(
                           navbar_item[index],
                           style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                           ),
                           ),
                           
                         ),
                    ),
                 );
                }

              ) ,
             )
              
            
            ],
        ),
    );
  }
}