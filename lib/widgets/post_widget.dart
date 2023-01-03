import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';
import 'package:student_club/models/post_state.dart';
import 'package:url_launcher/url_launcher.dart';

class PostWidget extends StatefulWidget {
  final String title;
  final String announcement;
  final String clubName;
  final DateTime dateTime;
  final String author;
  final PostState postState;

  const PostWidget({
    super.key,
    required this.title,
    required this.announcement,
    required this.clubName,
    required this.dateTime,
    required this.author,
    required this.postState,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  Future share() async {
    String body = widget.title + widget.announcement;
    // String twitterUrl = "twitter.com/intent/tweet?text=$body";
    String twitterUrl = "facebook.com";
    // String path = "/intent/tweet?text=$body";
    String path = "/sharer/sharer.php?t=$body";
    final Uri uri = Uri(scheme: "https", host: twitterUrl, path: path);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        // mode: LaunchMode.externalApplication,
      );
    }
  }

  PostState state = PostState.neither;
  @override
  Widget build(BuildContext context) {
    Icon like = state == PostState.neither || state == PostState.disliked
        ? const Icon(Icons.thumb_up_off_alt_outlined)
        : Icon(
            Icons.thumb_up_alt_rounded,
            color: Colors.blueGrey[600],
          );
    Icon dislike = state == PostState.neither || state == PostState.liked
        ? const Icon(Icons.thumb_down_off_alt_outlined)
        : Icon(
            Icons.thumb_down_alt_rounded,
            color: Colors.red[400],
          );

    TextStyle header = Theme.of(context).textTheme.headline3!;
    TextStyle subHeader = Theme.of(context).textTheme.bodyText2!;
    TextStyle bodyText =
        Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        // constraints: const BoxConstraints(minHeight: 250, maxHeight: 400),
        height: 280,
        child: Card(
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.title,
                          style: header,
                        ),
                        Text(
                          DateFormat('dd/MM/yy - kk:mm')
                              .format(widget.dateTime),
                          style: subHeader,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          widget.clubName,
                          style: header,
                        ),
                        Text(
                          widget.author,
                          style: subHeader,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReadMoreText(
                    widget.announcement,
                    trimLines: 4,
                    style: bodyText,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '...Show more',
                    trimExpandedText: ' show less',
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (state == PostState.liked) {
                            state = PostState.neither;
                          } else {
                            state = PostState.liked;
                          }
                        });
                      },
                      icon: like,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (state == PostState.disliked) {
                            state = PostState.neither;
                          } else {
                            state = PostState.disliked;
                          }
                        });
                      },
                      icon: dislike,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        try {
                          share();
                        } catch (e) {
                          print(e);
                        }
                      },
                      icon: const Icon(Icons.share),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
