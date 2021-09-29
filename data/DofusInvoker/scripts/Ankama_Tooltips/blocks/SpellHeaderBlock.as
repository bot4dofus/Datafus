package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   
   public class SpellHeaderBlock extends AbstractTooltipBlock
   {
      
      private static var _shortcutColor:String;
       
      
      public var playerApi:Object;
      
      public var sysApi:Object;
      
      public var uiApi:Object;
      
      public var dataApi:Object;
      
      private var _spellItem:Object;
      
      private var _param:paramClass;
      
      public function SpellHeaderBlock(spellItem:Object, param:Object = null, chunkType:String = "chunk")
      {
         super();
         this.addApis();
         this._spellItem = spellItem;
         this._param = new paramClass();
         if(param)
         {
            if(param.hasOwnProperty("smallSpell"))
            {
               this._param.smallSpell = param.smallSpell;
            }
            if(param.hasOwnProperty("isTheoretical"))
            {
               this._param.isTheoretical = param.isTheoretical;
            }
            if(param.hasOwnProperty("name"))
            {
               this._param.name = param.name;
            }
            if(param.hasOwnProperty("contextual"))
            {
               this._param.contextual = param.contextual;
            }
            if(param.hasOwnProperty("shortcutKey"))
            {
               this._param.shortcutKey = param.shortcutKey;
            }
         }
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("header",chunkType + "/spell/header.txt"),Api.tooltip.createChunkData("details",chunkType + "/spell/details.txt"),Api.tooltip.createChunkData("detailsSpellZone",chunkType + "/spell/detailsSpellZone.txt"),Api.tooltip.createChunkData("detailsEffect",chunkType + "/spell/detailsEffect.txt"),Api.tooltip.createChunkData("p",chunkType + "/text/p.txt"),Api.tooltip.createChunkData("pWithClass",chunkType + "/text/pWithClass.txt"),Api.tooltip.createChunkData("separator",chunkType + "/base/separator.txt")]);
      }
      
      private function getSpellHeaderChunkParams(_spellItem:*) : Object
      {
         var chunkParams:Object = {};
         chunkParams.name = _spellItem.name;
         if(this._param.shortcutKey && this._param.shortcutKey != "")
         {
            if(!_shortcutColor)
            {
               _shortcutColor = this.sysApi.getConfigEntry("colors.shortcut").replace("0x","#");
            }
            chunkParams.name += " <font color=\'" + _shortcutColor + "\'>(" + this._param.shortcutKey + ")</font>";
         }
         chunkParams.rank = "";
         if(this.sysApi.getPlayerManager().hasRights)
         {
            chunkParams.name += " (" + _spellItem.id + ")";
            chunkParams.rank += this.uiApi.getText("ui.common.rank","<span class=\'value\'>" + _spellItem.spellLevelInfos.grade + "</span>") + " (" + _spellItem.spellLevelInfos.id + ")";
         }
         return chunkParams;
      }
      
      private function getSpellZoneChunkParams(_spellItem:*) : Object
      {
         var i:Object = null;
         var areaText:String = null;
         var chunkParams:Object = {};
         var zoneEffect:Object = _spellItem.spellZoneEffects[0];
         var ray:uint = zoneEffect.zoneSize;
         for each(i in _spellItem.spellZoneEffects)
         {
            if(_spellItem.spellLevelInfos.effects[_spellItem.spellZoneEffects.indexOf(i)].visibleInTooltip && i.zoneShape != 0 && i.zoneSize < 63 && (i.zoneSize > ray || i.zoneSize == ray && zoneEffect.zoneShape == SpellShapeEnum.P || !_spellItem.spellLevelInfos.effects[_spellItem.spellZoneEffects.indexOf(zoneEffect)].visibleInTooltip))
            {
               ray = i.zoneSize;
               zoneEffect = i;
            }
         }
         switch(zoneEffect.zoneShape)
         {
            case SpellShapeEnum.minus:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.diagonal",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.A:
            case SpellShapeEnum.a:
               areaText = this.uiApi.getText("ui.spellarea.everyone");
               break;
            case SpellShapeEnum.C:
               if(zoneEffect.zoneSize == 63)
               {
                  areaText = this.uiApi.getText("ui.spellarea.everyone");
               }
               else
               {
                  areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.circle",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               }
               break;
            case SpellShapeEnum.D:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.chessboard",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.L:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.line",zoneEffect.zoneSize + 1),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.O:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.ring",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.Q:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.crossVoid",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.T:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.tarea",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.U:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.halfcircle",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.V:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.cone",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.X:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.cross",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.G:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.square",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.plus:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.plus",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.star:
               areaText = this.uiApi.processText(this.uiApi.getText("ui.spellarea.star",zoneEffect.zoneSize),"m",zoneEffect.zoneSize <= 1);
               break;
            case SpellShapeEnum.P:
         }
         chunkParams.spellZone = areaText;
         return chunkParams;
      }
      
      public function addApCost() : void
      {
         var apCost:Number = !!this._param.isTheoretical ? Number(this._spellItem.spellLevelInfos["apCost"]) : Number(this._spellItem.apCost);
         _content += _block.getChunk("pWithClass").processContent({
            "text":this.uiApi.getText("ui.common.cost") + Api.ui.getText("ui.common.colon") + " <span class=\'value\'>" + apCost + this.uiApi.getText("ui.common.ap") + "</span>",
            "classCss":"valueLine"
         });
      }
      
      public function addRange() : void
      {
         var strRange:* = null;
         var range:Number = !!this._param.isTheoretical ? Number(this._spellItem.spellLevelInfos["minRange"]) : Number(this._spellItem.minimalRange);
         var maxRange:Number = !!this._param.isTheoretical ? Number(this._spellItem.maximalRange) : Number(this._spellItem.maximalRangeWithBoosts);
         var isBoostableRange:Boolean = !!this._param.isTheoretical ? Boolean(this._spellItem.spellLevelInfos["rangeCanBeBoosted"]) : Boolean(this._spellItem.rangeCanBeBoosted);
         if(range == maxRange)
         {
            strRange = maxRange.toString();
         }
         else
         {
            strRange = range + " - " + maxRange;
         }
         if(isBoostableRange)
         {
            strRange += " (" + this.uiApi.getText("ui.spell.rangeBoost") + ")";
         }
         strRange = this.uiApi.getText("ui.common.range") + Api.ui.getText("ui.common.colon") + " <span class=\'value\'>" + strRange + "</span>";
         _content += _block.getChunk("pWithClass").processContent({
            "text":strRange,
            "classCss":"valueLine"
         });
      }
      
      public function getCriticalPercent(criticalRate:Number) : Number
      {
         if(criticalRate > 55)
         {
            criticalRate = 55;
         }
         var criticalPercent:int = 55 - 1 / (1 / criticalRate);
         if(criticalPercent > 100)
         {
            criticalPercent = 100;
         }
         return criticalPercent;
      }
      
      public function addCriticalHit() : void
      {
         var baseCriticalRate:Number = this._spellItem.criticalHitProbability;
         if(isNaN(baseCriticalRate))
         {
            baseCriticalRate = 0;
         }
         var criticalRate:Number = !!this._param.isTheoretical ? Number(baseCriticalRate) : Number(this._spellItem.playerCriticalRate);
         if(isNaN(criticalRate))
         {
            criticalRate = 0;
         }
         if(this._param.isTheoretical)
         {
            if(baseCriticalRate === 0)
            {
               return;
            }
         }
         else if(baseCriticalRate === 0 && criticalRate === 0)
         {
            return;
         }
         _content += _block.getChunk("pWithClass").processContent({
            "text":this.uiApi.getText("ui.common.critical") + Api.ui.getText("ui.common.colon") + " <span class=\'value\'>" + this.getCriticalPercent(criticalRate) + "%" + "</span>",
            "classCss":"valueLine"
         });
      }
      
      public function onAllChunkLoaded() : void
      {
         var chunkParams:Object = null;
         var state:int = 0;
         var spellState:Object = null;
         _content = "";
         if(this._param.name)
         {
            chunkParams = this.getSpellHeaderChunkParams(this._spellItem);
            _content += _block.getChunk("header").processContent(chunkParams);
            _content += _block.getChunk("separator").processContent({});
         }
         this.addApCost();
         this.addRange();
         this.addCriticalHit();
         chunkParams = this.getSpellZoneChunkParams(this._spellItem);
         if(chunkParams.spellZone)
         {
            _content += _block.getChunk("detailsSpellZone").processContent(chunkParams);
         }
         if(this._param.isTheoretical && this._spellItem.spellLevelInfos["castInLine"] && this._spellItem.spellLevelInfos["range"] || !this._param.isTheoretical && this._spellItem.castInLine && this._spellItem.range)
         {
            _content += _block.getChunk("pWithClass").processContent({
               "text":this.uiApi.getText("ui.spellInfo.castInLine"),
               "classCss":"valueLine"
            });
         }
         if(this._param.isTheoretical && this._spellItem.spellLevelInfos["castInDiagonal"] && this._spellItem.spellLevelInfos["range"] || !this._param.isTheoretical && this._spellItem.castInDiagonal && this._spellItem.range)
         {
            _content += _block.getChunk("pWithClass").processContent({
               "text":this.uiApi.getText("ui.spellInfo.castInDiagonal"),
               "classCss":"valueLine"
            });
         }
         if(this._param.isTheoretical && this._spellItem.maximalRange > 1 && !this._spellItem.spellLevelInfos["castTestLos"] && this._spellItem.spellLevelInfos["range"] || !this._param.isTheoretical && this._spellItem.maximalRangeWithBoosts > 1 && !this._spellItem.castTestLos && this._spellItem.range)
         {
            _content += _block.getChunk("pWithClass").processContent({
               "text":this.uiApi.getText("ui.spellInfo.castWithoutLos"),
               "classCss":"valueLine"
            });
         }
         if(this._spellItem.needTakenCell)
         {
            _content += _block.getChunk("p").processContent({"text":this.uiApi.getText("ui.spellInfo.castNeedTakenCell")});
         }
         var maxCastPerTarget:Number = !!this._param.isTheoretical ? Number(this._spellItem.spellLevelInfos["maxCastPerTarget"]) : Number(this._spellItem.maxCastPerTarget);
         if(maxCastPerTarget)
         {
            _content += _block.getChunk("pWithClass").processContent({
               "text":this.uiApi.getText("ui.spellInfo.maxCastPerTarget") + Api.ui.getText("ui.common.colon") + " <span class=\'value\'>" + maxCastPerTarget + "</span>",
               "classCss":"valueLine"
            });
         }
         if(this._spellItem.maxStack > 0)
         {
            _content += _block.getChunk("detailsEffect").processContent({
               "text":this.uiApi.getText("ui.spellInfo.maxStack") + Api.ui.getText("ui.common.colon"),
               "value":this._spellItem.maxStack
            });
         }
         var maxCastPerTurn:Number = !!this._param.isTheoretical ? Number(this._spellItem.spellLevelInfos["maxCastPerTurn"]) : Number(this._spellItem.maxCastPerTurn);
         if(maxCastPerTurn)
         {
            _content += _block.getChunk("pWithClass").processContent({
               "text":this.uiApi.processText(this.uiApi.getText("ui.item.usePerTurn"," <span class=\'value\'>" + maxCastPerTurn + "</span>"),"n",maxCastPerTurn <= 1),
               "classCss":"valueLine"
            });
         }
         var minCastInterval:Number = !!this._param.isTheoretical ? Number(this._spellItem.spellLevelInfos["minCastInterval"]) : Number(this._spellItem.minCastInterval);
         if(minCastInterval)
         {
            _content += _block.getChunk("pWithClass").processContent({
               "text":this.uiApi.getText("ui.spellInfo.minCastInterval") + Api.ui.getText("ui.common.colon") + " <span class=\'value\'>" + minCastInterval + "</span>",
               "classCss":"valueLine"
            });
         }
         if(this._spellItem.globalCooldown)
         {
            if(this._spellItem.globalCooldown == -1)
            {
               _content += _block.getChunk("p").processContent({"text":this.uiApi.getText("ui.spellInfo.globalCastInterval")});
            }
            else
            {
               _content += _block.getChunk("detailsEffect").processContent({
                  "text":this.uiApi.getText("ui.spellInfo.globalCastInterval") + Api.ui.getText("ui.common.colon"),
                  "value":this._spellItem.globalCooldown
               });
            }
         }
         if(this._spellItem.statesRequired.length > 0)
         {
            for each(state in this._spellItem.statesRequired)
            {
               spellState = this.dataApi.getSpellState(state);
               if(!spellState.isSilent)
               {
                  _content += _block.getChunk("detailsEffect").processContent({
                     "text":this.uiApi.getText("ui.spellInfo.stateRequired") + Api.ui.getText("ui.common.colon"),
                     "value":spellState.name
                  });
               }
            }
         }
         if(this._spellItem.statesForbidden.length > 0)
         {
            for each(state in this._spellItem.statesForbidden)
            {
               spellState = this.dataApi.getSpellState(state);
               if(!spellState.isSilent)
               {
                  _content += _block.getChunk("detailsEffect").processContent({
                     "text":this.uiApi.getText("ui.spellInfo.stateForbidden") + Api.ui.getText("ui.common.colon"),
                     "value":spellState.name
                  });
               }
            }
         }
         this.removeApis();
      }
      
      private function addApis() : void
      {
         this.sysApi = Api.system;
         this.uiApi = Api.ui;
         this.dataApi = Api.data;
         this.playerApi = Api.player;
      }
      
      private function removeApis() : void
      {
         this.sysApi = null;
         this.uiApi = null;
         this.playerApi = null;
         this.dataApi = null;
      }
   }
}

class paramClass
{
    
   
   public var contextual:Boolean = false;
   
   public var smallSpell:Boolean = false;
   
   public var isTheoretical:Boolean = false;
   
   public var name:Boolean = true;
   
   public var shortcutKey:String;
   
   function paramClass()
   {
      super();
   }
}
