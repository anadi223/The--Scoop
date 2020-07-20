import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app/util/Utility.dart';

import 'news_model.dart';

class Network{

Future<NewsModel> getNews() async{

  final String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=${Util.appId}";

  final response = await get(Uri.encodeFull(url));
  if(response.statusCode == 200){
    return NewsModel.fromJson(jsonDecode(response.body));
  }
  else{
    print(response.statusCode);
  }
}
}

class CategoryNetwork{
  Future<NewsModel> getCategoryNews(String category) async{
    final String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${Util.appId}";
    final response = await get(Uri.encodeFull(url));
    if(response.statusCode==200){
      return NewsModel.fromJson(jsonDecode(response.body));
    }else{
      print(response.statusCode);
    }
  }

}