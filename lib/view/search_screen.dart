import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:worldapp/utils/search_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget
{
  Firestore firestore;
  SearchScreen({this.firestore});
  @override
  State<StatefulWidget> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen>
{
  TextEditingController textSearchController = new TextEditingController();

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name'].contains(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Container(
        height: height,
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                _buildHeader(),
              ],
            ),
            _buildSearch(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader()
  {
    double height = MediaQuery.of(context).size.height;
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Colors.red, Colors.pink],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: height * 0.25,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.blueAccent
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          )
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.menu, color: Colors.white,),onPressed: (){},),
              IconButton(icon: Icon(Icons.location_on, color: Colors.white,),onPressed: (){},),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "SEARCH",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
//                  foreground: Paint()..shader = linearGradient
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSearch()
  {
    double height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: height * 0.21),
      height: height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1.0)
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: TextField(
                  onChanged: ((value){
                    initiateSearch(value);
                  }),
                  controller: textSearchController,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(FontAwesomeIcons.search,),
                    hintText: "Search by name, location, or anything.",
                    hintStyle: TextStyle(fontSize: 19.0),
                    border: InputBorder.none,
                    suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: _onClear),
                  ),
                  onEditingComplete: ()
                  {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                ),
              ),
            ),
          ),
          tempSearchStore.length == 0 ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Text(
              "What are you looking for today ?",
              style: TextStyle(fontSize: 25.0),
            ),
          ) :
          Expanded(
            child: ListView(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                primary: false,
                shrinkWrap: true,
                children: tempSearchStore.map((element) {
                  return _buildAny(element);
                }).toList()),
          )
        ],
      ),
    );
  }

  Widget _buildAny(data)
  {
    double rating = double.parse(data['stars_rate']);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              print(data['name']);
              Navigator.push(context, MaterialPageRoute(builder: (context) => new DetailsPage(snapshot: data,)));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 200.0,
              child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                data['imageAvatar'],
                              ),
                              fit: BoxFit.cover
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0))
                      ),
                      height: 200.0,
                    ),
                    Positioned(
                      top: 60,
                      left: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            data['name'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0
                            ),
                          ),
                          StarRating(
                            rating: rating,
                            color: Colors.amber,
                            size: 25.0,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15.0),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.pink,
                                      Colors.deepPurple
                                    ]
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                            height: 40,
                            width: 120,
                            child: Center(
                              child: InkWell(
                                child: Text(
                                  "READ MORE",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]
              ),
            ),
          )
        ],
      ),
    );
  }

  _onClear()
  {
    setState(() {
      textSearchController.clear();
      tempSearchStore.clear();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textSearchController.dispose();
    super.dispose();
  }

}

