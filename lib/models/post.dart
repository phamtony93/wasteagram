class Post {
  DateTime date;
  int itemCount;
  String longitude;
  String latitude;
  String imageUrl;

  Post({this.date, this.itemCount, this.longitude, this.latitude, this.imageUrl});

  get getCount => itemCount;
  get getLongitude => longitude;
  get getLatitude => latitude;

}