import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/Views/kpiDetails/kpi_details_screen.dart';
import 'package:flutter_salesman_module/Views/perfectGuideline/perfect_guideline_main_screen.dart';
import 'package:flutter_salesman_module/Views/storeAudit/store_audit_screen.dart';
import 'package:flutter_salesman_module/utils/route/routes.dart';

import '../../Views/login/login_screen.dart';
import '../../Views/mainScreen/main_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.logInScreen:
        return _buildPageRoute(const LoginScreen());
      case Routes.mainScreen:
        return _buildPageRoute(const MainScreen());
      case Routes.perfectGuidelineScreen:
        return _buildPageRoute(const PerfectGuidelineMainScreen());
      case Routes.storeAuditScreen:
        if (arguments is Map<String, dynamic>) {
          return _buildPageRoute(
            StoreAuditScreen(
              channelId: arguments['channelId'],
              customerName: arguments['customerName'],
              customerId: arguments['customerId'],
              customerPicture: arguments['customerPicture'],
              customer: arguments['customer'],
              isImageMandatory: arguments['isImageMandatory'],
            ),
          );
        } else {
          return MaterialPageRoute(builder: (_) => Container());
        }
      case Routes.kpiDetailsScreen:
        if (arguments is Map<String, dynamic>) {
          return _buildPageRoute(
            KpiDetailsScreen(
              index: arguments['index'],
              item: arguments['items'],
              customerId: arguments['customerId'],
            ),
          );
        } else {
          return MaterialPageRoute(builder: (_) => Container());
        }

      //  case Routes.productDetailsScreen:
      //    if (arguments is Map<String, dynamic>) {
      //      return _buildPageRoute( ProductDetailsScreen(
      //        productList: arguments['productList'],
      //      ));
      //    } else {
      //      return MaterialPageRoute(builder: (_) => Container());
      //    }

      /*   case Routes.homePage:
        return _buildPageRoute(const Homepage());
        case Routes.locationListPage:
        return _buildPageRoute(const LocationListPage());
        case Routes.fullScreenImage:
          if (arguments is Map<String, dynamic>) {
            return _buildPageRoute( FullScreenImage(
              initialIndex: arguments['initialIndex'],
              heroTag: arguments['heroTag'],
              imageUrls: arguments['imageUrls'],
            ));
          } else {
            return MaterialPageRoute(builder: (_) => Container());
          }
      case Routes.postDetailsScreen:
        if (arguments is Map<String, dynamic>) {
          return _buildPageRoute( PostDetailsScreen(
            index: arguments['index'],
            heroTag: arguments['heroTag'],
            posts: arguments['posts'],
          ));
        } else {
          return MaterialPageRoute(builder: (_) => Container());
        }*/

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }

  PageRouteBuilder _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // From the right
        const end = Offset.zero; // To the center
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        // Fade transition
        var opacityAnimation = animation.drive(Tween(begin: 0.0, end: 1.0));

        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(opacity: opacityAnimation, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
