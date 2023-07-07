import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prueba_tecnica_itti/utils/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 70.h),
                    const AppLogo(),
                    SizedBox(height: 30.h),
                    const LoginForm()
                  ],
                ),
              ),
            ),
            const AboutThisApp()
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            _emailInput(),
            const SizedBox(height: 20),
            _passwordInput(),
            const SizedBox(height: 20),
            _loginButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _emailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z@._-]")),
      ],
      decoration: const InputDecoration(
          hintText: 'cuenta@itti.com.py',
          label: Text('Correo electrónico'),
          suffixIcon: Icon(Icons.email),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColor2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          )),
      validator: (value) {
        String patron = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';
        RegExp regExp = RegExp(patron);
        if (value!.isEmpty) 
        {
          return 'Por favor ingrese su correo electrónico';
        }
        if (!regExp.hasMatch(value)) 
        {
          return 'Por favor ingrese un correo electrónico válido';
        }
        return null;
      },
    );
  }

  Widget _passwordInput() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.search,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
      maxLength: 5,
      decoration: const InputDecoration(
          hintText: '',
          label: Text('Contraseña'),
          suffixIcon: Icon(Icons.lock),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColor2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Por favor ingrese su contraseña';
        }
        if (value.length < 5) {
          return 'La contraseña debe tener 5 dígitos';
        }
        return null;
      },
    );
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: () {
          _formValidation(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text('Iniciar sesión',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
      ),
    );
  }

  void _formValidation(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/home');
    }
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 50.sp,
          backgroundColor: AppColors.primaryColor,
          child: Image.asset('assets/imgs/itti_logo_white.png'),
        ),
        Spin(
          controller: (p0) {
            
          },
          manualTrigger: true,
          child: SvgPicture.asset(
            'assets/svg/rounded_title.svg',
            width: 150.sp,
            height: 150.sp,
          ),
        )
      ],
    );
  }
}

class AboutThisApp extends StatelessWidget {
  const AboutThisApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final normalText = TextStyle(color: AppColors.textColor2, fontSize: 14.sp);
    final spetialText =
        TextStyle(color: AppColors.primaryColor, fontSize: 14.sp);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Más información acerca de está ',
              style: normalText,
            ),
            GestureDetector(
              onTap: () {
                _openUrl('https://drive.google.com/file/d/17I40U38XGtl5cUBuONbbv_4VtvSvwVmZ/view?usp=sharing');
              },
              child: Text(
                'prueba técnica',
                style: spetialText,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('realizada por ', style: normalText),
            GestureDetector(
              onTap: () {
                _openUrl('https://www.linkedin.com/in/jorge-guzm%C3%A1n-palacios-7a87a8136/');
              },
              child: Text(
                'Jorge Guzmán',
                style: spetialText,
              ),
            )
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  _openUrl(String url) async {
    Uri uri = Uri.parse(url);
    launchUrl(uri);
  }
}
