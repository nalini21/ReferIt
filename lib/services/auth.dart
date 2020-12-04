import 'package:ReferIt/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // user stream of type firebaseUser (User)
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  //sign in annonymosuly
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await FirestoreService(uid: user.uid).updateUserData(user.uid, '', 0);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with refferal code
  Future registerWithRefferalAndEmailAndPassword(
      String email, String password, String refferal) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      //
      await FirestoreService(uid: user.uid)
          .updateUserData(user.uid, 'someone', 20);
      //
      await FirestoreService(uid: user.uid).getReward(refferal);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
