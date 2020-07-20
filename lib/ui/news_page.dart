import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/network/category_model.dart';
import 'package:news_app/network/network.dart';
import 'package:news_app/network/news_model.dart';
import 'package:news_app/ui/category_news.dart';
import 'package:news_app/ui/webBlog.dart';
import 'package:news_app/util/category_info.dart';


FirebaseUser loggedInUser;
class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  GoogleSignIn googleSignIn = new GoogleSignIn();

  final _auth = FirebaseAuth.instance;
  List<CategoryModel> category = new List<CategoryModel>();
  Future<NewsModel> newsData;
  @override
  void initState() {
    super.initState();
    newsData = Network().getNews();
    category = getCategories();
    getCurrentUser();
//    newsData.then((news) => print(news.articles[0].content));
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
           Padding(
             padding:  EdgeInsets.only(right:16.0),
             child: GestureDetector(
                 onTap: (){
                   _auth.signOut();
                   googleSignIn.disconnect();
                   Navigator.pop(context);

                 },
                 child: Center(child: Text("Sign Out",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600),))),
           )
          ],
          elevation: 5.0,
          backgroundColor: Colors.black,
          title: Center(
              child: Text(
            "The Scoop",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontFamily: "Pacifico",
              fontWeight: FontWeight.w600,
              letterSpacing: 1.3
            ),
          )),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 130,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: category.length,
                  itemBuilder: (context, int index) {
                    return TopView(
                      imageUrl: category[index].imageURL,
                      categoryName: category[index].categoryName,
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0),
              child: Container(
                child: FutureBuilder<NewsModel>(
                    future: newsData,
                    builder: (BuildContext context,
                        AsyncSnapshot<NewsModel> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.articles.length,
                            itemBuilder: (context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WebBlog(snapshot
                                              .data.articles[index].url)));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.3,
                                  child: Column(
                                    children: <Widget>[
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: snapshot.data.articles[index]
                                                      .urlToImage !=
                                                  null
                                              ? CachedNetworkImage(
                                                imageUrl: snapshot
                                                    .data
                                                    .articles[index]
                                                    .urlToImage,
                                              )
                                              : Container(
                                                  child: Image.asset(
                                                      'assets/noimage.png'),
                                                )),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      Text(
                                        snapshot.data.articles[index].title,
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      Divider(
                                        height: 2.0,
                                        color: Colors.grey,
                                        thickness: 2.0,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          snapshot.data.articles[index]
                                                  .description ??
                                              "Description is not available",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6.0,
                                      ),
                                      Divider(
                                        height: 2.0,
                                        color: Colors.grey,
                                        thickness: 2.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Content Source: ${snapshot.data.articles[index].source.name}",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue[600]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            )
          ],
        ));
  }
}

class TopView extends StatelessWidget {
  final String imageUrl, categoryName;

  const TopView({Key key, this.imageUrl, this.categoryName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(category: categoryName.toLowerCase(),)));
      },
      child: Container(
        padding: EdgeInsets.only(left: 15.0, top: 10.0),
        child: Stack(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 130,
              width: 180,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 130,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black26,
            ),
            child: Center(
              child: Text(
                categoryName,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
