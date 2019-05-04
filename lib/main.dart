import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:worldapp/view/search_screen.dart';
import 'package:worldapp/view/home_screen.dart';
import 'package:worldapp/view/profile_view/state_widget.dart';
import 'package:worldapp/view/profile_view/profile_user.dart';
import 'package:worldapp/home_state.dart';

void main() {
  StateWidget stateWidget = new StateWidget(child: new AppStart());
  runApp(stateWidget);
}

class MainWidget extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => new MainWidgetState();
}

class MainWidgetState extends State<MainWidget>
{
  int current_page = 0;
  final PageStorageBucket bucket = new PageStorageBucket();
  Widget currentscreen = HomePage();
  final List<Widget> screens = [HomePage(), SearchScreen(), ProfileUser()];

  Future<bool> _onBackPressed()
  {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Do you want to exit the app?"),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("No")
            ),
            FlatButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Yes")
            )
          ],
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: new Scaffold(
          body: PageStorage(bucket: bucket, child: currentscreen),
          bottomNavigationBar: _buildBottomBar(),
        ),
        onWillPop: _onBackPressed
    );
  }

  Widget _buildBottomBar()
  {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.1,
      child: BottomNavigationBar(
        iconSize: height > 600 ? 35.0 : 30,
        currentIndex: current_page,
        onTap: (i) {
          print(height);
          setState(() {
            current_page = i;
            currentscreen = screens[i];
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home", style: TextStyle(
                  fontSize: height > 600 ? 14.0 : 10.0),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Search", style: TextStyle(
                  fontSize: height > 600 ? 14.0 : 10.0),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("My Profile", style: TextStyle(
                  fontSize: height > 600 ? 14.0 : 10.0),
              )
          )
        ],
        fixedColor: Colors.deepPurple,
      ),
    );
  }
}
