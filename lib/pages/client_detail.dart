import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prueba_tecnica_itti/api/models/regres_users_response_model.dart';
import 'package:prueba_tecnica_itti/pages/home_page.dart';

class ClientDetail extends StatelessWidget {
  final Datum data;
  final ClienStatus status;
  const ClientDetail({super.key, required  this.data, required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${data.firstName} ${data.lastName}',
                    style:  TextStyle(
                      fontSize: 48.sp,
                      color: Colors.white
                    ),
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      SizedBox(
                        height: 170.h,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 70.r,
                        child: CircleAvatar(
                          radius: 65.r,
                          backgroundImage: NetworkImage(data.avatar),
                        ),
                      ),
                      Positioned(
                        bottom: 15.h,
                        right: 0,
                        left: 0
                        ,
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon( _icon()),
                            color: _backgroundColor(),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.r)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              
                              Text(
                                _enumToString(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _icon() {
    switch (status) {
      case ClienStatus.active:
        return Icons.check;
      case ClienStatus.inactive:
        return Icons.access_time_filled_outlined;
      default:
        return Icons.remove_circle;
    }
  }

  _enumToString() {
    switch (status) {
      case ClienStatus.active:
        return 'Activo/a';
      case ClienStatus.inactive:
        return 'Inactivo/a';
      default:
        return 'Bloqueado/a';
    }
  }

  Color _backgroundColor() {
    switch (status) 
    {
      case ClienStatus.active:
        return const Color.fromRGBO(48, 204, 112, 1.0);
      case ClienStatus.inactive:
        return const Color.fromRGBO(235, 183, 50, 1);
      default:
        return const Color.fromRGBO(239, 93, 93, 1.0);
    }
  }
}