import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/constant/page_const.dart';
import 'package:sistem_presensi/src/domain/entities/user_entity.dart';
import 'package:sistem_presensi/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/src/presentation/cubit/auth/auth_state.dart';
import 'package:sistem_presensi/src/presentation/cubit/user/user_cubit.dart';
import 'package:sistem_presensi/src/presentation/pages/main_page.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';
import 'package:sistem_presensi/src/presentation/styles/widget_style.dart';
import 'package:sistem_presensi/utils/scroll_behavior.dart';
import 'package:sistem_presensi/utils/validation.dart';

import '../../../constant/app_config.dart';

class SignUpPage extends StatefulWidget {
  final List<String> classroom = AppConfig.classroom;

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // WidgetStyle _widgetStyle = WidgetStyle();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  String? selectedValue;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formSignUpKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, userState){
          if(userState is UserSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(builder: (context, authState){
              if (authState is Authenticated) {
                return MainPage(uid: authState.uid);
              } else {
                return _bodyWidget();
              }
            });
          }
          if(userState is UserLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }
          return _bodyWidget();
        },
        listener: (context, userState) {
          if (userState is UserSuccess) {
            print(userState);
            BlocProvider.of<AuthCubit>(context).loggedIn();
            Navigator.pushReplacementNamed(context, PageConst.signInPage);
          }
          if (userState is UserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(userState.message ?? 'User Failed')));
          }
        },
      ),
    );
  }

  _bodyWidget() {
    return Form(
      key: _formSignUpKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: ListView(
            children: [
              const SizedBox(
                height: 64,
              ),
              Text('Daftar',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: ColorStyle.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nama'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan nama lengkap';
                      }
                      //TODO:validation
                      return null;
                    },
                    decoration: CWidgetStyle.textfieldDecoration(hintText: 'Nama lengkap'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Kelas'),
              const SizedBox(height: 8,),
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField2(
                  items: _addDividersAfterItems(widget.classroom),
                  decoration: CWidgetStyle.dropdownButtonDecoration(),
                  isExpanded: true,
                  hint: Text('Pilih kelas', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorStyle.darkGrey),),
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih kelas';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value.toString();
                    });
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                  buttonStyleData: const ButtonStyleData(
                    height: 48,
                    padding: EdgeInsets.fromLTRB(8, 4, 20, 4),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down),
                    openMenuIcon: Icon(Icons.keyboard_arrow_up),
                    iconEnabledColor: ColorStyle.indigoLight,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    elevation: 4,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    customHeights: _getCustomItemsHeights(widget.classroom),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nomor Siswa'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _idController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan nomor siswa';
                      }
                      return null;
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: CWidgetStyle.textfieldDecoration(hintText: '3283747932'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Email'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan email';
                      }
                      if (!value.isValidEmail) {
                        return 'Email tidak valid';
                      }
                      return null;
                    },
                    decoration: CWidgetStyle.textfieldDecoration(hintText: 'contoh@email.com'),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Password'),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan password';
                      }
                      if (!value.isValidPassword) {
                        return 'Masukan minimal 8 karakter';
                      }
                      return null;
                    },
                    decoration: CWidgetStyle.textfieldDecoration(hintText: 'min. 8 karakter'),
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLength: 16,
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              const SizedBox(
                height: 100,
              ),
              TextButton(
                style: CWidgetStyle.textButtonStyle(),
                onPressed: submitSignUp,
                child: Text('Lanjut', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorStyle.white),),
              ),
              const SizedBox(
                height: 20,
              ),
              // OutlinedButton(
              //   style: WidgetStyle.outlinedButtonStyle(),
              //   onPressed: () => Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false),
              //   child: const Text('Daftar sebagai Guru'),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Sudah memiliki akun?'),
                  const SizedBox(width: 8,),
                  TextButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  submitSignUp() async {
    if (_formSignUpKey.currentState!.validate()) {
      await BlocProvider.of<UserCubit>(context).submitSignUp(user: UserEntity(
          email: _emailController.text,
          role: 'student',
          grade: selectedValue,
          userInfo: {
            'name': _nameController.text,
            'student_number': _idController.text,
            'classroom': selectedValue,
            'total_absence': 0,
            'total_presence': 0
          },
          password: _passwordController.text
      ));
    }
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: EdgeInsets.zero,
              child: Text(item, style: Theme.of(context).textTheme.bodyMedium,),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<double> _getCustomItemsHeights(List<String> items) {
    List<double> _itemsHeights = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        _itemsHeights.add(46);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _itemsHeights.add(4);
      }
    }
    return _itemsHeights;
  }
}