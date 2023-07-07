import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_tecnica_itti/api/models/regres_users_response_model.dart';
import 'package:prueba_tecnica_itti/api/regres.dart';
import 'package:prueba_tecnica_itti/pages/client_detail.dart';
import 'package:prueba_tecnica_itti/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: SvgPicture.asset(
            'assets/svg/itti_logo.svg',
            width: 50.w,
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  children: [
                    Text('Clientes',
                        style: TextStyle(
                            color: AppColors.textColor1,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Expanded(child: ClienList()),
              const Text(
                'Swipe down para actualizar',
                style: TextStyle(color: AppColors.textColor2),
              ),
              BounceInDown(
                  child: const Icon(
                Icons.arrow_downward,
                color: AppColors.primaryColor,
              )),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ));
  }
}

class ClienList extends StatefulWidget {
  const ClienList({super.key});

  @override
  State<ClienList> createState() => _ClienListState();
}

class _ClienListState extends State<ClienList> {
  List<Datum> data = [];
  RequestState requestState = RequestState.loading;
  @override
  void initState() {
    super.initState();
    _data();
  }

  @override
  Widget build(BuildContext context) {
    if (requestState == RequestState.loading) {
      return Center(
          child: SizedBox(
        width: 50.sp,
        height: 50.sp,
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(10.sp),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r))),
            child: const CircularProgressIndicator(
              color: AppColors.primaryColor,
            )),
      ));
    }

    if (requestState == RequestState.error) {
      return const Center(child: Text('Error'));
    }

    return RefreshIndicator(
        onRefresh: () async {
          _data();
        },
        color: AppColors.primaryColor,
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ContactItem(
              data: data[index],
              index: index,
            );
          },
        ));
  }

  _data() async {
    setState(() {
      requestState = RequestState.loading;
    });
    Regres regres = Regres();
    final response = await regres.get();
    await Future.delayed(const Duration(seconds: 2));
    if (response.model != null) {
      data = response.model!.data;
      //ordenar por nombre
      data.sort((a, b) => a.firstName.compareTo(b.firstName));

      setState(() {
        requestState = RequestState.loaded;
      });
      print('data');
    } else {
      print('Error');
      setState(() {
        requestState = RequestState.error;
      });
    }
    return data;
  }
}

class ContactItem extends StatelessWidget {
  final int index;
  final Datum data;
  const ContactItem({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClienStatus status = _clientStatus();
    return FadeInDown(
      duration: Duration(milliseconds: (200 * index)),
      animate: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  ClientDetail(
                          data: data,
                          status: status
                    )
                ));
          },
          splashColor: AppColors.primaryColor.withOpacity(0.2),
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.sp),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: 30,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.r),
                                  child: FadeInImage(
                                      image: NetworkImage(data.avatar),
                                      placeholder: const AssetImage(
                                          'assets/imgs/user_palceholder.png'))),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child:_statusIndicator(status),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '${data.firstName} ${data.lastName}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.textColor1,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
            
                              GestureDetector(
                                onTap: () {
                                  _openToMail(data.email);
                                },
                                child: Container(
                                color: Colors.white.withOpacity(0.1),
                                height: 30.h,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.email,
                                        size: 14.sp,
                                        color: AppColors.primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data.email,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.primaryColor,),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 86.w,
                      ),
                      const Expanded(child: Divider()),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }

  _openToMail(String email) async {
    final Uri emailLaunchUri =
        Uri(scheme: 'mailto', path: email, queryParameters: {'subject': ''});
    await launchUrl(emailLaunchUri);
  }

  Widget _statusIndicator(ClienStatus status) 
  {

    switch (status)
    {
      case ClienStatus.active:
        return Container(
          width: 15.sp,
          height: 15.sp,
          decoration: BoxDecoration(
              color: Colors.lightGreen, borderRadius: BorderRadius.circular(50.r)),
              child: Icon(Icons.check_circle, color: Colors.white, size: 10.sp,)
        );
      case ClienStatus.inactive:
        return Container(
          width: 15.sp,
          height: 15.sp,
          decoration: BoxDecoration(
              color: Colors.yellow.shade700, borderRadius: BorderRadius.circular(50.r)),
              child: Icon(Icons.access_time_filled, color: Colors.white, size: 10.sp,)
        );
      case ClienStatus.blocked:
        return Container(
          width: 15.sp,
          height: 15.sp,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(50.r)),
              child: Icon(Icons.remove_circle, color: Colors.white, size: 10.sp,)
        );  
    }

    
  }

  ClienStatus _clientStatus() {
    int number = _randomNumber();
    if (number < 20) {
      return ClienStatus.active;
    } else if (number % 20 == 0) {
      return ClienStatus.inactive;
    } else {
      return ClienStatus.blocked;
    }
  }

  int _randomNumber() {
    //un numero entre 1 y 100
    var rng = new Random();
    return rng.nextInt(100);
  }
}

enum RequestState { loading, loaded, error }

enum ClienStatus { blocked, active, inactive }
