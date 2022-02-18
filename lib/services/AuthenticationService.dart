//import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationService {
  static LocalAuthentication localAuthentication = LocalAuthentication();
 // static GoogleSignIn _googleSignIn = GoogleSignIn();

  // final currentUser = await _auth.currentUser();

  static Future<bool> isDeviceSupportBio() async {
    bool isDeviceSupported = await localAuthentication.isDeviceSupported();
    print(isDeviceSupported);
    return isDeviceSupported;
  }

  static Future<bool> checkingForBioMetrics() async {
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    print("check $canCheckBiometrics");
    return canCheckBiometrics;
  }
  static Future<bool> checkFace() async{
    List<BiometricType> biometricTypes =
    await localAuthentication.getAvailableBiometrics();
    for(int i=0;i<biometricTypes.length;i++){

      if(biometricTypes[1].toString() == "BiometricType.face"){
        return true;
      }else{
        return false;
      }
    }
  }

  static Future<bool> enrolledBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    List<BiometricType> biometricTypes =
    await localAuthentication.getAvailableBiometrics();

    if(biometricTypes == null || biometricTypes.isEmpty || biometricTypes.length == 0){
      return false;
    }else{
      return true;
    }

  }
  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await isDeviceSupportBio();
    bool canCheckBiometrics = await checkingForBioMetrics();

    List<BiometricType> biometricTypes =
    await localAuthentication.getAvailableBiometrics();

    // print("list :: ${biometricTypes[0]}");

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason: 'Please complete the biometrics to proceed.',
          androidAuthStrings: AndroidAuthMessages(
            signInTitle: "Authentication required",
          ),
          iOSAuthStrings: IOSAuthMessages(
            lockOut: "Authentication required",
          ),
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: false,
        );
      }catch(error){
        print("excep: ${error.toString()}");
        return false;
    }

    }
    return isAuthenticated;
  }

  static Future<bool> checkActiveBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    // bool isBiometricSupported = await isDeviceSupportBio();
    // bool canCheckBiometrics = await checkingForBioMetrics();

    bool isAuthenticated = false;

    // if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await localAuthentication.authenticate();

      }catch(error){
        print("excep: ${error.toString()}");
        if((error.toString()) == "PlatformException(NotEnrolled, No biometrics enrolled on this device., null, null)" ){
          return false;
        }
        return true;
      }

    // }
    return isAuthenticated;
  }

  // PlatformException(NotEnrolled, No biometrics enrolled on this device., null, null)


}
