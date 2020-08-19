import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:clima/utilities/api.dart';

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
  static final String androidAPIKey = kAndroidAPIKey;
  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    if (input.length > 2) {
      final request =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&type=(cities)&language=$lang&key=$androidAPIKey&sessiontoken=$sessionToken';
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
      }
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
