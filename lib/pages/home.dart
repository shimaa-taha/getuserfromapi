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
    futureUsers = fetchUsers(1); // Fetch the first page
  }

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
                        width: screenWidth * 0.15, // Adjust image size
                        height: screenHeight * 0.15,
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                      onTap: () {
                        print("shooooooooooooooka${user.id}");
                        _showUserDetailsPopup(context,user,screenWidth,screenHeight);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => UserDetailsPage(userId: user.id),
                        //   ),
                        // );
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

  Widget _buildShimmerLoading(double screenWidth,double hight) {
    return ListView.builder(
      itemCount: 6, // Number of shimmer items
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: Container(
              width: screenWidth * 0.15, // Adjust placeholder size
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