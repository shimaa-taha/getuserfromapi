import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../model/getUserModel.dart';
import '../repo/getUserRepository.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers(1);
  }
///builds a user list interface with responsive UI, displaying a shimmer loading effect while fetching data. It shows user details in a list format with avatar, name, and email. On tapping a user, it triggers a popup showing detailed information. The layout adapts to screen size using MediaQuery.
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('User List',style: TextStyle(fontSize: screenWidth*0.05,color:Colors.black,fontWeight: FontWeight.w600,fontFamily: "Poppins",))),
      body: Center(
        child: Container(
          width: screenWidth/1.1,
          padding: EdgeInsets.symmetric(horizontal: screenWidth*0.001),
          child: FutureBuilder<List<User>>(
            future: futureUsers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildShimmerLoading(screenWidth,screenHeight);
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No users found.'));
              } else {
                final users = snapshot.data!;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return ListTile(
                      leading: Image.network(
                        user.avatar,
                        width: screenWidth * 0.15,
                        height: screenHeight * 0.15,
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                      onTap: () {
                        print("shooooooooooooooka${user.id}");
                        _showUserDetailsPopup(context,user,screenWidth,screenHeight);

                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
///creates a shimmer loading effect for a list interface. It builds 6 list items with gray shimmer animation using the Shimmer package. Each item contains a leading square container (15% of screen width) and two horizontal white bars as title and subtitle placeholders. The shimmer effect transitions between light and dark gray colors to simulate loading content.
  Widget _buildShimmerLoading(double screenWidth,double hight) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: Container(
              width: screenWidth * 0.15,
              height: screenWidth * 0.15,
              color: Colors.white,
            ),
            title: Container(
              height: hight*0.008,
              width: double.infinity,
              color: Colors.white,
            ),
            subtitle: Container(
              height: hight*0.008,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
///displays a popup dialog showing user details. It takes context, user data, and screen dimensions as parameters. The dialog includes:
/// User avatar image
/// Full name (first + last name)
/// Email address
/// Close button to dismiss the dialog
/// All text sizes are calculated dynamically based on screen width for responsive design.
  void _showUserDetailsPopup(BuildContext context, User user,double width,double hight) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('User Details',style: TextStyle(fontSize: width*0.04,color:Colors.black,fontWeight: FontWeight.w600,  fontFamily: "Poppins",),)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                    radius: width*0.09,
                  ),
                ),
                SizedBox(height: hight*0.007),
                Text(
                  '${user.firstName} ${user.lastName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width*0.04,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: hight*0.004),

                Text(
                  user.email,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize:  width*0.04,color:Colors.black,fontFamily: "Poppins",),
                ),
                SizedBox(height: hight*0.004),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close',  style: TextStyle(fontSize: width*0.04,color:Colors.black,fontFamily: "Poppins",),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}