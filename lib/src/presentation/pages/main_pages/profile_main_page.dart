import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_presensi/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';

class ProfileMainPage extends StatelessWidget {
  const ProfileMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(height: 24,),
          const SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1682965636199-091797901722?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
              radius: 100,
            ),
          ),
          const SizedBox(height: 16,),
          Text(
            'Dicky Satria Gemilang',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4,),
          Text(
            'XII Science',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorStyle.darkGrey),
          ),
          const SizedBox(height: 48,),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                    child: Row(
                      children: [
                        const Icon(Icons.settings_outlined,),
                        const SizedBox(width: 16,),
                        Text(
                          'Setting',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 5.0,),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    BlocProvider.of<AuthCubit>(context).loggedOut();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                    child: Row(
                      children: [
                        const Icon(Icons.logout_outlined,),
                        const SizedBox(width: 16,),
                        Text(
                          'Logout',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}