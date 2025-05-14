import 'package:auth_mappers/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:auth_mappers/constants/colors.dart';
import 'package:auth_mappers/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  final PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
  MyDrawer({super.key});
  Widget _buildDrawerHeader() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6),
            color: Colors.blue[100],
          ),
          child: Image.asset('assets/images/image.png', fit: BoxFit.cover),
        ),
        Text(
          'Afraim Elkes Eleia',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          'User Name',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  //Second Way to HeadR
  Widget _buildDrawerHeaderTwo() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: Image.asset(
            'assets/images/image.png',
            fit: BoxFit.cover,
            width: 90,
            height: 90,
          ),
        ),
        Text(
          'Afraim Elkes Eleia',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          'User Name',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDrawerListItem({
    required IconData leadingIcon,
    required String title,
    Widget? trailing,
    void Function()? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(leadingIcon, color: color ?? MyColors.blue),
      title: Text(title),
      trailing: trailing ?? Icon(Icons.arrow_right, color: MyColors.blue),
      onTap: onTap,
    );
  }

  Widget _buildDrawerListItemsDivider() {
    return Divider(thickness: 1, indent: 18, endIndent: 24);
  }

  void _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  Widget _buildIocn(IconData icon, String url) {
    return InkWell(
      onTap: () => _launch(url),
      child: Icon(icon, color: MyColors.blue, size: 35),
    );
  }

  Widget _buildSocialMediaIcon() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16),
      child: Row(
        children: [
          _buildIocn(
            FontAwesomeIcons.facebook,
            'https://www.facebook.com/profile.php?id=100064001409362',
          ),
          const SizedBox(width: 20),
          _buildIocn(
            FontAwesomeIcons.youtube,
            'https://www.youtube.com/@vizmedia',
          ),
          const SizedBox(width: 20),
          _buildIocn(
            FontAwesomeIcons.telegram,
            'https://www.facebook.com/profile.php?id=100064001409362',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(color: Colors.blue[100]),
            child: DrawerHeader(child: _buildDrawerHeaderTwo()),
          ),
          _buildDrawerListItem(leadingIcon: Icons.person, title: 'My Profile'),
          _buildDrawerListItemsDivider(),
          _buildDrawerListItem(
            leadingIcon: Icons.history,
            title: 'Places history',
            onTap: () {},
          ),
          _buildDrawerListItemsDivider(),
          _buildDrawerListItem(leadingIcon: Icons.settings, title: 'Settings'),
          _buildDrawerListItemsDivider(),
          _buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
          _buildDrawerListItemsDivider(),
          BlocProvider<PhoneAuthCubit>(
            create: (context) => phoneAuthCubit,
            child: _buildDrawerListItem(
              leadingIcon: Icons.logout,
              title: 'Logout',
              color: Colors.red,
              trailing: SizedBox(),
              onTap: () async {
                await phoneAuthCubit.logout();
                Navigator.of(context).pushReplacementNamed(loginScreen);
              },
            ),
          ),
          const SizedBox(height: 100),
          ListTile(
            leading: Text(
              'Follow Us',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          _buildSocialMediaIcon(),
        ],
      ),
    );
  }
}
