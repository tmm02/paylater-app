import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paylater/user/LoginPage.dart';
import '../admin/component/popup.dart';
import '../theme.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({Key? key}) : super(key: key);

  @override
  State<DaftarPage> createState() => _DaftarPageState();
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class _DaftarPageState extends State<DaftarPage> {
  TextEditingController inputUsername = TextEditingController();
  TextEditingController inputTelp = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputJob = TextEditingController();
  TextEditingController verifikasiWajah = TextEditingController();
  TextEditingController verifikasiKTP = TextEditingController();
  File? wajah;
  File? ktp;

  Future pickImage(String foto) async {
    try {
      if (Platform.isIOS) {
        return showCupertinoModalPopup<ImageSource>(
            context: context,
            builder: (context) => CupertinoActionSheet(
                  actions: [
                    CupertinoActionSheetAction(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (image == null) return;
                          final imageTemporary = File(image.path);
                          if (foto == "wajah") {
                            setState(() {
                              wajah = imageTemporary;
                            });
                          }
                          if (foto == "ktp") {
                            setState(() {
                              ktp = imageTemporary;
                            });
                          }
                        },
                        child: Text('Camera')),
                    CupertinoActionSheetAction(
                        onPressed: () async {
                          Navigator.of(context).pop();

                          Navigator.of(context).pop();
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image == null) return;
                          final imageTemporary = File(image.path);
                          if (foto == "wajah") {
                            setState(() {
                              wajah = imageTemporary;
                            });
                          }
                          if (foto == "ktp") {
                            setState(() {
                              ktp = imageTemporary;
                            });
                          }
                        },
                        child: Text('Gallery'))
                  ],
                ));
      } else if (Platform.isAndroid) {
        return showModalBottomSheet(
            context: context,
            builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text('Camera'),
                        onTap: () async {
                          Navigator.of(context).pop();
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (image == null) return;
                          final imageTemporary = File(image.path);
                          if (foto == "wajah") {
                            setState(() {
                              wajah = imageTemporary;
                            });
                          }
                          if (foto == "ktp") {
                            setState(() {
                              ktp = imageTemporary;
                            });
                          }
                        }),
                    ListTile(
                        leading: Icon(Icons.image),
                        title: Text('Gallery'),
                        onTap: () async {
                          Navigator.of(context).pop();
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image == null) return;
                          final imageTemporary = File(image.path);
                          if (foto == "wajah") {
                            setState(() {
                              this.wajah = imageTemporary;
                            });
                          }
                          if (foto == "ktp") {
                            setState(() {
                              this.ktp = imageTemporary;
                            });
                          }
                        }),
                  ],
                ));
      }
    } on PlatformException catch (e) {
      print("failed to pick image: $e");
    }
  }

  void signUp(String username, email, telp, pekerjaan, wajah, ktp) async {
    try {
      Response response = await post(
          Uri.parse('https://paylater.harysusilo.my.id/api/auth/register'),
          body: {
            'user_name': inputUsername.text,
            'email_address': inputEmail.text,
            'phone_number': inputTelp.text,
            'job': inputJob.selection,
            'image_face': wajah,
            'image_ktp': ktp
          });
      if (response.statusCode == 200) {
        print('account created successfully');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String? dropdownValue = "Tenaga Pendidik";

  get firstCamera => null;

  @override
  void dispose() {
    inputUsername.dispose();
    inputTelp.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaylaterTheme.white,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text('Daftar Akun',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: PaylaterTheme.darkText,
              )),
        ),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: Container(
        color: PaylaterTheme.spacer,
        child: ListView(physics: const ClampingScrollPhysics(), children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Username
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Username',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: PaylaterTheme.grey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          autocorrect: true,
                          validator: (input) => input!.isValidEmail()
                              ? null
                              : "Username harus di isi",
                          // selectionHeightStyle:
                          //     BoxHeightStyle.includeLineSpacingMiddle,

                          controller: inputUsername,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15.0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: 'Masukan Username',
                              hintStyle: TextStyle(
                                  color: PaylaterTheme.deactivatedText),
                              filled: true,
                              fillColor: PaylaterTheme.white),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ///email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: PaylaterTheme.grey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          // selectionHeightStyle:
                          //     BoxHeightStyle.includeLineSpacingMiddle,
                          controller: inputEmail,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15.0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: 'Masukan Email',
                              hintStyle: TextStyle(
                                  color: PaylaterTheme.deactivatedText),
                              filled: true,
                              fillColor: PaylaterTheme.white),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ///Nomor Telepon
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nomor Telepon',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: PaylaterTheme.grey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Flexible(
                              flex: 2,
                              child: TextField(
                                enabled: false,
                                maxLines: 1,
                                decoration: InputDecoration(
                                    labelStyle:
                                        TextStyle(fontWeight: FontWeight.w600),
                                    labelText: '62',
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 15.0),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    filled: true,
                                    fillColor: PaylaterTheme.white),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              flex: 8,
                              fit: FlexFit.tight,
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: inputTelp,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 15.0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      hintText: 'Masukan Nomor Telepon',
                                      hintStyle: TextStyle(
                                          color: PaylaterTheme.deactivatedText),
                                      filled: true,
                                      fillColor: PaylaterTheme.white),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ///Pekerjaan
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Status Pekerjaan',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: PaylaterTheme.grey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            filled: true,
                            fillColor: PaylaterTheme.white,
                          ),
                          dropdownColor: PaylaterTheme.white,
                          hint: const Text(
                            "Choose",
                            style: TextStyle(
                                color: PaylaterTheme.deactivatedText,
                                fontWeight: FontWeight.w600),
                          ),
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['Dosen', 'Tenaga Pendidik']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: PaylaterTheme.grey),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    ///verif wajah
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Verifikasi Wajah',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: PaylaterTheme.grey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              wajah != null
                                  ? Image.file(
                                      wajah!,
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    )
                                  : Text('no file'),
                              IconButton(
                                padding: EdgeInsets.all(8),
                                color: Color(0xffd8d8e0),
                                onPressed: () => pickImage("wajah"),
                                icon: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    ///verif ktp
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Verifikasi Kartu Identitas (KTP)',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: PaylaterTheme.grey),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ktp != null
                                  ? Image.file(
                                      ktp!,
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    )
                                  : Text('no file'),
                              IconButton(
                                padding: EdgeInsets.all(8),
                                color: Color(0xffF7F7FC),
                                onPressed: () => pickImage("ktp"),
                                icon: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),

                //button
                SizedBox(
                  height: 80,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PaylaterTheme.maincolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Popup.confirmDialog(context,
                            message: "Konfirmasi data anda?",
                            dialogCallback: (value) async {
                          if (value == 'Confirm') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginPage()));
                          }
                          if (value == 'Cancel') {}
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("Konfirmasi")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PaylaterTheme.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("Batal")),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
