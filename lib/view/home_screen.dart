import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:worldapp/view/details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget
{
  final Firestore firestore;
  HomePage({this.firestore});
  @override
  State<StatefulWidget> createState() => new HomePageState();
}

class HomePageState extends State<HomePage>
{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Container(
      height: height * 0.9,
      child: Column(
        children: <Widget>[
          _buildHeader(),
          _listBody()
        ],
      ),
    );
  }

  Widget _buildHeader()
  {
    double height = MediaQuery.of(context).size.height * 0.9;
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      height: height / 2.5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(260, 25),
              bottomRight: Radius.elliptical(260, 25)
          ),
          border: Border.all(color: Colors.grey, width: 1.3),
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 9,
            ),
            new BoxShadow(
              color: Colors.white,
            ),
          ]
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(""),
              IconButton(
                  icon: Icon(Icons.notifications_none, size: 30.0,color: Colors.black,),
                  onPressed: (){print(height);}
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "World Tour",
                  style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: "SF-Pro-Text",
                      fontWeight: FontWeight.w900
                  ),
                ),
              )
            ],
          ),
          Container(
            height: height > 600 ? 80.0 : 65.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: icons.length,
                      itemBuilder: (context, index)
                      {
                        return new Padding(
                          padding: EdgeInsets.only(left: 10, right: 6.0),
                          child: GestureDetector(
                            child: Image.asset(icons[index]),
                          ),
                        );
                      }
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listBody()
  {
    double height = MediaQuery.of(context).size.height * 0.9;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      height: height * 3 / 5,
      child: ListView(
        padding: EdgeInsets.only(top: 10.0),
        children: <Widget>[
          _buildBody(),
          _buildMostViewed(),
          _buildListMostViewed()
        ],
      ),
    );
  }

  Widget _buildBody()
  {
    return new Container(
      height: 186,
      child: CarouselSlider(
          height: 166,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
          autoPlay: true,
          enlargeCenterPage: true,
          pauseAutoPlayOnTouch: Duration(seconds: 3),
          items: images.map((i){
            return Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    child: Image.asset(
                      i,
                      fit: BoxFit.cover,
                      width: 1000.0,
                    ),
                  ),
                ],
              ),
            );
          }).toList()
      ),
    );
  }

  Widget _buildMostViewed()
  {
    return new Container(
      padding: EdgeInsets.only(left: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Most Viewed",
                style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "View All",
                  style: TextStyle(
                      color: Colors.blue[900]
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListMostViewed()
  {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      height: 190,
      child: StreamBuilder(
          stream: Firestore.instance.collection('mostviewed').snapshots(),
          builder: (context, snapshot)
          {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(),);
            return ListView.builder(
              padding: EdgeInsets.only(right: 15.0),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index)
                {
                  return Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () =>
                          {
                          print(snapshot.data.documents[index]['listImage'].length),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new DetailsPage(snapshot: snapshot.data.documents[index],)
                              )
                          )
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/gif/loading.gif",
                              image: snapshot.data.documents[index]["imageAvatar"],
                              width: 135,
                              height: 184,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16.0,
                          left: 8.0,
                          child: Text(
                            snapshot.data.documents[index]["name"],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (settings.isInitialRoute)
      return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}

List<String> images = [
  "assets/imageHeader/london.jpg",
  "assets/imageHeader/newyork.jpg",
  "assets/imageHeader/paris.jpg",
  "assets/imageHeader/sydney.jpg"
];

List<String> icons = [
  "assets/icons/100.png",
  "assets/icons/200.png",
  "assets/icons/300.png",
  "assets/icons/400.png",
  "assets/icons/500.png",
];

