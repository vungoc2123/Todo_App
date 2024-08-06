class AppConstants {
  static const int startPage = 0;
  static const int pageSize = 10;
  static const String notFoundImage =
      'https://img.freepik.com/free-vector/hand-drawn-no-data-illustration_23-2150696458.jpg?size=338&ext=jpg&ga=GA1.1.553209589.1713830400&semt=ais';

  final RegExp emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,20}$',
  );

  static const String defaultImage = "https://firebasestorage.googleapis.com/v0/b/shopping-2697a.appspot.com/o/user.png?alt=media&token=a2b514cb-fe85-4ab2-88b0-8dfb2f69759d";
}
