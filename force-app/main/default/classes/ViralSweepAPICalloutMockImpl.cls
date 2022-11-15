/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */

@isTest
public class ViralSweepAPICalloutMockImpl implements HttpCalloutMock {
  Integer statusCode;
  public ViralSweepAPICalloutMockImpl(Integer pStatusCode) {
    this.statusCode = pStatusCode;
  }
  public ViralSweepAPICalloutMockImpl() {
    this.statusCode = 200;
  }

  public HTTPResponse respond(HTTPRequest req) {
    HttpResponse res = new HttpResponse();
    res.setHeader('Content-Type', 'application/json');

    System.debug('req.getEndpoint()' + req.getEndpoint());
    if (req.getEndpoint().contains('brands')) {
      res.setBody('{"brands":[{"id":40541,"name":"Test Brand"}]}');
    }
    if (req.getEndpoint().contains('promotions')) {
      res.setBody(
        '{"promotions":[{"id":"123123","title":"contest - win test!","start_ts":1666828800,"end_ts":1683158340,"type":"sweeps","timezone":"(GMT-05:00) Eastern Time (US & Canada)"},{"id":"122748","title":"test hashtag","start_ts":1666014199,"end_ts":1981374199,"type":"hashtag","timezone":""},{"id":"122747","title":"test","start_ts":1665999733,"end_ts":1981359733,"type":"email","timezone":"(GMT-05:00) Eastern Time (US & Canada)"},{"id":"122538","title":"Next Campaign","start_ts":1665532800,"end_ts":1667260740,"type":"email","timezone":"(GMT-05:00) Eastern Time (US & Canada)"},{"id":"122205","title":"This is test email&nbsp;","start_ts":1665014400,"end_ts":1667001540,"type":"email","timezone":"(GMT-05:00) Eastern Time (US & Canada)"},{"id":"90454","title":"win a toast","start_ts":1625702400,"end_ts":1666828800,"type":"sweeps","timezone":"(GMT-05:00) Eastern Time (US & Canada)"}]}'
      );
    }
    if (req.getEndpoint().contains('entries')) {
      res.setBody(
        '{"entries":[{"email":"test1@test1.com","entered_ts":1665146608,"location":"Jaipur, India","ip":"49.36.235.9","entries_total":"1","referrals_count":"0","short_url":"https://swee.ps/1665146608","fields":{"rfid":"","cpid":"","email":"test1@test1.com","first_name":"test1","last_name":"test1"},"bonus":[{"title":"Entering","entries":1,"time":"","extra":""}],"login_link":"https://app.viralsweep.com/ain/1665146608/1665146608/1665146608","referred_by":""},{"email":"test2@test.com","entered_ts":1665647933,"location":"test2, India","ip":"49.36.235.9","entries_total":"1","referrals_count":"0","short_url":"https://swee.ps/test2","fields":{"rfid":"","cpid":"","email":"test2@test.com","first_name":"test2","last_name":"test2"},"bonus":[{"title":"Entering","entries":1,"time":"","extra":""}],"login_link":"https://app.viralsweep.com/ain/test2/test2/test2","referred_by":""},{"email":"test3@gmail.com","entered_ts":1665648048,"location":"test3, India","ip":"49.36.235.9","entries_total":"1","referrals_count":"0","short_url":"https://swee.ps/gmail","fields":{"rfid":"","cpid":"","email":"test3+123@gmail.com","first_name":"test3","last_name":"sic","58053_1665662368":"12312"},"bonus":[{"title":"Entering","entries":1,"time":"","extra":""}],"login_link":"https://app.viralsweep.com/ain/test3/test3/test3","referred_by":""},{"email":"test4@gmail.com","entered_ts":1665650290,"location":"test4, India","ip":"49.36.235.9","entries_total":"1","referrals_count":"0","short_url":"https://swee.ps/test4","fields":{"rfid":"","cpid":"","email":"test4@test4.com","first_name":"test4","last_name":"test4"},"bonus":[{"title":"Entering","entries":1,"time":"","extra":""}],"login_link":"https://app.viralsweep.com/ain/test4/test4/test4","referred_by":""},{"email":"1231231234444","entered_ts":1666072807,"location":"Jaipur, India","ip":"49.36.235.9","entries_total":"1","referrals_count":"0","short_url":"https://swee.ps/test4","fields":{"rfid":"","cpid":"","first_name":"test4","last_name":"test4","phone":"+91 1231231234444","email":"1231231234444"},"bonus":[{"title":"Entering","entries":1,"time":"","extra":""}],"login_link":"https://app.viralsweep.com/ain/test4/test4/test4","referred_by":""}]}'
      );
    }
    res.setStatusCode(statusCode);
    return res;
  }
}
