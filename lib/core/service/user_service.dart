import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifinapp/common/common.dart';

class UserService {
  final CollectionReference userReference =
      FirebaseFirestore.instance.collection('financial-user');

  Stream<UserModel> watchUser({required String userId}) {
    Stream<DocumentSnapshot> stream = userReference.doc(userId).snapshots();

    return stream.map(
      (event) => UserModel.fromDocumentSnapshot(event),
    );
  }

  Future update({required UserModel user}) async {
    await userReference.doc(user.id!).set(user.toMap());
  }
}
