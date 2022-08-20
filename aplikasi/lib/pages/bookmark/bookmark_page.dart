import 'package:flutter/material.dart';
import 'package:travelling_app/classes/user/bookmarked_travelling_place.dart';
import 'package:travelling_app/database/travelling_place_bookmark_db.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/templates/backable_app_bar.dart';
import 'package:travelling_app/templates/horizontal_item_view.dart';
import 'package:travelling_app/templates/information_widget.dart';

import '../../utils/context.dart';

class BookmarkPage extends StatefulWidget{
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookmarkState();

}

class _BookmarkState extends State<BookmarkPage>{
  late TravellingPlaceBookmarkDB travellingPlaceBookmarkDB;

  @override
  void initState() {
    super.initState();
    travellingPlaceBookmarkDB = TravellingPlaceBookmarkDB();
  }

  Widget _getBookmarkedItems(List<BookmarkedTravellingPlace> bookmarkedTravellingPlaces){
    double childAspectRatio = 0;
    if (ContextUtils.getScreenWidth(context) > 500){
      childAspectRatio = 1;
    }
    else{
      childAspectRatio = 3;
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 600,
        childAspectRatio: childAspectRatio,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: bookmarkedTravellingPlaces.length,
      itemBuilder: (BuildContext ctx, index){
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextButton(
            onPressed: (){
              Navigator.pushNamed(
                  context,
                  detailRouteName,
                  arguments: bookmarkedTravellingPlaces[index].travellingPlace
              );
            },
            child: HorizontalItemWidget(
              titleText: bookmarkedTravellingPlaces[index].travellingPlace.placeName,
              subtitleText: bookmarkedTravellingPlaces[index].travellingPlace.city,
              rating: bookmarkedTravellingPlaces[index].rating.toString(),
            ),
          ),
        );
      }
    );
  }

  Widget _getNoDataElement(){
    return const InformationWidget(
      iconData: Icons.star,
      information: "Anda belum melakukan bookmark tempat wisata sama sekali!"
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackableAppBar(
        appBarTitle: "Bookmark Page",
        onBackIconPressed: (){
          Navigator.pop(context);
        },
      ).getInstance(context),
      body: FutureBuilder(
        future: travellingPlaceBookmarkDB.getAllBookmarks(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return Text(
              snapshot.error.toString(),
            );
          }

          List<BookmarkedTravellingPlace> bookmarkTravellingPlaces = snapshot.data as List<BookmarkedTravellingPlace>;
          if (bookmarkTravellingPlaces.isEmpty){
            return _getNoDataElement();
          }
          return _getBookmarkedItems(bookmarkTravellingPlaces);
        },
      ),
    );
  }
}