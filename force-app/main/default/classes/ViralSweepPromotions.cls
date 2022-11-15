/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */
public class ViralSweepPromotions {
  public List<Promotion> promotions { get; set; }
  public class Promotion {
    public String id { get; set; }
    public String title { get; set; }

    public Integer hashCode() {
      return Integer.valueOf(this.id);
    }

    public boolean equals(Promotion obj) {
      if (obj == null) {
        return false;
      }
      if (this == obj) {
        return true;
      }
      return obj.id == this.id;
    }
  }
  public void removePromotion(Promotion obj) {
    Set<Promotion> setOfPromo = new Set<Promotion>();
    setOfPromo.addAll(this.promotions);
    setOfPromo.remove(obj);
    this.promotions = new List<Promotion>();
    this.promotions.addAll(setOfPromo);
  }
}
