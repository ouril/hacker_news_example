import 'package:test/test.dart';
import 'package:hacker_news_example/src/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  test("test_parser", () {
    const json =
        """{"by" : "tel","descendants" : 16,"id" : 121003,"kids" : [ 121016, 121109, 121168 ],"score" : 25,"text" : "<i>or</i> HN: the Next Iteration<p>I get the impression that with Arc being released a lot of people who never had time for HN before are suddenly dropping in more often. (PG: what are the numbers on this? I'm envisioning a spike.)<p>Not to say that isn't great, but I'm wary of Diggification. Between links comparing programming to sex and a flurry of gratuitous, ostentatious  adjectives in the headlines it's a bit concerning.<p>80% of the stuff that makes the front page is still pretty awesome, but what's in place to keep the signal/noise ratio high? Does the HN model still work as the community scales? What's in store for (++ HN)?","time" : 1203647620,"title" : "Ask HN: The Arc Effect","type" : "story","url" : ""}""";
    expect(parseArticle(json).by, "tel");
  });

  test("testing_best_stories", () async {

    final api = "https://hacker-news.firebaseio.com/v0/beststories.json";
    final response = await http.get(api);
    if (response.statusCode == 200) {
      final idListJson = json.decode(response.body);
      if (idListJson.isNotEmpty) {
        final storyUrl = "https://hacker-news.firebaseio.com/v0/item/${idListJson.first}";
        final storyRes = await http.get(storyUrl);
        if (storyRes == 200) {
          expect(parseArticle(storyRes.body).by, "MYEUHD");
        }
      }
    }
  });
}
