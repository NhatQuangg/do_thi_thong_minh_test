import 'package:do_thi_thong_minh/page/home/home_page.dart';
import 'package:do_thi_thong_minh/page/login/login_page.dart';
import 'package:do_thi_thong_minh/repository/authentication/exceptions/signup_email_password_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  // theo dõi thay đổi trong trạng thái đăng nhập của user
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    // Future.delayed(const Duration(seconds: 6));
    // gán = người dùng hiện tại
    firebaseUser = Rx<User?>(_auth.currentUser);
    // sau đó liên kế nó vs sự thay đổi của người dùng
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }
  // nếu người dùng đã đăng nhập thì tới trang home.
  // Còn không thì tới Login
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const HomePage())
        : Get.offAll(() => const LoginScreen());
  }

  // tạo tài khoản với authentication
  Future<void> createUserWithEmailAndPassword (String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const LoginScreen())
          : Get.to(() => HomePage());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {
      final ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  // đăng nhập với authentication
  Future<void> loginWithEmailAndPassword (String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  // Future<void> logout() async => await _auth.ig
}