package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.utils.getQualifiedClassName;
   
   public class GroupItemCriterion implements IItemCriterion, IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GroupItemCriterion));
       
      
      protected var _criteria:Vector.<IItemCriterion>;
      
      protected var _operators:Vector.<String>;
      
      private var _criterionTextForm:String;
      
      private var _cleanCriterionTextForm:String;
      
      private var _malformated:Boolean = false;
      
      private var _singleOperatorType:Boolean = false;
      
      public function GroupItemCriterion(pCriterion:String)
      {
         super();
         this._criterionTextForm = pCriterion;
         this._cleanCriterionTextForm = this._criterionTextForm;
         if(!pCriterion)
         {
            return;
         }
         this._cleanCriterionTextForm = StringUtils.replace(this._cleanCriterionTextForm," ","");
         var delimitedArray:Vector.<String> = StringUtils.getDelimitedText(this._cleanCriterionTextForm,"(",")",true);
         if(delimitedArray.length > 0 && delimitedArray[0] == this._cleanCriterionTextForm)
         {
            this._cleanCriterionTextForm = this._cleanCriterionTextForm.slice(1);
            this._cleanCriterionTextForm = this._cleanCriterionTextForm.slice(0,this._cleanCriterionTextForm.length - 1);
         }
         this.split();
         this.createNewGroups();
      }
      
      public static function create(pCriteria:Vector.<IItemCriterion>, pOperators:Vector.<String>) : GroupItemCriterion
      {
         var pair:* = undefined;
         var tabLength:uint = pCriteria.length + pOperators.length;
         var textForm:String = "";
         var criterionIndex:uint = 0;
         var operatorIndex:uint = 0;
         for(var i:uint = 0; i < tabLength; i++)
         {
            pair = i % 2;
            if(pair == 0)
            {
               textForm += (pCriteria[criterionIndex++] as IItemCriterion).basicText;
            }
            else
            {
               textForm += pOperators[operatorIndex++];
            }
         }
         return new GroupItemCriterion(textForm);
      }
      
      public function get criteria() : Vector.<IItemCriterion>
      {
         return this._criteria;
      }
      
      public function get inlineCriteria() : Vector.<IItemCriterion>
      {
         var criterion:IItemCriterion = null;
         var criteria:Vector.<IItemCriterion> = new Vector.<IItemCriterion>();
         for each(criterion in this._criteria)
         {
            criteria = criteria.concat(criterion.inlineCriteria);
         }
         return criteria;
      }
      
      public function get isRespected() : Boolean
      {
         var criterion:IItemCriterion = null;
         if(!this._criteria || this._criteria.length == 0)
         {
            return true;
         }
         var player:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(!player || !player.characteristics)
         {
            return true;
         }
         if(this._criteria && this._criteria.length == 1 && this._criteria[0] is ItemCriterion)
         {
            return (this._criteria[0] as ItemCriterion).isRespected;
         }
         if(this._operators.length > 0 && this._operators[0] == "|")
         {
            for each(criterion in this._criteria)
            {
               if(criterion.isRespected)
               {
                  return true;
               }
            }
            return false;
         }
         for each(criterion in this._criteria)
         {
            if(!criterion.isRespected)
            {
               return false;
            }
         }
         return true;
      }
      
      public function get text() : String
      {
         var pair:* = undefined;
         var textForm:* = "";
         if(this._criteria == null)
         {
            return textForm;
         }
         var tabLength:uint = this._criteria.length + this._operators.length;
         var criterionIndex:uint = 0;
         var operatorIndex:uint = 0;
         for(var i:uint = 0; i < tabLength; i++)
         {
            if(textForm != "")
            {
               textForm += " ";
            }
            pair = i % 2;
            if(pair == 0)
            {
               textForm += (this._criteria[criterionIndex++] as IItemCriterion).text;
            }
            else
            {
               textForm += this._operators[operatorIndex++];
            }
         }
         return textForm;
      }
      
      public function get basicText() : String
      {
         return this._criterionTextForm;
      }
      
      public function clone() : IItemCriterion
      {
         return new GroupItemCriterion(this.basicText);
      }
      
      private function createNewGroups() : void
      {
         var crit:IItemCriterion = null;
         var ope:String = null;
         var curIndex:int = 0;
         var exit:Boolean = false;
         var crits:Vector.<IItemCriterion> = null;
         var ops:Vector.<String> = null;
         var group:GroupItemCriterion = null;
         if(this._malformated || !this._criteria || this._criteria.length <= 2 || this._singleOperatorType)
         {
            return;
         }
         var copyCriteria:Vector.<IItemCriterion> = new Vector.<IItemCriterion>();
         var copyOperators:Vector.<String> = new Vector.<String>();
         for each(crit in this._criteria)
         {
            copyCriteria.push(crit.clone());
         }
         for each(ope in this._operators)
         {
            copyOperators.push(ope);
         }
         curIndex = 0;
         exit = false;
         while(!exit)
         {
            if(copyCriteria.length <= 2)
            {
               exit = true;
            }
            else
            {
               if(copyOperators[curIndex] == "&")
               {
                  crits = new Vector.<IItemCriterion>();
                  crits.push(copyCriteria[curIndex]);
                  crits.push(copyCriteria[curIndex + 1]);
                  ops = Vector.<String>([copyOperators[curIndex]]);
                  group = GroupItemCriterion.create(crits,ops);
                  copyCriteria.splice(curIndex,2,group);
                  copyOperators.splice(curIndex,1);
                  curIndex--;
               }
               curIndex++;
               if(curIndex >= copyOperators.length)
               {
                  exit = true;
               }
            }
         }
         this._criteria = copyCriteria;
         this._operators = copyOperators;
         this._singleOperatorType = this.checkSingleOperatorType(this._operators);
      }
      
      private function split() : void
      {
         var criterion:IItemCriterion = null;
         var indexOfNextCriterion:int = 0;
         var index:int = 0;
         var op:String = null;
         var criterion2:IItemCriterion = null;
         var indexOfNextCriterion2:int = 0;
         var index2:int = 0;
         var firstPart:String = null;
         var secondPart:String = null;
         var operator:String = null;
         if(!this._cleanCriterionTextForm)
         {
            return;
         }
         var CRITERION:uint = 0;
         var OPERATOR:uint = 1;
         var next:uint = CRITERION;
         var exit:Boolean = false;
         var searchingString:String = this._cleanCriterionTextForm;
         this._criteria = new Vector.<IItemCriterion>();
         this._operators = new Vector.<String>();
         var andIndexes:Array = StringUtils.getAllIndexOf("&",searchingString);
         var orIndexes:Array = StringUtils.getAllIndexOf("|",searchingString);
         if(andIndexes.length == 0 || orIndexes.length == 0)
         {
            this._singleOperatorType = true;
            while(!exit)
            {
               criterion = this.getFirstCriterion(searchingString);
               if(!criterion)
               {
                  indexOfNextCriterion = searchingString.indexOf("&");
                  if(indexOfNextCriterion == -1)
                  {
                     indexOfNextCriterion = searchingString.indexOf("|");
                  }
                  if(indexOfNextCriterion == -1)
                  {
                     searchingString = "";
                  }
                  else
                  {
                     searchingString = searchingString.slice(indexOfNextCriterion + 1);
                  }
               }
               else
               {
                  this._criteria.push(criterion);
                  index = searchingString.indexOf(criterion.basicText);
                  op = searchingString.slice(index + criterion.basicText.length,index + 1 + criterion.basicText.length);
                  if(op)
                  {
                     this._operators.push(op);
                  }
                  searchingString = searchingString.slice(index + 1 + criterion.basicText.length);
               }
               if(!searchingString)
               {
                  exit = true;
               }
            }
         }
         else
         {
            while(!exit)
            {
               if(!searchingString)
               {
                  exit = true;
               }
               else if(next == CRITERION)
               {
                  criterion2 = this.getFirstCriterion(searchingString);
                  if(!criterion2)
                  {
                     indexOfNextCriterion2 = searchingString.indexOf("&");
                     if(indexOfNextCriterion2 == -1)
                     {
                        indexOfNextCriterion2 = searchingString.indexOf("|");
                     }
                     if(indexOfNextCriterion2 == -1)
                     {
                        searchingString = "";
                     }
                     else
                     {
                        searchingString = searchingString.slice(indexOfNextCriterion2 + 1);
                     }
                  }
                  else
                  {
                     this._criteria.push(criterion2);
                     next = OPERATOR;
                     index2 = searchingString.indexOf(criterion2.basicText);
                     firstPart = searchingString.slice(0,index2);
                     secondPart = searchingString.slice(index2 + criterion2.basicText.length);
                     searchingString = firstPart + secondPart;
                  }
                  if(!searchingString)
                  {
                     exit = true;
                  }
               }
               else
               {
                  operator = searchingString.slice(0,1);
                  if(!operator)
                  {
                     exit = true;
                  }
                  else
                  {
                     this._operators.push(operator);
                     next = CRITERION;
                     searchingString = searchingString.slice(1);
                  }
               }
            }
            this._singleOperatorType = this.checkSingleOperatorType(this._operators);
         }
         if(this._operators.length >= this._criteria.length && (this._operators.length > 0 && this._criteria.length > 0))
         {
            this._malformated = true;
         }
      }
      
      private function checkSingleOperatorType(pOperators:Vector.<String>) : Boolean
      {
         var op:String = null;
         if(pOperators.length > 0)
         {
            for each(op in pOperators)
            {
               if(op != pOperators[0])
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      private function getFirstCriterion(pCriteria:String) : IItemCriterion
      {
         var criterion:IItemCriterion = null;
         var dl:Vector.<String> = null;
         var ANDindex:int = 0;
         var ORindex:int = 0;
         if(!pCriteria)
         {
            return null;
         }
         pCriteria = StringUtils.replace(pCriteria," ","");
         if(pCriteria.slice(0,1) == "(")
         {
            dl = StringUtils.getDelimitedText(pCriteria,"(",")",true);
            criterion = new GroupItemCriterion(dl[0]);
         }
         else
         {
            ANDindex = pCriteria.indexOf("&");
            ORindex = pCriteria.indexOf("|");
            if(ANDindex == -1 && ORindex == -1)
            {
               criterion = ItemCriterionFactory.create(pCriteria);
            }
            else if((ANDindex < ORindex || ORindex == -1) && ANDindex != -1)
            {
               criterion = ItemCriterionFactory.create(pCriteria.split("&")[0]);
            }
            else
            {
               criterion = ItemCriterionFactory.create(pCriteria.split("|")[0]);
            }
         }
         return criterion;
      }
      
      public function get operators() : Vector.<String>
      {
         return this._operators;
      }
   }
}
