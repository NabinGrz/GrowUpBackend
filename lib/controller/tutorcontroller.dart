import 'package:get/get.dart';
import 'package:growup/services/apiservice.dart';

class TutorController extends GetxController {
  var isLoading = true.obs;
  var tutorList = [].obs;

  @override
  void onInit() {
    fetchTutor();
    super.onInit();
  }

  void fetchTutor() async {
    try {
      var tutor = await getTeacherDetails();
      print("===================CHECK===========================");
      print(tutor);
      isLoading(true);
      if (tutor != null) {
        tutorList.value = tutor;
      }
    } finally {
      isLoading(false);
    }
  }
}
