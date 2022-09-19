package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class ItemDetailsBlock extends AbstractTooltipBlock
   {
       
      
      private var _contextual:Boolean = false;
      
      private var _item:ItemWrapper;
      
      private var _weapon:WeaponWrapper;
      
      private var _dropResult:Object;
      
      private var _params:Object;
      
      private var sysApi:SystemApi;
      
      private var playerApi:PlayedCharacterApi;
      
      private var uiApi:UiApi;
      
      private var dataApi:DataApi;
      
      public function ItemDetailsBlock(item:Object, param:Object, chunkType:String = "chunks")
      {
         super();
         this.addApis();
         if(item.hasOwnProperty("dropResult") && item.dropResult)
         {
            this._item = item.itemWrapper as ItemWrapper;
            this._weapon = item.itemWrapper as WeaponWrapper;
            this._dropResult = item.dropResult;
         }
         else
         {
            this._item = item as ItemWrapper;
            this._weapon = item as WeaponWrapper;
            this._dropResult = null;
         }
         if(param is Boolean)
         {
            this._params = null;
         }
         else
         {
            this._params = param;
         }
         if(param.hasOwnProperty("contextual"))
         {
            this._contextual = param.contextual;
         }
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         var chunkData:Array = [Api.tooltip.createChunkData("details",chunkType + "/item/details.txt"),Api.tooltip.createChunkData("dropPercentage",chunkType + "/item/dropPercentage.txt"),Api.tooltip.createChunkData("p",chunkType + "/text/p.txt")];
         if(this._item.importantNotice)
         {
            chunkData.push(Api.tooltip.createChunkData("importantNotice",chunkType + "/item/importantNotice.txt"));
         }
         if(this._item.itemSetId != -1)
         {
            chunkData.push(Api.tooltip.createChunkData("itemSet",chunkType + "/item/itemSet.txt"));
         }
         _block.initChunk(chunkData);
      }
      
      public function onAllChunkLoaded() : void
      {
         var chunkParams:Object = null;
         var itemwrapper:ItemWrapper = null;
         var leftUseDescription:String = null;
         var effect:EffectInstance = null;
         _content = "";
         if(this._item.itemSetId != -1)
         {
            chunkParams = {"itemSet":this._item.itemSet.name};
            _content += _block.getChunk("itemSet").processContent(chunkParams);
         }
         chunkParams = this.getItemDetailsChunkParams();
         _content += _block.getChunk("details").processContent(chunkParams);
         if(this._item.type && (this._item.type.id == DataEnum.ITEM_TYPE_BREEDING_ITEM || this._item.type.id == DataEnum.ITEM_TYPE_COMPANION || this._item.type.superTypeId === DataEnum.ITEM_SUPERTYPE_COLLAR || this._item.type.superTypeId === DataEnum.ITEM_SUPERTYPE_WEAPON || this._item.type.superTypeId === DataEnum.ITEM_SUPERTYPE_RING || this._item.type.superTypeId === DataEnum.ITEM_SUPERTYPE_BELT || this._item.type.superTypeId === DataEnum.ITEM_SUPERTYPE_SHOES || this._item.type.superTypeId === DataEnum.ITEM_SUPERTYPE_SHIELD || this._item.type.superTypeId === DataEnum.ITEM_SUPERTYPE_HELMET || this._item.type.superTypeId === DataEnum.ITEM_SUPERTYPE_CAPE))
         {
            leftUseDescription = "";
            for each(effect in this._item.effects)
            {
               if(effect.effectId == ActionIds.ACTION_ITEM_CHANGE_DURABILITY)
               {
                  leftUseDescription = effect.description;
                  break;
               }
            }
            if(leftUseDescription)
            {
               _content += _block.getChunk("p").processContent({"text":leftUseDescription});
            }
         }
         if(this._item.isObjectWrapped)
         {
            itemwrapper = this.dataApi.getItemWrapper(this._item.objectGID);
         }
         else
         {
            itemwrapper = this._item;
         }
         if(this.sysApi.isInGame() && this._params.averagePrice && itemwrapper.exchangeable)
         {
            _content += _block.getChunk("p").processContent({"text":Api.averagePrices.getItemAveragePriceString(itemwrapper,false," <span class=\'value\'>","</span>")});
         }
         if(this.sysApi.isInGame() && this._params.showDropPercentage && this._dropResult)
         {
            _content += _block.getChunk("dropPercentage").processContent({"text":this.uiApi.processText(this.uiApi.getText("ui.monster.obtaining.base","<span class=\'value\'>" + this.getStringFromValues(this._dropResult.baseDropMinGrade,this._dropResult.baseDropMaxGrade) + "</span>"),"n")});
            _content += _block.getChunk("dropPercentage").processContent({"text":this.uiApi.processText(this.uiApi.getText("ui.monster.obtaining.withBonuses","<span class=\'value\'>" + this.getStringFromValues(this._dropResult.dropMinGrade,this._dropResult.dropMaxGrade) + "</span>"),"n")});
         }
         if(this._item.importantNotice)
         {
            _content += _block.getChunk("importantNotice").processContent({"text":this._item.processedImportantNotice});
         }
         this.removeApis();
      }
      
      private function getItemDetailsChunkParams() : Object
      {
         var itemPossibleEffects:Vector.<EffectInstance> = null;
         var calc:Number = NaN;
         var powerRate:Number = NaN;
         var weightValue:Number = NaN;
         var effect:EffectInstance = null;
         var chunkParams:Object = {};
         chunkParams.category = this._item.type.name;
         if(this.sysApi.getBuildType() >= BuildTypeEnum.INTERNAL && this._item.type.id)
         {
            chunkParams.category += " (" + this._item.type.id + ")";
         }
         if(this._item.twoHanded)
         {
            chunkParams.category += " ( [ui.common.twoHandsWeapon] )";
         }
         if(this._item.type.id == DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE)
         {
            itemPossibleEffects = this._item.possibleEffects;
            calc = 0;
            if(this._item.objectGID == DataEnum.ITEM_GID_HUNTING_RUNE)
            {
               powerRate = parseFloat(this.dataApi.getEffect(itemPossibleEffects[0].effectId).effectPowerRate.toFixed(2));
               calc = powerRate * int(itemPossibleEffects[0].parameter2);
            }
            else if(itemPossibleEffects.length)
            {
               powerRate = parseFloat(this.dataApi.getEffect(itemPossibleEffects[0].effectId).effectPowerRate.toFixed(2));
               calc = powerRate * int(itemPossibleEffects[0].parameter0);
            }
            chunkParams.density = "<p>[ui.item.density]  <span class=\'value\'>" + calc + "</span></p>";
         }
         else if(this._item.type.id == DataEnum.ITEM_TYPE_SMITHMAGIC_TRANSCENDANCE_RUNE || this._item.type.id == DataEnum.ITEM_TYPE_SMITHMAGIC_CORRUPTION_RUNE)
         {
            weightValue = 0;
            for each(effect in this._item.possibleEffects)
            {
               if(effect.effectId == ActionIds.SMITHMAGIC_FORCE_WEIGHT)
               {
                  weightValue = int(effect.parameter2);
               }
            }
            chunkParams.density = "<p>[ui.item.density]  <span class=\'value\'>" + weightValue + "</span></p>";
         }
         else
         {
            chunkParams.density = "";
         }
         if(this._item.weight > 1)
         {
            chunkParams.weight = this.uiApi.processText(this.uiApi.getText("ui.common.short.weight",this._item.weight),"m",false);
         }
         else
         {
            chunkParams.weight = this.uiApi.processText(this.uiApi.getText("ui.common.short.weight",this._item.weight),"m",true);
         }
         return chunkParams;
      }
      
      private function getStringFromValues(valueA:Number, valueB:Number) : String
      {
         if(valueA == valueB)
         {
            return "" + valueA;
         }
         return "" + valueA + " " + this.uiApi.getText("ui.chat.to") + " " + valueB;
      }
      
      private function addApis() : void
      {
         this.sysApi = Api.system;
         this.playerApi = Api.player;
         this.uiApi = Api.ui;
         this.dataApi = Api.data;
      }
      
      private function removeApis() : void
      {
         this.sysApi = null;
         this.playerApi = null;
         this.uiApi = null;
         this.dataApi = null;
      }
   }
}
