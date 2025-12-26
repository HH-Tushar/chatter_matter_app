import 'package:chatter_matter_app/common/colors.dart';
import 'package:chatter_matter_app/common/custom_text_style.dart';
import 'package:chatter_matter_app/common/padding.dart';
import 'package:chatter_matter_app/common/see_%20loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/common_dialouge.dart';
import '../../providers/journal_provider.dart';

class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    final JournalProvider journalProvider = context.watch();
    return Column(
      children: [
        Text("My Journal", style: heading()),

        Text(
          "Your conversation reflections",
          style: bodyMedium(color: customDarkGray),
        ),
        vPad10,
        Expanded(
          child: journalProvider.journalList.isEmpty
              ? journalProvider.isLoading
                    ? cLoading()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("You do not have any Journal Yet"),
                          IconButton(
                            onPressed: () async =>
                                journalProvider.resetPaginator(),
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      )
              : RefreshIndicator(
                  onRefresh: () async => journalProvider.resetPaginator(),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    itemCount: journalProvider.journalList.length,
                    itemBuilder: (context, index) => _customTile(
                      ans: journalProvider.journalList[index].ans,
                      onDelete: () async {
                        final check = await showDeleteConfirmationDialog(
                          context,
                        );
                        print(check);
                        if (check == true) {
                          await journalProvider.deleteJournal(
                            journalId: journalProvider.journalList[index].id,
                          );
                        }
                      },
                      question: journalProvider.journalList[index].question,
                    ),
                  ),
                ),
        ),

        // Expanded(
        //   child: SingleChildScrollView(
        //     padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        //     child: Column(
        //       spacing: 15,
        //       children: [
        //         _customTile(),
        //         _customTile(),
        //         _customTile(),
        //         _customTile(),
        //         _customTile(),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

_customTile({
  required String question,
  required String ans,
  required VoidCallback onDelete,
}) {
  return Container(
    padding: EdgeInsets.all(13),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(defaultRadius),
      color: customWhite,
      border: Border.all(color: customLightPurple),
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Today", style: bodySmall(color: customGray)),
            GestureDetector(
              // splashRadius: 1,
              onTap: onDelete,
              child: Icon(Icons.delete_forever, color: customRed, size: 20),
            ),
          ],
        ),

        vPad10,
        Text(question, style: titleSmall()),
        vPad10,
        Text(ans, style: bodyMedium(color: customDarkGray)),
      ],
    ),
  );
}
