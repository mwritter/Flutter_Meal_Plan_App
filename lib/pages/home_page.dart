import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal_plan/models/user_model.dart';
import '../models/meal.dart';
import './meal_detail_page.dart';
import './shopping_list.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  HomePage(this.user);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [];
  Widget _buildLocalUserInfo() {
    return Column(
      children: <Widget>[
        Text(widget.user.image),
        Text(widget.user.email),
        Text(widget.user.mealPlan.toString()),
        Text(widget.user.uid),
      ],
    );
  }

// Not using but we may need later as well as the method below
  Widget _buildNetworkUserInfo() {
    return StreamBuilder(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Loading Please Wait"),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }

        return Text("No Data");
      },
    );
  }

// Not using, But this is what we'll use to get ref to other data later
  Future _buildUserInfo() async {
    var user = await FirebaseAuth.instance.currentUser();
    var userQuery = Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: user.uid)
        .limit(1);
    userQuery.getDocuments().then((data) {
      if (data.documents.length > 0) {
        setState(() {
          //email = data.documents[0].data['email'];
        });
      } else {}
    });
  }

  Widget _buildMealDetails() {
    Meal meal = new Meal("Pizza", "Its so so good", 'food4.jpg');
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MealDetailPage(meal)));
      },
      child: Text("Meal Detail Page"),
    );
  }

  Widget _buildShoppingList() {
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ShoppingList()));
      },
      child: Text("Shopping List Page"),
    );
  }

  Widget _buildHeaderTitle() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        color: Color(0xFFEDE2C5),
      ),
      height: 250.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
            child: Text(
              "Hey",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 90.0,
                color: Color(0xFF356859),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 115.0, 0.0, 0.0),
            child: Text(
              "There",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 90.0,
                color: Color(0xFF356859),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserContainer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(20.0),
        title: Text(
          widget.user.email,
          style: TextStyle(
            color: Color(0xFF8A9098),
            fontSize: 25.0,
          ),
        ),
        leading: Container(
          height: 75.0,
          width: 75.0,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('${widget.user.image}'),
              )),
        ),
      ),
    );
  }

  Widget _buildMyPlanContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0.0, 2.0),
              blurRadius: 1.0),
        ],
      ),
      margin:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 45.0, bottom: 100.0),
      height: 130.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 20),
        child: Text(
          "My Plan",
          style: TextStyle(
              color: Color(0xFF8A9098),
              fontSize: 50.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void onTabButtonBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            fixedColor: Color(0xFF356859),
            onTap: onTabButtonBar,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  title: Text("Home")),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  title: Text("Shopping List")),
            ]),
        body: _currentIndex == 0
            ? Container(
                child: ListView(
                  children: <Widget>[
                    SafeArea(
                      child: _buildHeaderTitle(),
                    ),
                    _buildUserContainer(),
                    _buildMyPlanContainer()
                  ],
                ),
              )
            : ShoppingList());
  }
}
