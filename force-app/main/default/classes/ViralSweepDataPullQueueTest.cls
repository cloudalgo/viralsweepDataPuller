/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */

@isTest
public class ViralSweepDataPullQueueTest {
  /**
   * You can’t chain queueable jobs in an Apex test. Doing so results in an error. To avoid getting an error,
   * you can check if Apex is running in test context by calling Test.isRunningTest() before chaining jobs.
   * Since our class is in chaining in nature so we needs to manually set the state of object and call the method
   */
  @isTest
  private static void testQueue() {
    Test.setMock(HttpCalloutMock.class, new ViralSweepAPICalloutMockImpl());
    ViralSweepDataPullQueue obj = new ViralSweepDataPullQueue();

    //getbrands
    ViralSweepBrands brandsObj = ViralSweepAPI.getBrands();

    //getPromotions
    List<ViralSweepBrands.Brand> listOfBrands = new List<ViralSweepBrands.Brand>();
    listOfBrands.addAll(brandsObj.brands);
    ViralSweepBrands.Brand brand = listOfBrands.get(0);
    ViralSweepPromotions promotionObj = ViralSweepAPI.getPromotions(
      '' + brand.id
    );

    //getEntries
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

    //inital enqueueJob
    System.enqueueJob(obj);
    obj.brandObj = brandsObj;
    obj.state = ViralSweepDataPullQueue.currentState.STATE_PROMOTION;
    obj.currentBrand = brand;

    // second depth of enqueueJob for promotion
    System.enqueueJob(obj);

    // second depth of enqueueJob  entires
    obj.promotionObj = promotionObj;
    obj.state = ViralSweepDataPullQueue.currentState.STATE_ENTRIES;

    obj.MAX_PAGE_SIZE = 1;
    obj.pageSize = 1;
    obj.currentPage = 1;
    System.enqueueJob(obj);
  }
}
