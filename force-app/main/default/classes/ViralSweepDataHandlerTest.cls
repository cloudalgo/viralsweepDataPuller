/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */

@isTest
public class ViralSweepDataHandlerTest {
  @istest
  private static void testInsertData() {
    Test.setMock(HttpCalloutMock.class, new ViralSweepAPICalloutMockImpl());

    //getbrands
   //TODO Add your test code for data insertion
  }
}
