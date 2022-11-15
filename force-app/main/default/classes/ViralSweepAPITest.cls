/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */

@isTest
public class ViralSweepAPITest {
  @isTest
  private static void testGetBrnads() {
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new ViralSweepAPICalloutMockImpl());
    ViralSweepBrands brandsObj = ViralSweepAPI.getBrands();
    List<ViralSweepBrands.Brand> listOfBrands = new List<ViralSweepBrands.Brand>();
    listOfBrands.addAll(brandsObj.brands);
    ViralSweepBrands.Brand brand = listOfBrands.get(0);
    System.assertEquals(true, brand.equals(brand));
    brandsObj.removeBrand(brand);
    System.assertEquals(0, brandsObj.brands.size());
    System.assertEquals('Test Brand', brand.name);
    System.assertEquals(40541, brand.id);
    System.assertEquals(40541, brand.hashCode());
    Test.stopTest();
  }

  @isTest
  private static void testGetBrnadsNegatve() {
    Test.setMock(HttpCalloutMock.class, new ViralSweepAPICalloutMockImpl(500));
    try {
      ViralSweepBrands brandsObj = ViralSweepAPI.getBrands();
    } catch (ViralSweepAPI.ViralSweepApiException ex) {
      System.assertEquals(true, String.isNotBlank(ex.getMessage()));
    }
  }

  @isTest
  private static void testGetPromotion() {
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new ViralSweepAPICalloutMockImpl());
    ViralSweepBrands brandsObj = ViralSweepAPI.getBrands();
    List<ViralSweepBrands.Brand> listOfBrands = new List<ViralSweepBrands.Brand>();
    listOfBrands.addAll(brandsObj.brands);
    ViralSweepBrands.Brand brand = listOfBrands.get(0);
    ViralSweepPromotions promotionObj = ViralSweepAPI.getPromotions(
      '' + brand.id
    );

    List<ViralSweepPromotions.Promotion> listOfPromotion = new List<ViralSweepPromotions.Promotion>();
    listOfPromotion.addAll(promotionObj.promotions);
    ViralSweepPromotions.Promotion promotion = listOfPromotion.get(0);
    System.assertEquals(true, promotion.equals(promotion));
    promotionObj.removePromotion(promotion);
    System.assertEquals(5, promotionObj.promotions.size());
    System.assertEquals('contest - win test!', promotion.title);
    System.assertEquals('123123', promotion.id);
    System.assertEquals(123123, promotion.hashCode());
    Test.stopTest();
  }

  @isTest
  private static void testGetPromotionNegative() {
    Test.setMock(HttpCalloutMock.class, new ViralSweepAPICalloutMockImpl());
    try {
      ViralSweepBrands brandsObj = ViralSweepAPI.getBrands();
      List<ViralSweepBrands.Brand> listOfBrands = new List<ViralSweepBrands.Brand>();
      listOfBrands.addAll(brandsObj.brands);
      ViralSweepBrands.Brand brand = listOfBrands.get(0);
      Test.setMock(
        HttpCalloutMock.class,
        new ViralSweepAPICalloutMockImpl(500)
      );
      ViralSweepPromotions promotionObj = ViralSweepAPI.getPromotions(
        '' + brand.id
      );
    } catch (ViralSweepAPI.ViralSweepApiException ex) {
      System.assertEquals(true, String.isNotBlank(ex.getMessage()));
    }
  }

  @isTest
  private static void testGetEntries() {
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new ViralSweepAPICalloutMockImpl());
    ViralSweepBrands brandsObj = ViralSweepAPI.getBrands();
    List<ViralSweepBrands.Brand> listOfBrands = new List<ViralSweepBrands.Brand>();
    listOfBrands.addAll(brandsObj.brands);
    ViralSweepBrands.Brand brand = listOfBrands.get(0);
    ViralSweepPromotions promotionObj = ViralSweepAPI.getPromotions(
      '' + brand.id
    );

    List<ViralSweepPromotions.Promotion> listOfPromotion = new List<ViralSweepPromotions.Promotion>();
    listOfPromotion.addAll(promotionObj.promotions);
    ViralSweepPromotions.Promotion promotion = listOfPromotion.get(0);
    System.assertEquals(true, promotion.equals(promotion));

    promotionObj.removePromotion(promotion);
    ViralSweepEntries entriesObj = ViralSweepAPI.getEntries(
      promotion.id,
      25,
      1
    );
    ViralSweepEntries.Entry entry = entriesObj.entries.get(0);
    entry.utm_source = 'ViralSweep';
    System.debug(entry);
    System.assertEquals('test1@test1.com', entry.email);
    System.assertEquals(5, entry.fields.keySet().size());
    System.assertEquals('ViralSweep', entry.utm_source);
    Test.stopTest();
  }

  @isTest
  private static void testGetEntriesNegative() {
    Test.setMock(HttpCalloutMock.class, new ViralSweepAPICalloutMockImpl());
    try {
      ViralSweepBrands brandsObj = ViralSweepAPI.getBrands();
      List<ViralSweepBrands.Brand> listOfBrands = new List<ViralSweepBrands.Brand>();
      listOfBrands.addAll(brandsObj.brands);
      ViralSweepBrands.Brand brand = listOfBrands.get(0);
      ViralSweepPromotions promotionObj = ViralSweepAPI.getPromotions(
        '' + brand.id
      );

      List<ViralSweepPromotions.Promotion> listOfPromotion = new List<ViralSweepPromotions.Promotion>();
      listOfPromotion.addAll(promotionObj.promotions);
      ViralSweepPromotions.Promotion promotion = listOfPromotion.get(0);
      System.assertEquals(true, promotion.equals(promotion));

      promotionObj.removePromotion(promotion);
      Test.setMock(
        HttpCalloutMock.class,
        new ViralSweepAPICalloutMockImpl(500)
      );
      ViralSweepEntries entriesObj = ViralSweepAPI.getEntries(
        promotion.id,
        25,
        1
      );
    } catch (ViralSweepAPI.ViralSweepApiException ex) {
      System.assertEquals(true, String.isNotBlank(ex.getMessage()));
    }
  }
}
