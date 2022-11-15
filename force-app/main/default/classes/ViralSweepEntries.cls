/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */

public class ViralSweepEntries {
  public List<Entry> entries { get; set; }

  public class Entry {
    public String email { get; set; }
    public Map<String, String> fields { get; set; }
    public String utm_source { get; set; }
  }
}
