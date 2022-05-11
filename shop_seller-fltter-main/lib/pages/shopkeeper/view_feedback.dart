import 'package:flutter/material.dart';
import 'package:shop_seller/models/feedback.dart';
import 'package:shop_seller/utils/constant.dart';
import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/feedback_card.dart';

class ViewFeedback extends StatelessWidget {
  const ViewFeedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View feedback"),
      ),
      body: FutureBuilder(
          future: getfeedback(),
          builder: (context, AsyncSnapshot<List<Feedbacks>> snapshot) {
            if (snapshot.hasData) {
              List<Feedbacks>? feedbacks = snapshot.data;
              return ListView.builder(
                  itemCount: feedbacks!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Feedbacks feedback = feedbacks.elementAt(index);
                    return FeedbackCard(
                      title: feedback.name!,
                      subtitle: feedback.feedback!,
                    );
                  });
            } else {
              return const Center(
                child: Text("loading..."),
              );
            }
          }),
    );
  }

  Future<List<Feedbacks>> getfeedback() async {
    String user_id = await Constants.getUserId();
    List json =
        await getData("view_feedback.php", params: {"user_id": user_id});
    // print(json);
    return json.map((e) => Feedbacks.fromJson(e)).toList();
  }
}
