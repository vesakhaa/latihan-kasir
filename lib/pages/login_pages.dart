import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pl2_kasir/auth/auth_service.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //get authservice

  final authService = AuthService();

  //text controller

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //tombol login
  void login() async{
    final email = _emailController.text;
    final password = _passwordController.text;

    //percobaan login
    try{
      await authService.signInWithEmailAndPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text(""), centerTitle: true,),
    body: Padding(padding: const EdgeInsets.symmetric(horizontal: 70),
    child: Column(
      children: [
        const Image(image: AssetImage("rb_1592.png"), width: 320,),

        //email
        TextField(
          controller: _emailController,
          decoration:  InputDecoration
          (labelText: "Email", labelStyle: GoogleFonts.poppins(color: Colors.blue, fontWeight: FontWeight.w400 ) , 
          prefixIcon: const Icon(Icons.person, color: Colors.blue,),
  
          ),
        ),
        
        const SizedBox(height: 15,),
        //password

        TextField(
          controller: _passwordController,
          decoration:  InputDecoration
          (labelText: "Password", labelStyle: GoogleFonts.poppins(color: Colors.blue, fontWeight: FontWeight.w400 ),
          prefixIcon: const Icon(Icons.lock, color: Colors.blue),
          // iconColor: Colors.blue,
          ),
        ),

        const SizedBox(height: 50,),

        //tombol login
        
        Container(
          width: double.infinity,
          child: ElevatedButton(onPressed: login, 
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.symmetric(vertical: 20),
            
          ),
          child: Text("Login", style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),),
          ),
        )
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