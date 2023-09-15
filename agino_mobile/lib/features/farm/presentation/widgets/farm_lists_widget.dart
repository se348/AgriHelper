import 'package:agino_mobile/features/farm/domain/entities/farm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg.dart';

class FarmListsWidget extends StatelessWidget {
  const FarmListsWidget({super.key, required this.farms});
  final List<Farm> farms;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: farms.length + 1,
      itemBuilder: (context, ind) {
        if (ind == 0) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 200,
                    child: SvgPicture.asset("assets/country_side.svg")),
              ),
              Text(
                "My Farms",
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          );
        }
        return ListTile(
          leading: Image.asset("assets/farm 1.png"),
          title: Text(
            farms[ind - 1].name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: () {
            context.push("/farm-detail/${farms[ind - 1].farmId}");
          },
        );
      },
      separatorBuilder: (context, index) {
        if (index == 0) {
          return Container();
        }
        return const Divider();
      },
    );
  }
}