package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import damageCalculation.tools.StatIds;
   import flash.utils.getQualifiedClassName;
   
   public class ItemCriterion implements IItemCriterion, IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemCriterion));
       
      
      protected var _serverCriterionForm:String;
      
      protected var _operator:ItemCriterionOperator;
      
      protected var _criterionRef:String;
      
      protected var _criterionValue:int;
      
      protected var _criterionValueText:String;
      
      public function ItemCriterion(pCriterion:String)
      {
         super();
         this._serverCriterionForm = pCriterion;
         this.getInfos();
      }
      
      public function get inlineCriteria() : Vector.<IItemCriterion>
      {
         var criteria:Vector.<IItemCriterion> = new Vector.<IItemCriterion>();
         criteria.push(this);
         return criteria;
      }
      
      public function get criterionValue() : Object
      {
         return this._criterionValue;
      }
      
      public function get operatorText() : String
      {
         return !!this._operator ? this._operator.text : null;
      }
      
      public function get operator() : ItemCriterionOperator
      {
         return this._operator;
      }
      
      public function get isRespected() : Boolean
      {
         var player:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(!player || !player.characteristics)
         {
            return true;
         }
         return this._operator.compare(this.getCriterion(),this._criterionValue);
      }
      
      public function get text() : String
      {
         return this.buildText(false);
      }
      
      public function get textForTooltip() : String
      {
         return this.buildText(true);
      }
      
      public function get basicText() : String
      {
         return this._serverCriterionForm;
      }
      
      public function clone() : IItemCriterion
      {
         return new ItemCriterion(this.basicText);
      }
      
      private function buildText(forTooltip:Boolean = false) : String
      {
         var readableCriterionRef:String = null;
         var knownCriteriaList:Array = null;
         var index:int = 0;
         switch(this._criterionRef)
         {
            case "CM":
               readableCriterionRef = I18n.getUiText("ui.stats.movementPoints");
               break;
            case "CP":
               readableCriterionRef = I18n.getUiText("ui.stats.actionPoints");
               break;
            case "CH":
               readableCriterionRef = I18n.getUiText("ui.pvp.honourPoints");
               break;
            case "CD":
               readableCriterionRef = I18n.getUiText("ui.pvp.disgracePoints");
               break;
            case "CT":
               readableCriterionRef = I18n.getUiText("ui.stats.takleBlock");
               break;
            case "Ct":
               readableCriterionRef = I18n.getUiText("ui.stats.takleEvade");
               break;
            default:
               knownCriteriaList = ["CS","Cs","CV","Cv","CA","Ca","CI","Ci","CW","Cw","CC","Cc","PG","PJ","Pj","PM","PA","PN","PE","<NO>","PS","PR","PL","PK","Pg","Pr","Ps","Pa","PP","PZ","CM","Qa","CP","ca","cc","ci","cs","cv","cw","Pl"];
               index = knownCriteriaList.indexOf(this._criterionRef);
               if(index > -1)
               {
                  readableCriterionRef = I18n.getUiText("ui.item.characteristics").split(",")[index];
               }
               else
               {
                  _log.warn("Unknown criteria \'" + this._criterionRef + "\'");
               }
         }
         if(forTooltip)
         {
            return index > -1 ? readableCriterionRef + " " + "<span class=\'#valueCssClass\'>" + this._operator.text + " " + this._criterionValue + "</span>" : null;
         }
         return readableCriterionRef + " " + this._operator.text + " " + this._criterionValue;
      }
      
      protected function getInfos() : void
      {
         var operator:String = null;
         for each(operator in ItemCriterionOperator.OPERATORS_LIST)
         {
            if(this._serverCriterionForm.indexOf(operator) == 2)
            {
               this._operator = new ItemCriterionOperator(operator);
               this._criterionRef = this._serverCriterionForm.split(operator)[0];
               this._criterionValue = this._serverCriterionForm.split(operator)[1];
               this._criterionValueText = this._serverCriterionForm.split(operator)[1];
               break;
            }
         }
      }
      
      protected function getCriterion() : int
      {
         var criterion:int = 0;
         var stat:EntityStat = null;
         var player:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         var statsManager:StatsManager = StatsManager.getInstance();
         if(statsManager === null)
         {
            return 0;
         }
         var stats:EntityStats = statsManager.getStats(player.id);
         if(stats === null)
         {
            return 0;
         }
         switch(this._criterionRef)
         {
            case "Ca":
               criterion = stats.getStatBaseValue(StatIds.AGILITY);
               break;
            case "CA":
               criterion = stats.getStatTotalValue(StatIds.AGILITY);
               break;
            case "Cc":
               criterion = stats.getStatBaseValue(StatIds.CHANCE);
               break;
            case "CC":
               criterion = stats.getStatTotalValue(StatIds.CHANCE);
               break;
            case "Ce":
               criterion = stats.getStatBaseValue(StatIds.ENERGY_POINTS);
               break;
            case "CE":
               criterion = stats.getStatTotalValue(StatIds.MAX_ENERGY_POINTS);
               break;
            case "CH":
               criterion = stats.getStatTotalValue(StatIds.HONOUR_POINTS);
               break;
            case "Ci":
               criterion = stats.getStatBaseValue(StatIds.INTELLIGENCE);
               break;
            case "CI":
               criterion = stats.getStatTotalValue(StatIds.INTELLIGENCE);
               break;
            case "CL":
               criterion = stats.getHealthPoints();
               break;
            case "CM":
               criterion = stats.getStatTotalValue(StatIds.MOVEMENT_POINTS);
               break;
            case "CP":
               criterion = stats.getStatTotalValue(StatIds.ACTION_POINTS);
               break;
            case "Cs":
               criterion = stats.getStatBaseValue(StatIds.STRENGTH);
               break;
            case "CS":
               criterion = stats.getStatTotalValue(StatIds.STRENGTH);
               break;
            case "Cv":
               criterion = stats.getStatBaseValue(StatIds.VITALITY);
               break;
            case "CV":
               criterion = stats.getStatTotalValue(StatIds.VITALITY);
               break;
            case "Cw":
               criterion = stats.getStatBaseValue(StatIds.WISDOM);
               break;
            case "CW":
               criterion = stats.getStatTotalValue(StatIds.WISDOM);
               break;
            case "Ct":
               criterion = stats.getStatTotalValue(StatIds.TACKLE_EVADE);
               break;
            case "CT":
               criterion = stats.getStatTotalValue(StatIds.TACKLE_BLOCK);
               break;
            case "ca":
               criterion = stats.getStatAdditionalValue(StatIds.AGILITY);
               break;
            case "cc":
               criterion = stats.getStatAdditionalValue(StatIds.CHANCE);
               break;
            case "ci":
               criterion = stats.getStatAdditionalValue(StatIds.INTELLIGENCE);
               break;
            case "cs":
               criterion = stats.getStatAdditionalValue(StatIds.STRENGTH);
               break;
            case "cv":
               criterion = stats.getStatAdditionalValue(StatIds.VITALITY);
               break;
            case "cw":
               criterion = stats.getStatAdditionalValue(StatIds.WISDOM);
         }
         return criterion;
      }
   }
}
