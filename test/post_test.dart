import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/post.dart';

void main() {
  test('New post should have appropriate properties', () {
    DateTime dateRightNow = DateTime.now();
    int number = 8;
    String longitude = '44.32';
    String latitude = '23.32';
    String url = 'http://test.com';

    Post post = Post(date: dateRightNow, itemCount: number, longitude: longitude, latitude: latitude, imageUrl: url);

    expect(post.getCount, 8);
    expect(post.getLatitude, latitude);
    expect(post.getLongitude, longitude);

  });

}