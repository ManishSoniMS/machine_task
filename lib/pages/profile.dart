import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_task/bloc/auth/auth_bloc.dart';
import 'package:machine_task/widgets/custom_cached_network_image_widget.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final user = authBloc.state as Authenticated;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: const CustomCachedNetworkImageWidget(
                  imageUrl: "", height: 150, width: 150),
            ),
            const SizedBox(height: 30),
            Text(
              user.user.email,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authBloc.add(const AuthEvent.logout());
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Log out success!")));
              },
              child: const Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
