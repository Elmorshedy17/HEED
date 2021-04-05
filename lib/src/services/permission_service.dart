// import 'package:permission_handler/permission_handler.dart';
//
// class PermissionsService {
//   final PermissionHandler _permissionHandler = PermissionHandler();
//
//   /// A generic function that takes in a PermissionGroup to request a permission of what we want.
//   Future<bool> _requestPermission(PermissionGroup permission) async {
//     var result = await _permissionHandler.requestPermissions([permission]);
//     if (result[permission] == PermissionStatus.granted) {
//       return true;
//     }
//
//     return false;
//   }
//
//   /// Requests the users permission to read their contacts.
//   Future<bool> requestContactsPermission({Function onPermissionDenied}) async {
//     var granted = await _requestPermission(PermissionGroup.contacts);
//     if (!granted) {
//       onPermissionDenied();
//     }
//     return granted;
//   }
//
//   /// Requests the users permission to read their location when the app is in use
//   Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
//     var granted = await _requestPermission(PermissionGroup.locationWhenInUse);
//     if (!granted) {
//       onPermissionDenied();
//     }
//     return granted;
//   }
//
//   /// A generic function to check if the app has a permission already.
//   Future<bool> _hasPermission(PermissionGroup permission) async {
//     var permissionStatus =
//         await _permissionHandler.checkPermissionStatus(permission);
//     return permissionStatus == PermissionStatus.granted;
//   }
//
//   /// Check if the app has (contacts permission) already.
//   Future<bool> hasContactsPermission() async {
//     return _hasPermission(PermissionGroup.contacts);
//   }
//
//   /// Check if the app has (location permission) already.
//   Future<bool> hasLocationPermission() async {
//     return _hasPermission(PermissionGroup.locationWhenInUse);
//   }
// }
