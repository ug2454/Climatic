import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    // TODO: implement toString
    return 'Suggestion(description:$description,placeId:$placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();
  PlaceApiProvider(this.sessionToken);
  final sessionToken;

  static final String androidKey = 'AIzaSyA-VjN_0GLLFMiqqNz8fqFLPkL1atobEcw';

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=$lang&key=$androidKey&sessiontoken=$sessionToken';
    print(request);
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        return result['predictions']
            .map<Suggestion>(
                (p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
