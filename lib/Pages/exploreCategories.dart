import 'package:catcine_es/Model/category.dart';
import 'package:catcine_es/Pages/categoryPage.dart';
import 'package:catcine_es/Pages/userProfile.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'createCategory.dart';
import 'exploreMedia.dart';
import 'homePage.dart';

class ExploreCategories extends StatefulWidget {
  const ExploreCategories({Key? key}) : super(key: key);

  @override
  State<ExploreCategories> createState() => _ExploreCategoriesState();
}

class _ExploreCategoriesState extends State<ExploreCategories> {

  List<Category> displayList = [];

  updateList(String title) async{

    setState(() {
      displayList = allLocalCats.values.where((element) => element.title.toLowerCase().contains(title.toLowerCase()) ||
          element.title.toUpperCase().contains(title.toUpperCase())).toList();
    });
  }

  rowCounter() {
    if (displayList.isEmpty) {
      return 0;
    }
    else if (displayList.length%2==1) {
      return (displayList.length ~/ 2) + 1;
    }
    else {
      return displayList.length ~/ 2;
    }
  }

  getTrimmedName(Category cat) {
    if (cat.title.length > 15) {
      return '${cat.title.substring(0, 15)}...';
    }
    return cat.title;
  }

  getPosterURL(Category cat,var i){

    if (isCatMediaEmpty(cat) || cat.catMedia.length < 3){
      return const AssetImage('images/catIcon.png');
    } else if (cat.catMedia[i].coverUrl != '') {
      return NetworkImage(cat.catMedia[i].coverUrl);
    }
    return const AssetImage('images/catIcon.png');
  }

  isCatMediaEmpty(Category cat) {
    if (cat.catMedia == []){
      return true;
    }
    return false;
  }

  boxDecorator(var i) {
    if (mediaCat.isEmpty){
      return const BoxDecoration();
    }
    if (i < mediaCat.length) {
      return BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ]
      );
    }
    else {
      return const BoxDecoration();
    }
  }

  drawSecondElement(int index) {
    if (index >= displayList.length) {
      return Column();
    }
    else {
      return Column(
          children: [
            RawMaterialButton(
              onPressed: () {
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                    return CategoryPage(category: displayList[index]);
                    },
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                );
               },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  color: const Color(0xFFD9D9D9),
                  width: (width/11) * 4.30,
                  height: ((width/11) * 4.30) * 1.3,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: (MediaQuery.of(context).size.width/5.9) * 1.8,
                        width: MediaQuery.of(context).size.width/1.62,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              left: 67,
                              bottom: 24,
                              child: Container(
                                decoration: boxDecorator(2),
                                child: Image(image: getPosterURL(displayList[index], 2),
                                  height: (width/5.9) * 1.3,
                                  width: width/5.9,
                                  colorBlendMode: BlendMode.screen,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 47,
                              bottom: 12,
                              child: Container(
                                decoration: boxDecorator(1),
                                child: Image(image: getPosterURL(displayList[index], 1),
                                  height: (width/5.9) * 1.3,
                                  width: width/5.9,
                                  colorBlendMode: BlendMode.screen,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 27,
                              bottom: 0,
                              child: Container(
                                decoration: boxDecorator(0),
                                child: Image(image: getPosterURL(displayList[index], 0),
                                  height: (width/5.9) * 1.3,
                                  width: width/5.9,
                                  colorBlendMode: BlendMode.screen,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: height/78.86),

                      Text(
                        getTrimmedName(displayList[index]),
                        style: const TextStyle(
                            color: Color(0xFF393D5A),
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: height/86.74,),
          ]
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff393d5a),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            SizedBox(height: height/13.35,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: width/30),
                  const Text(
                    "Find Categories",
                    style: TextStyle(
                      color:Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
            ),

            SizedBox(height: height/43.37),

            TextField(
              onChanged: (title) => updateList(title),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xffcccede),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search ...",
                prefixIcon: const Icon(Icons.search),
              ),
            ),

            SizedBox(height: height/39.43,),

            const Text(
              "Recommended For You",
              style: TextStyle(
                color:Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: height/57.82,),

            const Text(
              "Explore your recommended categories based on the ones you've liked in the past",
              style: TextStyle(
                color:Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: height/57.82,),

            Expanded(
              child: DraggableScrollableActuator(
                child: ListView.builder(
                  itemCount: rowCounter(),
                  itemBuilder: (context, index) => ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: width/51.43),
                    title: Row(
                        children: [
                          Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {
                                     Navigator.push(context, PageRouteBuilder(
                                       pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                                         return CategoryPage(category: displayList[index]);
                                       },
                                       transitionDuration: Duration.zero,
                                       reverseTransitionDuration: Duration.zero,
                                     ),
                                     );
                                   },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Container(
                                      color: const Color(0xFFD9D9D9),
                                      width: (width/11) * 4.30,
                                      height: ((width/11) * 4.30) * 1.3,
                                      child: Column(
                                        children: [
                                          SizedBox(height: height/43.37),

                                          SizedBox(
                                            height: (width/5.9) * 1.8,
                                            width: width/1.62,
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Positioned(
                                                  left: 67,
                                                  bottom: 24,
                                                  child: Container(
                                                    decoration: boxDecorator(2),
                                                    child: Image(image: getPosterURL(displayList[index], 2),
                                                      height: (width/5.9) * 1.3,
                                                      width: width/5.9,
                                                      colorBlendMode: BlendMode.screen,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 47,
                                                  bottom: 12,
                                                  child: Container(
                                                    decoration: boxDecorator(1),
                                                    child: Image(image: getPosterURL(displayList[index], 1),
                                                      height: (width/5.9) * 1.3,
                                                      width: width/5.9,
                                                      colorBlendMode: BlendMode.screen,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 27,
                                                  bottom: 0,
                                                  child: Container(
                                                    decoration: boxDecorator(0),
                                                    child: Image(image: getPosterURL(displayList[index], 0),
                                                      height: (width/5.9) * 1.3,
                                                      width: width/5.9,
                                                      colorBlendMode: BlendMode.screen,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: height/78.86),
                                          Text(
                                            getTrimmedName(displayList[index]),
                                            style: const TextStyle(
                                                color: Color(0xFF393D5A),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height/86.75,),
                              ]
                          ),
                          SizedBox(width: width/15,),
                          drawSecondElement((index * 2) + 1),
                        ]
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: const Color(0xCACBCBD2),
        child: IconTheme(
          data: const IconThemeData(color: Color(0xCB6D706B)),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                    pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                      return const Home();
                    },
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                    pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                      return const Profile();
                    },
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
              SizedBox(
                height: 60,
                child: IconButton(
                  iconSize: 60,
                  icon: Image.asset('images/catIcon.png'),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                        return const CreateCategoryScreen();
                      },
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                          (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                    pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
                      return const ExploreMedia();
                    },
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.category),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
