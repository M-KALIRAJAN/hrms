// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hrms/core/constants/app_colors.dart';
// import 'package:hrms/routing/app_router.dart';
// import 'package:hrms/services/Location_Service.dart';
// import 'package:hrms/services/PunchService.dart';
// import 'package:hrms/widgets/app_button.dart';
// import 'package:hrms/storage/preferences.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   double? latitude;
//   double? longitude;
//   bool _isLoading = false;
//   String userName = "John Doe";

//   final PunchService _punchService = PunchService();

//   @override
//   void initState() {
//     super.initState();
//     _initPunch();
//   }

//   /// Get location, user data, and send punch
//   Future<void> _initPunch() async {
//     try {
//       setState(() => _isLoading = true);

//       // 1️⃣ Get current location
//       final position = await LocationService.getCurrentLocation();
//       latitude = position.latitude;
//       longitude = position.longitude;

//       // 2️⃣ Get stored user data
//       final userId = await Preferences.getUserId();
//       final companyId = await Preferences.getCompanyId();
//       final locationId = await Preferences.getLocationId();
//       final name = await Preferences.getUserName();

//       setState(() => userName = name);

//       // 3️⃣ Call punch API
//       await _punchService.sendPunch(
//         userId: userId,
//         companyId: companyId,
//         locationId: locationId,
//         latitude: latitude.toString(),
//         longitude: longitude.toString(),
//       );

//       setState(() => _isLoading = false);

//     } catch (e) {
//       setState(() => _isLoading = false);
//       debugPrint("Punch Error8***************: $e");
//     }
//   }

//  Future<void> logout() async {
//     try {
//       setState(() => _isLoading = true);

//       // 1️⃣ Get current location
//       final position = await LocationService.getCurrentLocation();
//       latitude = position.latitude;
//       longitude = position.longitude;

//       // 2️⃣ Get stored user data
//       final userId = await Preferences.getUserId();
//       final companyId = await Preferences.getCompanyId();
//       final locationId = await Preferences.getLocationId();
//       final name = await Preferences.getUserName();

//       setState(() => userName = name);

//       // 3️⃣ Call punch API
//       await _punchService.sendPunch(
//         userId: userId,
//         companyId: companyId,
//         locationId: locationId,
//         latitude: latitude.toString(),
//         longitude: longitude.toString(),
//       );

//       setState(() => _isLoading = false);
//       context.push(RouteName.login);

//     } catch (e) {
//       setState(() => _isLoading = false);
//       debugPrint("Punch Error8***************: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome, $userName'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             Text("Latitude: ${latitude ?? 'Loading...'}", style: const TextStyle(fontSize: 18)),
//             Text("Longitude: ${longitude ?? 'Loading...'}", style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 20),
//             AppButton(
//               height: 50,
//               width: double.infinity,
//               text: "Logout",
//               color: AppColors.btn_primery,
//               textColor: Colors.white,
//               isLoading: _isLoading,
//               onPressed: logout,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hrms/core/constants/app_colors.dart';
import 'package:hrms/routing/app_router.dart';
import 'package:hrms/services/Location_Service.dart';
import 'package:hrms/services/PunchService.dart';
import 'package:hrms/widgets/app_button.dart';
import 'package:hrms/storage/preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double? latitude;
  double? longitude;
  bool _isLoading = false;
  String userName = "John Doe";

  final PunchService _punchService = PunchService();

  @override
  void initState() {
    super.initState();
    _initPunch();
  }

  Future<void> _initPunch() async {
    try {
      setState(() => _isLoading = true);

      final position = await LocationService.getCurrentLocation();
      latitude = position.latitude;
      longitude = position.longitude;

      final userId = await Preferences.getUserId();
      final companyId = await Preferences.getCompanyId();
      final locationId = await Preferences.getLocationId();
      final name = await Preferences.getUserName();

      setState(() => userName = name);

      await _punchService.sendPunch(
        userId: userId,
        companyId: companyId,
        locationId: locationId,
        latitude: latitude.toString(),
        longitude: longitude.toString(),
      );

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint("Punch Error: $e");
    }
  }

  Future<void> logout() async {
    try {
      setState(() => _isLoading = true);

      final position = await LocationService.getCurrentLocation();
      latitude = position.latitude;
      longitude = position.longitude;

      final userId = await Preferences.getUserId();
      final companyId = await Preferences.getCompanyId();
      final locationId = await Preferences.getLocationId();
      final name = await Preferences.getUserName();

      setState(() => userName = name);

      await _punchService.sendPunch(
        userId: userId,
        companyId: companyId,
        locationId: locationId,
        latitude: latitude.toString(),
        longitude: longitude.toString(),
      );
      await Preferences.clearAll();
      setState(() => _isLoading = false);
      context.push(RouteName.login);
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint("Punch Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Welcome, $userName',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: AppColors.btn_primery,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Card with gradient for user info
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.btn_primery, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 50, color: Colors.white),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Location ready",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Location info cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _infoCard(
                      icon: Icons.my_location,
                      label: "Latitude",
                      value: latitude?.toStringAsFixed(6) ?? "Loading...",
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _infoCard(
                      icon: Icons.location_on,
                      label: "Longitude",
                      value: longitude?.toStringAsFixed(6) ?? "Loading...",
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              AppButton(
                height: 50,
                width: double.infinity,
                text: "Logout",
                color: AppColors.btn_primery,
                textColor: Colors.white,
                isLoading: _isLoading,
                onPressed: logout,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: color),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 16, color: color)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
