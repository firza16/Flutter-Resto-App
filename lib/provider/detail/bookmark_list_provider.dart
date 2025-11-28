// import 'package:flutter/widgets.dart';
// import 'package:resto_app/data/model/resto.dart';

// class BookmarkListProvider extends ChangeNotifier {
//   final List<Resto> _bookmarkList = [];

//   List<Resto> get bookmarkList => _bookmarkList;

//   void addBookmark(Resto value) {
//     _bookmarkList.add(value);
//     notifyListeners();
//   }

//   void removeBookmark(Resto value) {
//     _bookmarkList.removeWhere((element) => element.id == value.id);
//     notifyListeners();
//   }

//   bool checkItemBookmark(Resto value) {
//     final restoInList =
//         _bookmarkList.where((element) => element.id == value.id);
//     return restoInList.isNotEmpty;
//   }
// }

