/**
 * @Group ViralSweepDataPullerSFDX
 *
 * @author Cloudalgo
 * @date 2022-January-01
 *
 */
public class ViralSweepDataPullQueue implements Queueable, Database.AllowsCallouts {
  private void enqueueJob(ViralSweepDataPullQueue obj) {
    if (!Test.isRunningTest()) {
      System.enqueueJob(obj);
    }
  }
  public ViralSweepBrands brandObj {
    get {
      if (brandObj == null) {
        ViralSweepBrands brandObj = new ViralSweepBrands();
        brandObj.brands = new List<ViralSweepBrands.Brand>();
        return brandObj;
      } else {
        return brandObj;
      }
    }
    set;
  }
  public ViralSweepPromotions promotionObj {
    get {
      if (promotionObj == null) {
        ViralSweepPromotions promotionObj = new ViralSweepPromotions();
        promotionObj.promotions = new List<ViralSweepPromotions.Promotion>();
        return promotionObj;
      } else {
        return promotionObj;
      }
    }
    set;
  }
  public Integer currentPage { get; set; }
  public Integer pageSize { get; set; }
  public ViralSweepBrands.Brand currentBrand { get; set; }
  public ViralSweepPromotions.Promotion currentPromotion { get; set; }

  public enum currentState {
    STATE_BRNAD,
    STATE_PROMOTION,
    STATE_ENTRIES
  }

  @TestVisible
  Integer MAX_PAGE_SIZE = 25;

  public currentState state { get; set; }

  public void execute(QueueableContext context) {
    if (state == null) {
      this.state = currentState.STATE_BRNAD;
      this.currentPage = 1;
      this.pageSize = MAX_PAGE_SIZE;
    }

    switch on state {
      when STATE_BRNAD {
        this.brandObj = ViralSweepAPI.getBrands();
        if (this.brandObj.brands.size() > 0) {
          this.state = currentState.STATE_PROMOTION;
          System.debug(' this.brandObj' + this.brandObj);
          enqueueJob(this);
        } else {
          System.debug('Empty brand');
        }
      }
      when STATE_PROMOTION {
        System.debug('this.promotionObj' + this.promotionObj);
        System.debug('this.brandObj' + this.brandObj);
        if (
          this.promotionObj.promotions.size() == 0 &&
          this.brandObj.brands.size() > 0
        ) {
          for (ViralSweepBrands.Brand obj : brandObj.brands) {
            currentBrand = obj;
            break;
          }
          brandObj.removeBrand(currentBrand);
        }

        System.debug('currentBrand' + currentBrand);
        this.promotionObj = ViralSweepAPI.getPromotions('' + currentBrand.id);
        if (this.promotionObj.promotions.size() > 0) {
          this.state = currentState.STATE_ENTRIES;
          System.debug(' this.promotionObj' + this.promotionObj);
          enqueueJob(this);
        } else {
          System.debug('Empty Promotions');
        }
      }
      when STATE_ENTRIES {
        for (ViralSweepPromotions.Promotion obj : promotionObj.promotions) {
          currentPromotion = obj;
          break;
        }
        System.debug(' currentPromotion' + currentPromotion);
        ViralSweepEntries vEntries = ViralSweepAPI.getEntries(
          currentPromotion.id,
          this.pageSize,
          this.currentPage
        );
        ViralSweepDataHandler.insertData(this, vEntries);
        System.debug(' this.vEntries' + vEntries);
        if (vEntries.entries.size() > MAX_PAGE_SIZE - 1) {
          this.currentPage++;
          // remove later for testing
          enqueueJob(this);
        } else {
          this.currentPage = 1;
          promotionObj.removePromotion(currentPromotion);
          if (promotionObj.promotions.size() > 0) {
            this.state = currentState.STATE_ENTRIES;
            enqueueJob(this);
          } else {
            if (brandObj.brands.size() > 0) {
              this.state = currentState.STATE_BRNAD;
              enqueueJob(this);
            } else {
              System.debug('All done');
            }
          }
        }
      }
    }
  }
}
