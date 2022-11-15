/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */

public class ViralSweepBrands {
  public class Brand {
    public Integer id { get; set; }
    public String name { get; set; }

    public Integer hashCode() {
      return this.id;
    }

    public boolean equals(Brand obj) {
      if (obj == null) {
        return false;
      }
      if (this == obj) {
        return true;
      }
      return obj.id == this.id;
    }
  }

  public List<Brand> brands { get; set; }

  public void removeBrand(Brand obj) {
    Set<Brand> setOfBrand = new Set<Brand>();
    setOfBrand.addAll(this.brands);
    setOfBrand.remove(obj);
    this.brands = new List<Brand>();
    this.brands.addAll(setOfBrand);
  }
}
