package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class ItemCriterionFactory implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemCriterionFactory));
       
      
      public function ItemCriterionFactory()
      {
         super();
      }
      
      public static function create(pServerCriterionForm:String) : ItemCriterion
      {
         var criterion:ItemCriterion = null;
         var s:String = pServerCriterionForm.slice(0,2);
         switch(s)
         {
            case "Ar":
               criterion = new AchievementPioneerItemCriterion(pServerCriterionForm);
               break;
            case "BI":
               criterion = new UnusableItemCriterion(pServerCriterionForm);
               break;
            case "Ca":
            case "CA":
            case "ca":
            case "Cc":
            case "CC":
            case "cc":
            case "CD":
            case "Ce":
            case "CE":
            case "CH":
            case "Ci":
            case "CI":
            case "ci":
            case "CL":
            case "CM":
            case "CP":
            case "Cs":
            case "CS":
            case "cs":
            case "Ct":
            case "CT":
            case "Cv":
            case "CV":
            case "cv":
            case "Cw":
            case "CW":
            case "cw":
               criterion = new ItemCriterion(pServerCriterionForm);
               break;
            case "EA":
               criterion = new MonsterGroupChallengeCriterion(pServerCriterionForm);
               break;
            case "EB":
               criterion = new NumberOfMountBirthedCriterion(pServerCriterionForm);
               break;
            case "Ec":
               criterion = new NumberOfItemMadeCriterion(pServerCriterionForm);
               break;
            case "Eu":
               criterion = new RuneByBreakingItemCriterion(pServerCriterionForm);
               break;
            case "GM":
               criterion = new GuildMasterItemCriterion(pServerCriterionForm);
               break;
            case "Kd":
               criterion = new Arena1V1LeagueCriterion(pServerCriterionForm);
               break;
            case "KD":
               criterion = new ArenaMax1V1LeagueCriterion(pServerCriterionForm);
               break;
            case "Ks":
               criterion = new Arena2V2LeagueCriterion(pServerCriterionForm);
               break;
            case "KS":
               criterion = new ArenaMax2V2LeagueCriterion(pServerCriterionForm);
               break;
            case "Kt":
               criterion = new Arena3V3LeagueCriterion(pServerCriterionForm);
               break;
            case "KT":
               criterion = new ArenaMax3V3LeagueCriterion(pServerCriterionForm);
               break;
            case "MK":
               criterion = new MapCharactersItemCriterion(pServerCriterionForm);
               break;
            case "Mp":
               criterion = new PrismOnMapStateItemCriterion(pServerCriterionForm);
               break;
            case "Oa":
               criterion = new AchievementPointsItemCriterion(pServerCriterionForm);
               break;
            case "OA":
               criterion = new AchievementItemCriterion(pServerCriterionForm);
               break;
            case "Ob":
               criterion = new AchievementAccountItemCriterion(pServerCriterionForm);
               break;
            case "Of":
               criterion = new MountFamilyItemCriterion(pServerCriterionForm);
               break;
            case "OH":
               criterion = new NewHavenbagItemCriterion(pServerCriterionForm);
               break;
            case "OO":
               criterion = new AchievementObjectiveValidated(pServerCriterionForm);
               break;
            case "Os":
               criterion = new SmileyPackItemCriterion(pServerCriterionForm);
               break;
            case "OV":
               criterion = new SubscriptionDurationItemCriterion(pServerCriterionForm);
               break;
            case "Ow":
               criterion = new AllianceItemCriterion(pServerCriterionForm);
               break;
            case "AM":
               criterion = new AllianceMasterItemCriterion(pServerCriterionForm);
               break;
            case "Ox":
               criterion = new AllianceRightsItemCriterion(pServerCriterionForm);
               break;
            case "Oz":
               criterion = new AllianceAvAItemCriterion(pServerCriterionForm);
               break;
            case "Pa":
               criterion = new AlignmentLevelItemCriterion(pServerCriterionForm);
               break;
            case "PA":
               criterion = new SoulStoneItemCriterion(pServerCriterionForm);
               break;
            case "Pb":
               criterion = new FriendlistItemCriterion(pServerCriterionForm);
               break;
            case "PB":
               criterion = new SubareaItemCriterion(pServerCriterionForm);
               break;
            case "Pe":
               criterion = new PremiumAccountItemCriterion(pServerCriterionForm);
               break;
            case "PE":
               criterion = new EmoteItemCriterion(pServerCriterionForm);
               break;
            case "Pf":
               criterion = new RideItemCriterion(pServerCriterionForm);
               break;
            case "Pg":
               criterion = new GiftItemCriterion(pServerCriterionForm);
               break;
            case "PG":
               criterion = new BreedItemCriterion(pServerCriterionForm);
               break;
            case "Pi":
            case "PI":
               criterion = new SkillItemCriterion(pServerCriterionForm);
               break;
            case "PJ":
            case "Pj":
               criterion = new JobItemCriterion(pServerCriterionForm);
               break;
            case "Pk":
               criterion = new BonusSetItemCriterion(pServerCriterionForm);
               break;
            case "PK":
               criterion = new KamaItemCriterion(pServerCriterionForm);
               break;
            case "PL":
               criterion = new LevelItemCriterion(pServerCriterionForm);
               break;
            case "Pl":
               criterion = new PrestigeLevelItemCriterion(pServerCriterionForm);
               break;
            case "Pm":
               criterion = new MapItemCriterion(pServerCriterionForm);
               break;
            case "PN":
               criterion = new NameItemCriterion(pServerCriterionForm);
               break;
            case "PO":
               criterion = new ObjectItemCriterion(pServerCriterionForm);
               break;
            case "Po":
               criterion = new AreaItemCriterion(pServerCriterionForm);
               break;
            case "Pp":
            case "PP":
               criterion = new PVPRankItemCriterion(pServerCriterionForm);
               break;
            case "Pr":
               criterion = new SpecializationItemCriterion(pServerCriterionForm);
               break;
            case "PR":
               criterion = new MariedItemCriterion(pServerCriterionForm);
               break;
            case "Ps":
               criterion = new AlignmentItemCriterion(pServerCriterionForm);
               break;
            case "PS":
               criterion = new SexItemCriterion(pServerCriterionForm);
               break;
            case "PT":
               criterion = new SpellItemCriterion(pServerCriterionForm);
               break;
            case "PU":
               criterion = new BonesItemCriterion(pServerCriterionForm);
               break;
            case "Pw":
               criterion = new GuildItemCriterion(pServerCriterionForm);
               break;
            case "PW":
               criterion = new WeightItemCriterion(pServerCriterionForm);
               break;
            case "Px":
               criterion = new GuildRightsItemCriterion(pServerCriterionForm);
               break;
            case "PX":
               criterion = new AccountRightsItemCriterion(pServerCriterionForm);
               break;
            case "Py":
               criterion = new GuildLevelItemCriterion(pServerCriterionForm);
               break;
            case "Pz":
               break;
            case "PZ":
               criterion = new SubscribeItemCriterion(pServerCriterionForm);
               break;
            case "Qa":
            case "Qc":
            case "Qf":
               criterion = new QuestItemCriterion(pServerCriterionForm);
               break;
            case "Qo":
               criterion = new QuestObjectiveItemCriterion(pServerCriterionForm);
               break;
            case "SC":
               criterion = new ServerTypeItemCriterion(pServerCriterionForm);
               break;
            case "Sc":
               criterion = new StaticCriterionItemCriterion(pServerCriterionForm);
               break;
            case "Sd":
               criterion = new DayItemCriterion(pServerCriterionForm);
               break;
            case "SG":
               criterion = new MonthItemCriterion(pServerCriterionForm);
               break;
            case "SI":
               criterion = new ServerItemCriterion(pServerCriterionForm);
               break;
            case "SL":
               criterion = new SubareaLevelItemCriterion(pServerCriterionForm);
               break;
            case "ST":
               criterion = new SeasonCriterion(pServerCriterionForm);
               break;
            case "Sy":
               criterion = new CommunityItemCriterion(pServerCriterionForm);
               break;
            case "HS":
               criterion = new StateCriterion(pServerCriterionForm);
               break;
            case "HA":
               criterion = new AlterationCriterion(pServerCriterionForm);
               break;
            case "OS":
               criterion = new OnlySetCriterion(pServerCriterionForm);
               break;
            case "So":
               criterion = new OptionalFeatureEnabledCriterion(pServerCriterionForm);
               break;
            default:
               _log.warn("Criterion \'" + s + "\' unknow or unused (" + pServerCriterionForm + ")");
         }
         return criterion;
      }
   }
}
