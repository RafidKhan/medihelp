import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medihelp/components/loader_widget.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/gen/assets.gen.dart';
import 'package:medihelp/models/medicine_model.dart';
import 'package:medihelp/utils/styles.dart';

class MedicineTile extends StatelessWidget {
  MedicineModel medicineModel;
  VoidCallback onTap;

  MedicineTile({
    Key? key,
    required this.medicineModel,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: float10,
        ),
        padding: const EdgeInsets.all(
          float10,
        ),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(
              15,
            ),
            boxShadow: [defaultBoxShadow]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: LoaderWidget(
                    size: 10,
                  ),
                ),
                errorWidget: (context, url, error) {
                  return Image.asset(
                    Assets.logo.appLogo.path,
                    height: 90,
                  );
                },
                imageUrl: medicineModel.image ?? "",
                height: 100,
                width: MediaQuery.of(context).size.width / 3,
                fit: BoxFit.fill,
              ),
            ),
            TextComponent(
              medicineModel.name ?? "",
              fontSize: fontSize14,
              fontWeight: fontWeight500,
              textAlign: TextAlign.start,
              padding: const EdgeInsets.symmetric(
                vertical: float5,
              ),
            ),
            TextComponent(
              "${(medicineModel.price ?? "")} BDT",
              fontSize: fontSize12,
              fontWeight: fontWeight400,
              textAlign: TextAlign.start,
              padding: const EdgeInsets.symmetric(
                vertical: float5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
