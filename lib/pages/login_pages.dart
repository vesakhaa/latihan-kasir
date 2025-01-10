import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pl2_kasir/auth/auth_service.dart';
import 'package:pl2_kasir/pages/dashboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //get authservice

  // final authService = AuthService();

  //text controller

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isObsecure = true;

  //tombol login
  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    //percobaan login
    try {
      final response = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);
      if (response.session != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      } else {
        _showError('Login Gagal, Periksa Email dan Password Anda');
      }
    } catch (error) {
      _showError(error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: const AssetImage("rb_1592.png"),
              width: screenWidth * 0.8,
            ),

            Text(
              "Welcome",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please Login First",
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
            ),

            //email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: GoogleFonts.poppins(
                    color: const Color(0xFF00934E),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                prefixIcon: const Icon(
                  Icons.person,
                  color: Color(0xFF00934E),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            //password

            TextField(
              controller: _passwordController,
              obscureText: _isObsecure,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: GoogleFonts.poppins(
                    color: const Color(0xFF00934E),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                prefixIcon: const Icon(Icons.lock,
                    color:  Color(0xFF00934E)),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isObsecure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObsecure = !_isObsecure;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(
              height: 40,
            ),

            //tombol login

            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00934E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text(
                "Login",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),

      // body: ListView(
      //   children: [
      //     Container(
      //       padding: const EdgeInsets.all(16),
      //       child:  const Image(image: AssetImage("rb_1592.png"), width: 300, height: 300,),
      //     ),

      //     // Email
      //     Container(
      //       padding: const EdgeInsets.all(16.0),
      //       child: TextField(
      //         controller: _emailController,
      //         decoration: const InputDecoration(labelText: "Email"),
      //       ),
      //     ),

      //     // Password
      //     Container(
      //       padding: const EdgeInsets.all(16.0),
      //       child: TextField(
      //         controller: _passwordController,
      //         decoration: const InputDecoration(labelText: "Password"),
      //       ),
      //     ),

      //     const SizedBox(
      //       height: 50.0,
      //     ),

      //     // Tombol Login
      //     Container(
      //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //       child: ElevatedButton(
      //         onPressed: login, /*() => Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard())),*/

      //         child: const Text("Login", style: TextStyle(color: Color.fromARGB(255, 21, 97, 184)),),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
