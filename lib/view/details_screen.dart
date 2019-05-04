import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating/flutter_rating.dart';

class DetailsPage extends StatefulWidget
{
  dynamic snapshot;
  DetailsPage({Key key, this.snapshot}) : super(key: key);
  bool isPress = false;
  var newVal = true;
  @override
  State<StatefulWidget> createState() => new DetailsPageState();
}

class DetailsPageState extends State<DetailsPage>
{
  int _current = 0;

  @override
  void initState(){
    super.initState();
  }


  // Define a varialbe for storing click state

  _pressed()
  {
    widget.newVal;
    if (widget.isPress)
    {
      widget.newVal = false;
      print("Dislike");
    }
    else
    {
      widget.newVal = true;
      print("Like");
    }
    setState(() {
      widget.isPress = widget.newVal;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            _buildHeaderImage(),
            _buildNameLocation(),
            _buildBody()
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage()
  {
    return Stack(
      children: <Widget>[
        _buildListImage(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                  onPressed: () => {Navigator.pop(context)}
              ),
              IconButton(
                color: widget.isPress ? Colors.pink : Colors.white,
                icon: Icon(widget.isPress ? Icons.favorite : Icons.favorite_border),
                onPressed: _pressed,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildListImage()
  {
    double height = MediaQuery.of(context).size.height;
    List<dynamic> imageList = widget.snapshot['listImage'].toList();
    return Stack(
      children: <Widget>[
        CarouselSlider(
            height: height * 0.4,
            onPageChanged: (index)
            {
              setState(() {
                _current = index;
              });
            },
            viewportFraction: 1.0,
            aspectRatio: 2.0,
            autoPlay: true,
            enlargeCenterPage: false,
            items: imageList.map((i)
            {
              return Builder(
                  builder: (BuildContext context)
                  {
                    return Container(
                      child: ClipOval(
                        clipper: OvalTopBorderClipper(),
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/gif/loading.gif",
                          image: i,
                          fit: BoxFit.cover,
                          width: 1000.0,
                          height: 500,
                        ),
                      ),
                    );
                  }
              );
            }).toList()
        ),
        Padding(
            padding: EdgeInsets.only(top: height * 0.4 - 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(
                imageList,
                    (index, url) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index
                            ? Color.fromRGBO(255, 255, 255, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4)),
                  );
                },
              ),
            )
        )
      ],
    );
  }

  Widget _buildNameLocation()
  {
    double rating = double.parse(widget.snapshot['stars_rate']);
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height > 700 ? 100 : 70,
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  widget.snapshot['name'],
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: "SF-Pro-Text",
                    fontWeight: FontWeight.w800,
                    color: Colors.deepPurple[900],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              GestureDetector(
                onTap: (){print(height);},
                child: Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: <Widget>[
                      StarRating(
                        color: Colors.amber,
                        rating: rating,
                        size: 25.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
              child: Text(
                "Direction",
                style: TextStyle(
                    color: Colors.white
                ),
              ),
              onPressed: null,
              disabledColor: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody()
  {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height > 600 ? height * 0.45 : height * 0.4,
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Text(
            "Here are some interesting information about ${widget.snapshot['name']}",
            softWrap: true,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              widget.snapshot['describe'],
              style: TextStyle(
                fontFamily: "SF-Pro-Text",
                fontSize: 15.0,
              ),
            ),
          )
        ],
      ),
    );
  }

}

class OvalTopBorderClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final Rect rect = Rect.fromLTWH(0.0-size.width/2, 0.0-size.height, size.width * 2, size.height * 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

List<T> map<T>(List list, Function handler)
{
  List<T> result = [];
  for (var i = 0; i < list.length; i++)
  {
    result.add(handler(i, list[i]));
  }
  return result;
}
