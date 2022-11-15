
/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */
public class ViralSweepDataHandler {
  public static void insertData(
    ViralSweepDataPullQueue queueObj,
    ViralSweepEntries vEntries
  ) {
    System.debug(' queueObj.currentBrand' + queueObj.currentBrand);
    System.debug(' vEntries.' + vEntries);
    System.debug(' queueObj.' + queueObj);
    //TODO Add your custom logic here for inserting data based on your need. 
    // vEntries have the actual entries and 
    // queueObj does have state and other related parameters

  }
}
