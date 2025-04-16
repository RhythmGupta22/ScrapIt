import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scrap_it/screens/login/repository/auth_repository.dart';
import 'package:scrap_it/utils/firebase_functions.dart';

class CollectorProfileController extends GetxController {
  RxString collectorName = 'Collector'.obs;
  RxInt assignedPickupsCount = 0.obs;
  RxInt assignedOrdersCount = 0.obs;
  RxInt completedTasksCount = 0.obs;
  RxInt pendingTasksCount = 0.obs;
  
  // Location related variables
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxBool isLoadingLocation = false.obs;
  RxString locationError = ''.obs;

  @override
  void onReady() {
    super.onReady();
    fetchCollectorName();
    fetchTaskCounts();
    getCurrentLocation(); // Automatically fetch location when screen loads
  }

  Future<void> getCurrentLocation() async {
    isLoadingLocation.value = true;
    locationError.value = '';

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationError.value = 'Location services are disabled';
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationError.value = 'Location permission denied';
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        locationError.value = 'Location permissions are permanently denied';
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      currentPosition.value = position;
    } catch (e) {
      locationError.value = 'Error getting location: $e';
      print('Error getting location: $e');
    } finally {
      isLoadingLocation.value = false;
    }
  }

  Future<void> fetchCollectorName() async {
    try {
      String? uid = AuthRepository.instance.firebaseUser.value?.uid;
      if (uid != null) {
        String? name = await FirebaseFunctions.instance.getUserName(uid: uid);
        collectorName.value = name ?? 'Collector';
      }
    } catch (e) {
      print('Error fetching collector name: $e');
      collectorName.value = 'Collector';
    }
  }

  Future<void> fetchTaskCounts() async {
    try {
      String? uid = AuthRepository.instance.firebaseUser.value?.uid;
      if (uid != null) {
        // Fetch assigned pickups count
        assignedPickupsCount.value = await FirebaseFunctions.instance.getAssignedPickupsCount(uid);
        
        // Fetch assigned orders count
        assignedOrdersCount.value = await FirebaseFunctions.instance.getAssignedOrdersCount(uid);
        
        // Fetch completed tasks count
        completedTasksCount.value = await FirebaseFunctions.instance.getCompletedTasksCount(uid);
        
        // Calculate pending tasks
        pendingTasksCount.value = assignedPickupsCount.value + assignedOrdersCount.value - completedTasksCount.value;
      }
    } catch (e) {
      print('Error fetching task counts: $e');
      // Reset all counts to 0 on error
      assignedPickupsCount.value = 0;
      assignedOrdersCount.value = 0;
      completedTasksCount.value = 0;
      pendingTasksCount.value = 0;
    }
  }

  void logout() {
    AuthRepository.instance.signOut();
    Get.offAllNamed('/landing');
  }
}