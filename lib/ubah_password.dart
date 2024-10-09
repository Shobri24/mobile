import 'package:flutter/material.dart';
import 'profile.dart';
import 'simpan.dart';

void main() {
  runApp(UbahPassword());
}

class UbahPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UbahPasswordScreen(),
    );
  }
}

class UbahPasswordScreen extends StatefulWidget {
  @override
  _UbahPasswordScreenState createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _passwordError;

  void _validatePasswords() {
    setState(() {
      _passwordError = null;

      if (_newPasswordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
        _passwordError = 'Password baru dan konfirmasi tidak boleh kosong';
      } else if (_newPasswordController.text != _confirmPasswordController.text) {
        _passwordError = 'Password baru dan konfirmasi tidak sama';
      } else if (_newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        _passwordError = 'Password tidak boleh mengandung karakter spesial';
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PasswordUpdate()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Rectangle 9.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileScreenApp()),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 130,
                      left: MediaQuery.of(context).size.width / 2 - 80,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.deepPurple,
                        child: CircleAvatar(
                          radius: 76,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/images/profil.jpeg'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          _passwordError != null ? '*$_passwordError' : '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _oldPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Password Lama:',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Password Baru:',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Ulangi Password Baru:',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 120,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProfileScreenApp()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.red),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Batal',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          // Tombol Simpan
                          SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              onPressed: () {
                                _validatePasswords();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Simpan',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
