package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.datacenter.items.criterion.IItemCriterion;
   import flash.xml.XMLNode;
   import flash.xml.XMLNodeType;
   
   public class ConditionTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _conditions:Object;
      
      private var _titleText:String;
      
      private var _onTarget:Boolean;
      
      private var _customli:String;
      
      private var _effectCssClass:String;
      
      public function ConditionTooltipBlock(conditions:Object, titleText:String = null, onTarget:Boolean = false, chunkType:String = "chunks", customli:String = "customlirightmargin", effectCssClass:String = "requirement")
      {
         super();
         this._conditions = conditions;
         this._onTarget = onTarget;
         this._customli = customli;
         this._effectCssClass = effectCssClass;
         if(titleText)
         {
            this._titleText = titleText;
         }
         else
         {
            this._titleText = Api.ui.getText("ui.common.conditions");
         }
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("subTitle",chunkType + "/base/subTitle.txt"),Api.tooltip.createChunkData("effect",chunkType + "/effect/effect.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         var criterion:Object = null;
         var criteriaText:* = null;
         var criteriaRespected:Boolean = false;
         var criterias:Vector.<IItemCriterion> = null;
         var i:int = 0;
         var itemCrit:IItemCriterion = null;
         var tempCriteriaText:String = null;
         if(this._conditions == null || this._conditions.criteria == null || this._conditions.criteria.length == 0)
         {
            return;
         }
         _content = _block.getChunk("subTitle").processContent({"text":this._titleText});
         var tempContent:String = "";
         for each(criterion in this._conditions.criteria)
         {
            criteriaText = "";
            criteriaRespected = criterion.isRespected;
            criterias = criterion is GroupItemCriterion ? criterion.criteria : criterion.inlineCriteria;
            for(i = 0; i < criterias.length; i++)
            {
               criteriaText = "";
               itemCrit = criterias[i];
               tempCriteriaText = this.processCriteria(itemCrit);
               if(tempCriteriaText != "")
               {
                  if(i > 0 && i < criterias.length && criterion.operators)
                  {
                     switch(criterion.operators[i - 1])
                     {
                        case "&":
                           criteriaText += Api.ui.getText("ui.common.and") + " ";
                           break;
                        case "|":
                           criteriaText += Api.ui.getText("ui.common.or") + " ";
                     }
                  }
                  if(this._onTarget)
                  {
                     criteriaText = "(" + Api.ui.getText("ui.item.target") + ") ";
                  }
                  criteriaText += tempCriteriaText;
                  this._effectCssClass = !!itemCrit.isRespected ? "requirement" : "malus";
               }
               if(criteriaText)
               {
                  criteriaText = XML(new XMLNode(XMLNodeType.TEXT_NODE,criteriaText)).toXMLString();
                  tempContent += _block.getChunk("effect").processContent({
                     "text":criteriaText,
                     "cssClass":this._effectCssClass,
                     "li":"",
                     "customli":this._customli
                  },{"valueCssClass":"value"});
               }
            }
         }
         if(tempContent == "")
         {
            _content = "";
         }
         else
         {
            _content += tempContent;
         }
      }
      
      private function processCriteria(crit:IItemCriterion) : String
      {
         var tmpContent:String = null;
         var countCrit:int = 0;
         var grpCrit:GroupItemCriterion = null;
         var i:int = 0;
         var critText:String = null;
         if(crit is GroupItemCriterion)
         {
            tmpContent = "";
            countCrit = 0;
            grpCrit = crit as GroupItemCriterion;
            for(i = 0; i < grpCrit.criteria.length; if(critText)
            {
               tmpContent += critText;
               countCrit++;
            },i++)
            {
               critText = this.processCriteria(grpCrit.criteria[i]);
               if(!(i > 0 && i < grpCrit.criteria.length && critText))
               {
                  continue;
               }
               switch(grpCrit.operators[i - 1])
               {
                  case "&":
                     tmpContent += " " + Api.ui.getText("ui.common.and") + " ";
                     break;
                  case "|":
                     tmpContent += " " + Api.ui.getText("ui.common.or") + " ";
                     break;
               }
            }
            if(countCrit > 1)
            {
               return "(" + tmpContent + ")";
            }
            return tmpContent;
         }
         return crit.text;
      }
   }
}
