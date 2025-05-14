import 'package:auth_mappers/constants/colors.dart';
import 'package:auth_mappers/data/models/place_suggestion.dart';
import 'package:flutter/material.dart';

class PalceItem extends StatelessWidget {
  final PlaceSuggestion place;
  const PalceItem({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    var subtitle = place.description.replaceAll(
      place.description.split(',')[0],
      '',
    );
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              child: Icon(Icons.place, color: Colors.blue),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.lightBlue,
              ),
            ),
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${place.description.split(',')[0]}\n',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: subtitle.substring(2),
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
