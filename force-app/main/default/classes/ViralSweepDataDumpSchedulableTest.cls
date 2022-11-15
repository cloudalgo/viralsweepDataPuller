/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */

@isTest
public with sharing class ViralSweepDataDumpSchedulableTest {
  private static String CRON_EXP = '0 0 0 15 3 ? 2028';
  static testMethod void testScheduledApex() {
    Test.startTest();

    String jobId = System.schedule(
      'ViralSweepDataDumpSchedulable',
      CRON_EXP,
      new ViralSweepDataDumpSchedulable()
    );
    CronTrigger ct = [
      SELECT Id, CronExpression, TimesTriggered, NextFireTime
      FROM CronTrigger
      WHERE id = :jobId
    ];
    System.assertEquals(CRON_EXP, ct.CronExpression);
    System.assertEquals(0, ct.TimesTriggered);

    Test.stopTest();
  }
}
