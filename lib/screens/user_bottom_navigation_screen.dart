import 'package:flutter/material.dart';
import 'package:harnishsalon/common/color_constants.dart';
import 'package:harnishsalon/screens/user_dashboard_screen.dart';
import 'package:harnishsalon/screens/user_offers_screen.dart';
import 'package:harnishsalon/screens/user_profile_screen.dart';

class UserBottomNavigationScreen extends StatefulWidget {
  UserBottomNavigationScreen({
    Key key,
  }) : super(key: key);

  @override
  _UserBottomNavigationScreenState createState() =>
      _UserBottomNavigationScreenState();
}

class _UserBottomNavigationScreenState
    extends State<UserBottomNavigationScreen> {
  int _index = 0;
  double height, width;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _getWidget(_index),
    );
  }

  Widget _getWidget(index) {
    switch (index) {
      case 0:
        {
          return UserDashBoardScreen();
        }
        break;

      case 1:
        {
          return UserOffersScreen();
        }
        break;
      case 2:
        {
          return UserProfileScreen();
        }
        break;
      default:
        return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              ExactAssetImage(
                "assets/images/Home.png",
              ),
              size: 22,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              ExactAssetImage(
                "assets/images/Discount.png",
              ),
              size: 22,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              ExactAssetImage(
                "assets/images/Profile.png",
              ),
              size: 22,
            ),
            label: "",
          )
        ],
        currentIndex: _index,
        selectedItemColor: ColorConstants.kBlackColor,
        unselectedItemColor: ColorConstants.kGreyColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
