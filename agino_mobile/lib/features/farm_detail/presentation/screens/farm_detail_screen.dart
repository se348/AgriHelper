import '../../domain/entities/notification_entity.dart';
import '../widgets/fields_widget.dart';
import '../widgets/no_field_widget.dart';

import '../bloc/farm_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/theme/app_colors.dart';
import '../../../../injection_container.dart';

class FarmDetailScreen extends StatelessWidget {
  const FarmDetailScreen({super.key, required this.farmid});
  final int farmid;

  void onAddPressed(BuildContext context) {
    context.push("/create-field/$farmid");
  }

  Widget buildNotificationsWidget(
      BuildContext context, List<NotificationEntity> notifications) {
    return Column(
        children: [
          for (var notification in notifications)
          ListTile(
            leading: const Icon(Icons.warning_amber),
            title: Text(
              notification.message,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FarmDetailBloc>()..add(GetFarmDetail(farmid)),
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
          body: BlocBuilder<FarmDetailBloc, FarmDetailState>(
            builder: (context, state) {
              if (state is FarmDetailLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Image.asset("assets/farm 1.png"),
                        title: Text(state.farmDetail.name,
                            style: Theme.of(context).textTheme.bodyMedium),
                        trailing: const Icon(Icons.more_vert),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      if (state.farmDetail.notifications != null &&
                          state.farmDetail.notifications!.isNotEmpty)
                        buildNotificationsWidget(
                            context, state.farmDetail.notifications!),
                      if (state.farmDetail.fields.isEmpty)
                        NoFieldWidget(
                          farmId: farmid,
                        )
                      else
                        FieldsWidget(
                            field: state.farmDetail.fields, farmId: farmid)
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
