import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/login_controller.dart';
import '../../../routes.dart';
import '../../../core/class/status_request.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: GetBuilder<LoginController>(
        builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: ListView(
            children: [
              const SizedBox(height: 100),
              const CircleAvatar(
              radius: 160,
              backgroundImage: AssetImage("assets/images/logo.png"),
              backgroundColor: Colors.transparent,
            ),
              const SizedBox(height: 10),
              Text(
                "welcome_back".tr,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 50),
              
              _buildTextField(
                controller: controller.email,
                hint: "email_address".tr,
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 35),

              SizedBox(
                height: 55,
                child: controller.statusRequest == StatusRequest.loading 
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : ElevatedButton(
                      onPressed: () => controller.login(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child:  Text("login".tr, style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
                    ),
              ),
              
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("don't_have_an_account?".tr, style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.signUp),
                    child: Text("signup".tr, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}