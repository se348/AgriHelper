import 'package:agino_mobile/features/farm/presentation/widgets/farm_lists_widget.dart';
import 'package:agino_mobile/features/farm/presentation/widgets/no_farm_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../injection_container.dart';
import '../bloc/farm_bloc/farm_bloc.dart';


class FarmListScreen extends StatelessWidget {
  void refreshPage(BuildContext context) {
    BlocProvider.of<FarmBloc>(context).add(GetAllFarms());
  }

  void onAddPressed(BuildContext context) {
    context.go("/create");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FarmBloc>()..add(GetAllFarms()),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset("assets/agino_logo.png"),
          backgroundColor: AppColors.green,
          actions: [
            IconButton(
                onPressed: () {
                  onAddPressed(context);
                },
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  context.push("/profile");
                },
                icon: const Icon(Icons.person)),
          ],
        ),
        body: BlocBuilder<FarmBloc, FarmState>(builder: (context, state) {
          if (state is FarmLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MyFarmsLoaded) {
            if (state.farms.isEmpty) {
              return const NoFarmWidget();
            }
            return FarmListsWidget(farms: state.farms);
          }

          return Container();
        }),
      ),
    );
  }
}
