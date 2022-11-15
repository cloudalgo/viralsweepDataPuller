/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */
public class ViralSweepAPI {
  //Make sure viralsweep as namedcreds should be in named cred with required setup - visit https://www.viralsweep.com/api/#authentication
  public static String brandsUrl = 'callout:viralsweep/brands';
  public static String promotionUrl = 'callout:viralsweep/promotions/';
  public static String entriesUrl = 'callout:viralsweep/entries/';

  public static ViralSweepBrands getBrands() {
    HTTPResponse hs = null;
    try {
      HttpRequest httpReq = new HttpRequest();
      httpReq.setEndpoint(brandsUrl);
      httpReq.setHeader('x-api-key', '{!$Credential.Password}');
      httpReq.setMethod('GET');
      Http http = new Http();
      hs = http.send(httpReq);
      if (hs.getStatusCode() == 200) {
        ViralSweepBrands brands = (ViralSweepBrands) JSON.deserialize(
          hs.getBody(),
          ViralSweepBrands.class
        );
        return brands;
      } else {
        throw new ViralSweepApiException(
          'Issue while fetching brands status Code ' +
          hs.getStatusCode() +
          ' Body : ' +
          hs.getBody()
        );
      }
    } catch (Exception e) {
      e.setMessage(hs.getBody() + e.getMessage());
      throw e;
    }
  }

  public static ViralSweepPromotions getPromotions(String brandId) {
    try {
      HttpRequest httpReq = new HttpRequest();
      httpReq.setEndpoint(promotionUrl + brandId);
      httpReq.setHeader('x-api-key', '{!$Credential.Password}');
      httpReq.setMethod('GET');
      Http http = new Http();
      HTTPResponse hs = http.send(httpReq);
      if (hs.getStatusCode() == 200) {
        ViralSweepPromotions promotions = (ViralSweepPromotions) JSON.deserialize(
          hs.getBody(),
          ViralSweepPromotions.class
        );
        return promotions;
      } else {
        throw new ViralSweepApiException(
          'Issue while fetching brands status Code ' +
          hs.getStatusCode() +
          ' Body : ' +
          hs.getBody()
        );
      }
    } catch (Exception e) {
      throw e;
    }
  }

  public static ViralSweepEntries getEntries(
    String promotionId,
    Integer count,
    Integer pageNumber
  ) {
    try {
      HttpRequest httpReq = new HttpRequest();
      httpReq.setEndpoint(
        entriesUrl +
        promotionId +
        '?count=' +
        count +
        '&page=' +
        pageNumber
      );
      httpReq.setHeader('x-api-key', '{!$Credential.Password}');
      httpReq.setMethod('GET');
      Http http = new Http();
      HTTPResponse hs = http.send(httpReq);
      if (hs.getStatusCode() == 200) {
        ViralSweepEntries entries = (ViralSweepEntries) JSON.deserialize(
          hs.getBody(),
          ViralSweepEntries.class
        );
        return entries;
      } else {
        throw new ViralSweepApiException(
          'Issue while fetching brands status Code ' +
          hs.getStatusCode() +
          ' Body : ' +
          hs.getBody()
        );
      }
    } catch (Exception e) {
      throw e;
    }
  }

  public class ViralSweepApiException extends Exception {
  }
}