import 'package:flutter/material.dart';

import '../../../app/routes/navigation_manager.dart';
import '../../../app/routes/route_constants.dart';
import '../../../customwidget/search_custom_widget.dart';


class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children:[
        SizedBox(
                    height: 16,
                  ),
              SearchCustomWidget(),

      ]
    )
    );
  }
}
