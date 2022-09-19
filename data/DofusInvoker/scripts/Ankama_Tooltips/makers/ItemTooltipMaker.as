package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blockParams.EffectsTooltipBlockParameters;
   import Ankama_Tooltips.blocks.ConditionTooltipBlock;
   import Ankama_Tooltips.blocks.DescriptionTooltipBlock;
   import Ankama_Tooltips.blocks.HtmlEffectsTooltipBlock;
   import Ankama_Tooltips.blocks.ItemDetailsBlock;
   import Ankama_Tooltips.blocks.ItemHeaderBlock;
   import Ankama_Tooltips.blocks.ProbaTooltipBlock;
   import Ankama_Tooltips.blocks.TextTooltipBlock;
   import Ankama_Tooltips.blocks.TextWithTwoColumnsBlock;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.dofus.datacenter.alterations.Alteration;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.idols.Idol;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.RandomDropGroup;
   import com.ankamagames.dofus.datacenter.items.RandomDropItem;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.ui.Keyboard;
   
   public class ItemTooltipMaker implements ITooltipMaker
   {
      
      private static const chunkType:String = "htmlChunks";
      
      private static const NAME_EFFECTS_IDS:Array = [985,988];
      
      private static const RANDOM_DROP_EFFECT_ID:uint = 222;
       
      
      private var _effects:Array;
      
      private var _itemData;
      
      public function ItemTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var eff:* = undefined;
         var showTimeLeftFormat:Boolean = false;
         var effectsTooltipBlockParams:EffectsTooltipBlockParameters = null;
         var effect:* = undefined;
         var effectInstance:EffectInstance = null;
         var alterationData:Alteration = null;
         var alterationEffect:EffectInstance = null;
         var randomDropGroup:RandomDropGroup = null;
         var group:Array = null;
         var playerSetInfo:Object = null;
         var idol:Idol = null;
         var showTheoreticalEffectsTip:String = null;
         var leftText:String = null;
         var rightText:String = null;
         var uiApi:UiApi = Api.ui;
         var sysApi:SystemApi = Api.system;
         if(data.hasOwnProperty("itemWrapper"))
         {
            this._itemData = data.itemWrapper;
         }
         else
         {
            this._itemData = data;
         }
         if(this._itemData.possibleEffects)
         {
            this.SortItemEffectsByPriority();
         }
         var theoreticalEffects:* = this._itemData.possibleEffects;
         var setMode:Boolean = false;
         var abstractEffects:Array = [];
         var _param:paramClass = new paramClass();
         var baseChunkFile:* = chunkType + "/item/baseWithBackground.txt";
         if(param)
         {
            if(param.hasOwnProperty("noBg"))
            {
               _param.noBg = param.noBg;
               if(_param.noBg)
               {
                  baseChunkFile = chunkType + "/item/base.txt";
               }
            }
            if(param.hasOwnProperty("setMode"))
            {
               setMode = param.setMode;
               delete param.setMode;
            }
            if(param.hasOwnProperty("description"))
            {
               _param.description = param.description;
            }
            if(param.hasOwnProperty("effects"))
            {
               _param.effects = param.effects;
            }
            if(param.hasOwnProperty("CC_EC"))
            {
               _param.CC_EC = param.CC_EC;
            }
            if(param.hasOwnProperty("noFooter"))
            {
               _param.noFooter = param.noFooter;
            }
            if(param.hasOwnProperty("noTheoreticalEffects"))
            {
               _param.noTheoreticalEffects = param.noTheoreticalEffects;
            }
            if(param.hasOwnProperty("header"))
            {
               _param.header = param.header;
               if(!_param.header)
               {
                  baseChunkFile = baseChunkFile.replace(".txt","NoIcon.txt");
               }
            }
            if(param.hasOwnProperty("conditions"))
            {
               _param.conditions = param.conditions;
            }
            if(param.hasOwnProperty("targetConditions"))
            {
               _param.targetConditions = param.targetConditions;
            }
            if(param.hasOwnProperty("length"))
            {
               _param.length = param.length;
            }
            if(param.hasOwnProperty("equipped"))
            {
               _param.equipped = param.equipped;
            }
            if(param.hasOwnProperty("shortcutKey"))
            {
               _param.shortcutKey = param.shortcutKey;
            }
            if(param.hasOwnProperty("showEffects") && param.showEffects && this._itemData && this._itemData.effects.length <= 0)
            {
               for each(effect in theoreticalEffects)
               {
                  abstractEffects.push(effect);
               }
            }
            if(param.hasOwnProperty("averagePrice"))
            {
               _param.averagePrice = param.averagePrice;
            }
            if(param.hasOwnProperty("contextual"))
            {
               _param.contextual = param.contextual;
            }
            if(param.hasOwnProperty("addTheoreticalEffects"))
            {
               _param.addTheoreticalEffects = param.addTheoreticalEffects;
            }
            else
            {
               param.addTheoreticalEffects = false;
            }
            if(param.hasOwnProperty("showDropPercentage"))
            {
               _param.showDropPercentage = param.showDropPercentage;
            }
         }
         var tooltip:Tooltip = Api.tooltip.createTooltip(baseChunkFile,chunkType + "/base/container.txt",chunkType + "/base/separator.txt");
         tooltip.chunkType = chunkType;
         if(_param.equipped)
         {
            tooltip.addBlock(new TextTooltipBlock(uiApi.getText("ui.item.equipped"),{
               "css":"[local.css]normal.css",
               "classCss":"disabled"
            },chunkType).block);
         }
         tooltip.addBlock(new ItemHeaderBlock(this._itemData,_param,chunkType).block);
         this._effects = [];
         var showTheoretical:Boolean = false;
         var randomDropGroupId:int = -1;
         if(abstractEffects.length)
         {
            for each(eff in abstractEffects)
            {
               if(eff.effectId == RANDOM_DROP_EFFECT_ID)
               {
                  randomDropGroupId = eff.value;
               }
               this._effects.push(eff);
            }
            showTheoretical = true;
         }
         else
         {
            for each(eff in this._itemData.effects)
            {
               if(eff.effectId == RANDOM_DROP_EFFECT_ID)
               {
                  randomDropGroupId = eff.value;
               }
               this._effects.push(eff);
            }
         }
         if(this._itemData.enhanceable && !_param.addTheoreticalEffects && (sysApi.isKeyDown(Keyboard.CONTROL) || sysApi.getOption("alwaysDisplayTheoreticalEffectsInTooltip","dofus")) && !showTheoretical)
         {
            if(!_param.noTheoreticalEffects)
            {
               if(param)
               {
                  param.addTheoreticalEffects = true;
               }
               _param.addTheoreticalEffects = true;
            }
         }
         else if(!this._itemData.enhanceable)
         {
            theoreticalEffects = null;
            _param.addTheoreticalEffects = false;
         }
         for each(eff in this._itemData.favoriteEffect)
         {
            this._effects.push(eff);
         }
         showTimeLeftFormat = false;
         if(this._itemData is Item)
         {
            for each(effectInstance in this._itemData.possibleEffects)
            {
               if(effectInstance.baseEffectId === DataEnum.BASE_EFFECT_ADD_ALTERATION)
               {
                  showTimeLeftFormat = true;
                  alterationData = Alteration.getAlterationById(effectInstance.parameter0 as Number);
                  for each(alterationEffect in alterationData.possibleEffects)
                  {
                     this._effects.push(alterationEffect.clone());
                  }
                  break;
               }
            }
         }
         if(this._effects.length && _param.effects || theoreticalEffects && theoreticalEffects.length)
         {
            this._effects.sort(this.compareEffectsOrder);
            effectsTooltipBlockParams = EffectsTooltipBlockParameters.create(this._effects,chunkType);
            effectsTooltipBlockParams.length = _param.length;
            effectsTooltipBlockParams.showTheoreticalEffects = showTheoretical;
            effectsTooltipBlockParams.addTheoreticalEffects = _param.addTheoreticalEffects;
            effectsTooltipBlockParams.itemTheoreticalEffects = theoreticalEffects;
            effectsTooltipBlockParams.showTimeLeftFormat = showTimeLeftFormat;
            if(param && (param.hasOwnProperty("effects") && param.effects || param.hasOwnProperty("damages") && param.damages || param.hasOwnProperty("specialEffects") && param.specialEffects))
            {
               if(param.hasOwnProperty("damages"))
               {
                  effectsTooltipBlockParams.showDamages = param.damages;
               }
               if(param.hasOwnProperty("specialEffects"))
               {
                  effectsTooltipBlockParams.showSpecialEffects = param.specialEffects;
               }
            }
            tooltip.addBlock(new HtmlEffectsTooltipBlock(effectsTooltipBlockParams).block);
            if(randomDropGroupId >= 0)
            {
               randomDropGroup = Api.data.getRandomDropGroup(randomDropGroupId);
               if(randomDropGroup && randomDropGroup.displayContent)
               {
                  group = this.createRandomDropGroupInfo(randomDropGroup);
                  tooltip.addBlock(new ProbaTooltipBlock(group,randomDropGroup.displayChances,chunkType).block);
               }
            }
         }
         if(setMode && _param.effects)
         {
            playerSetInfo = Api.player.getPlayerSet(this._itemData.objectGID);
            if(playerSetInfo)
            {
               effectsTooltipBlockParams = EffectsTooltipBlockParameters.create(playerSetInfo.setEffects,chunkType);
               effectsTooltipBlockParams.length = _param.length;
               effectsTooltipBlockParams.showTheoreticalEffects = showTheoretical;
               effectsTooltipBlockParams.setInfo = playerSetInfo.setName + " (" + playerSetInfo.setObjects.length + "/" + playerSetInfo.allItems.length + ")";
               tooltip.addBlock(new HtmlEffectsTooltipBlock(effectsTooltipBlockParams).block);
            }
         }
         if(this._itemData.typeId == DataEnum.ITEM_TYPE_IDOLS)
         {
            if(this._effects.length == 0 && (!theoreticalEffects || theoreticalEffects.length == 0))
            {
               tooltip.addBlock(new TextTooltipBlock(Api.ui.processText(Api.ui.getText("ui.common.effects"),"",false,true) + Api.ui.getText("ui.common.colon"),{"classCss":"subtitle"},chunkType).block);
            }
            idol = Api.data.getIdolByItemId(this._itemData.objectGID);
            tooltip.addBlock(new TextTooltipBlock("• " + idol.spellPair.description,{
               "classCss":"contentmargin",
               "width":_param.length
            },chunkType).block);
         }
         var cond:Object = this._itemData.conditions;
         if(cond && cond.text && _param.conditions)
         {
            tooltip.addBlock(new ConditionTooltipBlock(cond,null,false,chunkType).block);
         }
         var condT:Object = this._itemData.targetConditions;
         if(condT && condT.text && _param.targetConditions)
         {
            tooltip.addBlock(new ConditionTooltipBlock(condT,null,true,chunkType).block);
         }
         tooltip.addBlock(new ItemDetailsBlock(data.hasOwnProperty("dropResult") && data.dropResult ? data : this._itemData,_param,chunkType).block);
         if(_param.description)
         {
            tooltip.addBlock(new DescriptionTooltipBlock(this._itemData.description,"quote",chunkType).block);
         }
         if(!SpellTooltipMaker.SPELL_TAB_MODE && !_param.noFooter)
         {
            showTheoreticalEffectsTip = !this._itemData.enhanceable || showTheoretical || !theoreticalEffects || !theoreticalEffects.length || !effectsTooltipBlockParams ? "" : "[ui.tooltip.item.tip2]";
            if(sysApi.getOption("alwaysDisplayTheoreticalEffectsInTooltip","dofus"))
            {
               showTheoreticalEffectsTip = "";
            }
            leftText = "[ui.tooltip.item.tip]";
            if(param && param.hasOwnProperty("noLeftFooter") && param.noLeftFooter)
            {
               leftText = "";
            }
            rightText = "";
            if(param && param.hasOwnProperty("rightText"))
            {
               rightText = param.rightText;
            }
            if(leftText || showTheoreticalEffectsTip || rightText)
            {
               tooltip.addBlock(new TextWithTwoColumnsBlock({
                  "leftCss":"footerleft",
                  "leftText":leftText,
                  "rightCss":"footerright",
                  "rightText":(!!rightText ? rightText : showTheoreticalEffectsTip)
               },chunkType).block);
            }
         }
         return tooltip;
      }
      
      private function compareEffectsOrder(effectA:EffectInstance, effectB:EffectInstance) : Number
      {
         var effectAIsNameEffect:* = NAME_EFFECTS_IDS.indexOf(effectA.effectId) != -1;
         var effectBIsNameEffect:* = NAME_EFFECTS_IDS.indexOf(effectB.effectId) != -1;
         if(!effectAIsNameEffect && effectBIsNameEffect)
         {
            return -1;
         }
         if(effectAIsNameEffect && !effectBIsNameEffect)
         {
            return 1;
         }
         return this._effects.indexOf(effectA) < this._effects.indexOf(effectB) ? Number(-1) : Number(1);
      }
      
      private function createRandomDropGroupInfo(randomDropGroup:RandomDropGroup) : Array
      {
         var randomDropItemInfo:Object = null;
         var randomItem:RandomDropItem = null;
         if(!randomDropGroup)
         {
            return null;
         }
         var randomDropGroupInfo:Array = [];
         for each(randomItem in randomDropGroup.randomDropItems)
         {
            randomDropItemInfo = {
               "name":randomItem.itemWrapper.name + this.processRandomItemQuantityText(randomItem),
               "proba":(randomItem.probability >= 0 ? randomItem.probability / randomDropGroup.groupWeight * 100 : 100),
               "rarity":"",
               "showProba":randomDropGroup.displayChances
            };
            randomDropGroupInfo.push(randomDropItemInfo);
         }
         randomDropGroupInfo.sort(this.sortByProba);
         return randomDropGroupInfo;
      }
      
      private function processRandomItemQuantityText(randomItem:RandomDropItem) : String
      {
         if(randomItem.minQuantity == randomItem.maxQuantity)
         {
            if(randomItem.minQuantity <= 1)
            {
               return "";
            }
            return " (" + Api.ui.getText("ui.bidhouse.stack",randomItem.minQuantity) + ")";
         }
         return " (" + Api.ui.getText("ui.common.stacks",randomItem.minQuantity,randomItem.maxQuantity) + ")";
      }
      
      private function sortByProba(firstElem:Object, secondElem:Object) : int
      {
         if(firstElem.proba < secondElem.proba)
         {
            return 1;
         }
         if(firstElem.proba > secondElem.proba)
         {
            return -1;
         }
         return this.sortByName(firstElem,secondElem);
      }
      
      private function sortByName(firstElem:Object, secondElem:Object) : int
      {
         if(firstElem.name < secondElem.name)
         {
            return -1;
         }
         if(firstElem.name > secondElem.name)
         {
            return 1;
         }
         return 0;
      }
      
      private function SortItemEffectsByPriority() : void
      {
         this._itemData.possibleEffects.sort(function(e1:EffectInstance, e2:EffectInstance):Number
         {
            if(e1.priority > e2.priority)
            {
               return 1;
            }
            if(e1.priority < e2.priority)
            {
               return -1;
            }
            return 0;
         });
      }
   }
}

class paramClass
{
    
   
   public var header:Boolean = true;
   
   public var effects:Boolean = true;
   
   public var description:Boolean = true;
   
   public var noBg:Boolean = false;
   
   public var CC_EC:Boolean = true;
   
   public var conditions:Boolean = true;
   
   public var targetConditions:Boolean = true;
   
   public var length:int = 409;
   
   public var averagePrice:Boolean = true;
   
   public var equipped:Boolean = false;
   
   public var shortcutKey:String;
   
   public var contextual:Boolean = false;
   
   public var noFooter:Boolean = false;
   
   public var addTheoreticalEffects:Boolean = false;
   
   public var noTheoreticalEffects:Boolean = false;
   
   public var showDropPercentage:Boolean = false;
   
   function paramClass()
   {
      super();
   }
}
