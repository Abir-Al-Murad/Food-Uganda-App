import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jervis/Pages/logIn.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  bool isPasswordVisible = false;

  Future<void> signup(String email, String password, String name, String phone, String location, String imageUrl) async {
    try {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance.collection('user').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'location': location,
        'imageUrl': imageUrl,
      });

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login())); // Redirect after successful signup
    } on FirebaseAuthException catch (e) {
      String message = 'Signup Failed';
      if (e.code == 'email-already-in-use') {
        message = 'Email is already in use';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Signup"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Name
                TextFormField(
                  controller: nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? "Enter your name" : null,
                ),
                SizedBox(height: 20),
        
                // Phone
                TextFormField(
                  controller: phoneController,
                  style: TextStyle(color: Colors.black),

                  decoration: InputDecoration(
                    labelText: "Phone",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty ? "Enter your phone number" : null,
                ),
                SizedBox(height: 20),
        
                // Location
                TextFormField(
                  controller: locationController,
                  style: TextStyle(color: Colors.black),

                  decoration: InputDecoration(
                    labelText: "Location",
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? "Enter your location" : null,
                ),
                SizedBox(height: 20),
        
                // Email
                TextFormField(
                  controller: emailController,
                  style: TextStyle(color: Colors.black),

                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value == null || value.isEmpty ? "Enter your email" : null,
                ),
                SizedBox(height: 20),
        
                // Password
                TextFormField(
                  controller: passwordController,
                  style: TextStyle(color: Colors.black),

                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) => value == null || value.length < 6 ? "Min 6 characters" : null,
                ),
                SizedBox(height: 20),
        
                // Image URL
                TextFormField(
                  controller: imageUrlController,
                  style: TextStyle(color: Colors.black),

                  decoration: InputDecoration(
                    labelText: "Image URL",
                    prefixIcon: Icon(Icons.image),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) => value == null || value.isEmpty ? "Enter image URL" : null,
                ),
                SizedBox(height: 20),
        
                // Signup Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signup(
                        emailController.text,
                        passwordController.text,
                        nameController.text,
                        phoneController.text,
                        locationController.text,
                        imageUrlController.text, // Pass the image URL as a string
                      );
                    }
                  },
                  child: Text("Signup", style: TextStyle(fontSize: 18,color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
