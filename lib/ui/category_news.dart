import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/network/network.dart';
import 'package:news_app/network/news_model.dart';
import 'package:news_app/ui/webBlog.dart';


class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  Future<NewsModel> categoryNews;
  @override
  void initState() {
    super.initState();
    categoryNews = CategoryNetwork().getCategoryNews(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("${widget.category.toUpperCase()} SECTION",style: TextStyle(fontFamily: "VarelaRound",fontSize: 18.0),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0),
        child: Container(
          child: FutureBuilder<NewsModel>(
              future: categoryNews,
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
                                SizedBox(height: 10,),
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
      ),
    );
  }
}
