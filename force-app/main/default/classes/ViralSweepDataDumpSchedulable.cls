/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */

public class ViralSweepDataDumpSchedulable implements Schedulable {
  public void execute(SchedulableContext sc) {
    String jobId = !Test.isRunningTest()? System.enqueueJob(new ViralSweepDataPullQueue()) : null;
  }
}