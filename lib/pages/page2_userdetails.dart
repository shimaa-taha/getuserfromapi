import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/getusermodel.dart';
import '../model/supportmodel.dart';
import '../repo/getuserrepo.dart';

class UserDetailsPage extends StatefulWidget {
  final int userId;

  UserDetailsPage({required this.userId});

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late Future<UserDetails> futureUserDetails;

  @override
  void initState() {
    super.initState();
    futureUserDetails = fetchUserDetails(widget.userId);
  }
  final Uri url = Uri.parse('https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral');

  Future<void> _launchUrl() async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User  Details')),
      body: FutureBuilder<UserDetails>(
        future: futureUserDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('User  not found.'));
          } else {
            final userDetails = snapshot.data!;
            final user = userDetails.user;
            final support = userDetails.support;

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                      radius: 50,
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${user.firstName} ${user.lastName}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      user.email,
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 10),
                    Text(
                      support.text,
                      style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // Ensure the URL is not null before launching
                        if (support.url != null) {
                          _launchUrl();
                        } else {
                          // Handle the case where the URL is null
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No URL available')),
                          );
                        }
                      },
                      child: Text('Learn More'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}