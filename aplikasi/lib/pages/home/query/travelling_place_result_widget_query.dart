import 'package:flutter/material.dart';
import 'package:travelling_app/classes/travelling_place.dart';
import 'package:travelling_app/fetch-helpers/data-fetcher.dart';
import 'package:travelling_app/globals/route.dart';
import 'package:travelling_app/templates/circular_loading_element.dart';
import 'package:travelling_app/templates/horizontal_item_view.dart';
import 'package:travelling_app/templates/information_widget.dart';
import 'package:travelling_app/templates/rating_widget.dart';
import 'package:travelling_app/utils/context.dart';

class TravellingPlacesWidgetQuery extends StatefulWidget{

  late _TravellingPlaceQueryState state;

  String query = "";

  void performSearch(
      String query,
    ){
    state.performSearch(
      query,
    );
  }

  @override
  State<StatefulWidget> createState() {
    state = _TravellingPlaceQueryState();
    return state;
  }

}

class _TravellingPlaceQueryState extends State<TravellingPlacesWidgetQuery>{

  late Future<List<TravellingPlace>> futureTravellingPlaces;

  void performSearch(
      String query,){
    setState(() {
      widget.query = query;
    });
  }

  Widget _getCircularProgressLoading(){
    return const SizedBox(
      height: 100,
      child: CircularLoadingElement(
        message: "Sedang memuat...",
      ),
    );
  }

  Widget _getTravellingPlacesList(List<TravellingPlace> travellingPlaces){
    // double childAspectRatio = 0;
    // if (ContextUtils.getScreenWidth(context) > 500){
    //   childAspectRatio = 2.5;
    // }
    // else{
    //   childAspectRatio = 3;
    // }
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 600,
          mainAxisExtent: 140,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: travellingPlaces.length,
        itemBuilder: (BuildContext ctx, index){
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: HorizontalItemWidget(
              titleText: travellingPlaces[index].placeName,
              subtitleText: travellingPlaces[index].city,
              additionalWidget: RatingWidget(
                  rating: travellingPlaces[index].getRating()
              ),
              height: 125,
              onClickCard: (){
                Navigator.pushNamed(
                  context,
                  detailRouteName,
                  arguments: travellingPlaces[index]
                );
              },
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.query.isEmpty){
      return const InformationWidget(
        iconData: Icons.search,
        widgetWidth: 300,
        information: "Tempat Wisata apa yang Anda cari?",
      );
    }
    else{
      return FutureBuilder(
        future: DataFetcher.getTravellingPlacesByQuery(
          widget.query,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done){
            return _getCircularProgressLoading();
          }
          if (snapshot.hasData){
            return _getTravellingPlacesList(snapshot.data as List<TravellingPlace>);
          }
          print("Query: ${widget.query}");
          print("Error: ${snapshot.error}");
          return const Text(
              "Unknown Error Occured!"
          );
        }
      );
    }
  }
}