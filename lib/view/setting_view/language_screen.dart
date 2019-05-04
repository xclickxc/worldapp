import 'package:flutter/material.dart';
import 'package:worldapp/data/list_language.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LanguageScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new LanguageScreenState();
}

class LanguageScreenState extends State<LanguageScreen>
{
  TextEditingController controller = new TextEditingController();
  List<String> _languageSearch = [];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildBody()
          ],
        ),
      ),
    );
  }

  Widget _buildHeader()
  {
    double maxHeight = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height * 0.75;
    return Container(
      padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
      height: maxHeight > 700 ? height / 3 : height / 6,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: (){
                    print(maxHeight);
                    Navigator.pop(context);
                  }
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Language",
                  style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.w700
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Choose your Preffered \nLanguage",
                style: TextStyle(
                  fontSize: 30.0
                ),
              ),
              Icon(Icons.translate, size: 80.0,color: Colors.blue,)
            ],
          )
        ],
      ),
    );
  }


  Widget _buildBody()
  {
    double maxHeight = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: EdgeInsets.only(left: 15.0),
        height: maxHeight > 700 ? height * 0.46: height / 0.33,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Image.asset("assets/iconsflag/icon_england_flag.png"),
                    title: Text("English", style: TextStyle(fontWeight: FontWeight.w600),),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    leading: Image.asset("assets/iconsflag/icon_vietnam_flag.png"),
                    title: Text("Vietnamese", style: TextStyle(fontWeight: FontWeight.w600)),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    leading: Image.asset("assets/iconsflag/icon_china_flag.png"),
                    title: Text("Chinese", style: TextStyle(fontWeight: FontWeight.w600)),
                    trailing: Icon(Icons.arrow_forward),
                  )
                ],
              )
            )
          ],
        )
    );
  }

  onSearchTextChanged(String text) async
  {
    _languageSearch.clear();
    if(text.isEmpty)
    {
      setState(() {

      });
      return;
    }
    language.forEach((languageSearch) {
      if (languageSearch.toLowerCase().contains(text.toLowerCase()) || languageSearch.contains(text.toLowerCase()))
      {
        _languageSearch.add(languageSearch);
      }
    });
    setState(() {});
  }

}