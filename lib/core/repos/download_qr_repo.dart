// import 'package:dartz/dartz.dart';
//
// import '../models/personal_data.dart';
// import '../service/home_service.dart';
// import '../data/download_qr_datasource.dart';
//
// class DownloadQrRepo extends IHomeRepository {
//   IDownloadQrDatasource data;
//   DownloadQrRepo({
//     required this.data,
//   });
//   @override
//   Future<Either<PersonalDataForm, String>> getProfile(String user) async {
//     return await data.getProfile(user).then((value) {
//       return value.fold((l) {
//         return Left(l.user);
//       }, (r) {
//         return Right(r.message);
//       });
//     });
//   }
// }
