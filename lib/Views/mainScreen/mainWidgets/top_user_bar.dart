import 'package:flutter/material.dart';
import 'package:flutter_salesman_module/utils/constants/app_assets.dart';
import 'package:flutter_salesman_module/utils/provider/login_provider.dart';
import 'package:provider/provider.dart';

class TopUserBar extends StatelessWidget {
  const TopUserBar({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final user = loginProvider.user;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipOval(
                child:
                    user?.profilePicture != null &&
                            user!.profilePicture!.isNotEmpty
                        ? Image.network(
                          user.profilePicture!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppAssets.profileImage,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                        : Image.asset(
                          AppAssets.profileImage,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
              ),
              const SizedBox(width: 10),
              Text(
                loginProvider.user!.fullName ?? "",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  backgroundColor: Colors.transparent,
                ),
                maxLines: 1,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(
            width: 30,
            child: IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black, size: 26),
              onPressed: () {
                loginProvider.logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
