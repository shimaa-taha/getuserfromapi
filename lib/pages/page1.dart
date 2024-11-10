import 'package:flutter/material.dart';
import 'package:task1/pages/page2_userdetails.dart';
import 'package:shimmer/shimmer.dart';
import '../model/getusermodel.dart';
import '../repo/getuserrepo.dart';

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

    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.1,
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: FutureBuilder<List<User>>(
            future: futureUsers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildShimmerLoading(MediaQuery.of(context).size.width);
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
                        width: MediaQuery.of(context).size.width * 0.15, // Adjust image size
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailsPage(userId: user.id),
                          ),
                        );
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

  Widget _buildShimmerLoading(double screenWidth) {
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
              height: 16,
              width: double.infinity,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 14,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

