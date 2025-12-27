import 'package:chatter_matter_app/application/model/journal_model.dart';
import 'package:chatter_matter_app/common/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application/model/question_model.dart';
import '../application/repo/journal_repo.dart';
import '../providers/journal_provider.dart';
import 'colors.dart';
import 'custom_input.dart';
import 'custom_text_style.dart';
import 'padding.dart';

class CustomQuestionTile extends StatefulWidget {
  const CustomQuestionTile({
    super.key,
    required this.question,
    required this.index,
    this.bg,
    this.bgImage,
    required this.isFavorite,
    required this.onTapFav,
  });
  final Question question;
  final Color? bg;
  final String? bgImage;
  final int index;
  final bool isFavorite;
  final VoidCallback onTapFav;

  @override
  State<CustomQuestionTile> createState() => _CustomQuestionTileState();
}

class _CustomQuestionTileState extends State<CustomQuestionTile> {
  String ans = "";
  bool isLoading = false;
  final journalRepo = JournalRepo();

  void addJournal() async {
    setState(() {
      isLoading = true;
    });
    final check = await Provider.of<JournalProvider>(context, listen: false)
        .addJournal(
          ans: ans,
          question: widget.question.title,
          questionId: widget.question.id,
        );
    if (check != null && context.mounted) {
      ans = "";
      showToast(
        context: context,
        title: "successfully added the journal",
        toastType: ToastType.success,
      );
    }
    if (check == null && context.mounted) {
      showToast(
        context: context,
        title: "Unable to add the journal",
        toastType: ToastType.failed,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      decoration: BoxDecoration(
        color: widget.bg ?? Color(0xffC18DD9),
        borderRadius: BorderRadius.circular(defaultRadius),
      ),

      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              widget.bgImage ?? "assets/image/default_question_bg.png",
            ),
          ),

          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xffFAF5FF),
                        ),
                        child: Text(
                          "Question #${widget.index + 1}",
                          style: bodyLarge(color: customDarkPurple),
                        ),
                      ),
                      hPadExp,
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Color(0xffFAF5FF),
                        ),
                        child: Icon(Icons.share, color: customLightPurple),
                      ),
                      hPad10,
                      InkWell(
                        onTap: widget.onTapFav,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xffFAF5FF),
                          ),
                          child: Icon(
                            widget.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: customLightPurple,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    widget.question.title,
                    style: titleSmall(color: customWhite),
                    maxLines: 4,
                  ),

                  Row(
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        color: const Color(0xffE0E0E0),
                      ),

                      Text(
                        "Your Thoughts",
                        style: bodyLarge(color: const Color(0xffE0E0E0)),
                      ),
                    ],
                  ),

                  customInput(
                    hintText: "Write Your Thoughts..",
                    isEnable: !isLoading,
                    initialValue: ans,
                    onChange: (e) {
                      ans = e;
                    },
                    fill: true,
                    maxLine: 3,
                  ),

                  InkWell(
                    enableFeedback: true,
                    onTap: () => addJournal(),
                    // onTap: journalProvider.addingHomeJournal
                    //     ? null
                    //     : () async {
                    //         journalProvider.addJournal(
                    //           question: "question",
                    //           ans: ans,
                    //           isHome: true,
                    //         );
                    //       },
                    child: Container(
                      height: 50,
                      width: isLoading ? 150 : null,
                      // alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      decoration: BoxDecoration(
                        color: customLightPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 16,
                              children: [
                                Icon(
                                  Icons.menu_book_rounded,
                                  color: customWhite,
                                ),

                                Text(
                                  "Save To Journal",
                                  style: bodyLarge(color: customWhite),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
