package Ankama_Tooltips.ui
{
   import Ankama_Tooltips.makers.SpellTooltipMaker;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.spells.SpellPair;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   
   public class SpellTooltipUi extends TooltipPinableBaseUi
   {
      
      protected static var MARGIN:int;
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      private var _timerHide:BenchmarkTimer;
      
      private var _timerDisplay:BenchmarkTimer;
      
      private var _spell;
      
      private var _param:Object;
      
      private var _htmlTextEffectiveValues:String;
      
      private var _htmlTextTheoreticalValues:String;
      
      private var _spellZoneIconUri:Uri;
      
      private var _useTheoreticalValues:Boolean = false;
      
      public var lbl_content:Label;
      
      public var tx_icon:Texture;
      
      public var tx_spellZoneIcon:Texture;
      
      public function SpellTooltipUi()
      {
         super();
      }
      
      override public function main(oParam:Object = null) : void
      {
         var fullText:String = null;
         var displayDelay:int = 0;
         MARGIN = this.lbl_content.x;
         var currentUiInstance:UiRootContainer = uiApi.me();
         this._param = oParam;
         this._spell = oParam.data;
         sysApi.addHook(HookList.FontActiveTypeChanged,this.onFontActiveTypeChanged);
         if(!(oParam.data is SpellPair))
         {
            this._useTheoreticalValues = sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus");
            if(this._param.makerParam && (!this._param.makerParam.hasOwnProperty("isCharacterCreation") || !this._param.makerParam.isCharacterCreation))
            {
               sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
            }
         }
         this.onFontActiveTypeChanged();
         this.lbl_content.multiline = true;
         this.lbl_content.text = oParam.tooltip.htmlText;
         if(!(oParam.data is SpellPair))
         {
            if(this.tx_icon)
            {
               this.tx_icon.uri = oParam.data.iconUri;
            }
            this._spellZoneIconUri = this.getSpellZoneIconUri();
            this.updateSpellZoneIcon();
         }
         if(oParam.makerParam && oParam.makerParam.hasOwnProperty("width"))
         {
            this.lbl_content.width = oParam.makerParam.width;
         }
         if(oParam.autoHide)
         {
            this._timerHide = new BenchmarkTimer(ProtocolConstantsEnum.DEFAULT_TOOLTIP_DURATION,0,"SpellTooltipUi._timerHide");
            this._timerHide.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerHide.start();
         }
         if(SpellTooltipMaker.SPELL_TAB_MODE)
         {
            SpellTooltipMaker.SPELL_TAB_MODE = false;
            if(uiApi.getUi("spellTab"))
            {
               uiApi.getUi("spellTab").getElement("toolTipContainer").addContent(currentUiInstance);
            }
            else if(uiApi.getUi("companionTab"))
            {
               uiApi.getUi("companionTab").getElement("ctr_spellTooltip").addContent(currentUiInstance);
            }
            else if(uiApi.getUi("shopPopup"))
            {
               uiApi.getUi("shopPopup").getElement("ctr_spellTooltip").addContent(currentUiInstance);
            }
         }
         if(uiApi.me().height > uiApi.getStageHeight() && oParam.makerParam && oParam.makerParam.description)
         {
            fullText = oParam.tooltip.htmlText;
            fullText = fullText.replace(this._spell.description,"[" + String.fromCharCode(8230) + "]");
            this.lbl_content.text = fullText;
         }
         if(backgroundCtr)
         {
            backgroundCtr.height = this.lbl_content.contentHeight + MARGIN * 2;
         }
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset);
         super.main(oParam);
         if((!oParam || !oParam.makerParam || !oParam.makerParam.hasOwnProperty("pinnable") || !oParam.makerParam.pinnable) && !isPin)
         {
            displayDelay = sysApi.getOption("spellTooltipDelay","dofus");
            if(displayDelay > 0)
            {
               mainCtr.visible = false;
               this._timerDisplay = new BenchmarkTimer(displayDelay,0,"SpellTooltipUi._timerDisplay");
               this._timerDisplay.addEventListener(TimerEvent.TIMER,this.onTimerDisplay);
               this._timerDisplay.start();
            }
            else if(displayDelay == -1)
            {
               uiApi.unloadUi(currentUiInstance.name);
            }
         }
      }
      
      private function onFontActiveTypeChanged() : void
      {
         var tooltipCssName:String = "tooltip_spell";
         var activeFontType:String = sysApi.getActiveFontType();
         if(activeFontType && activeFontType != "default")
         {
            tooltipCssName += "-" + activeFontType;
         }
         uiApi.setLabelStyleSheet(this.lbl_content,sysApi.getConfigEntry("config.ui.skin") + "css/" + tooltipCssName + ".css");
         if(backgroundCtr)
         {
            backgroundCtr.height = this.lbl_content.contentHeight + MARGIN * 2;
         }
      }
      
      private function updateTooltip() : void
      {
         if(backgroundCtr)
         {
            backgroundCtr.height = this.lbl_content.contentHeight + MARGIN * 2;
         }
         if(!isPin)
         {
            uiApi.me().x = uiApi.me().y = 0;
            this.tooltipApi.place(this._param.position,this._param.showDirectionalArrow,this._param.point,this._param.relativePoint,this._param.offset);
         }
         this.updateSpellZoneIcon();
      }
      
      private function updateSpellZoneIcon() : void
      {
         var spellZoneIconPos:Number = NaN;
         var spellZoneIconOffset:Rectangle = null;
         var savedHeight:Number = NaN;
         if(this._spellZoneIconUri)
         {
            this.tx_spellZoneIcon.uri = this._spellZoneIconUri;
            spellZoneIconPos = this.lbl_content.text.replace(/(\r\n|\r|\n)/g,"\n").indexOf(uiApi.getText("ui.common.spellArea"));
            spellZoneIconOffset = null;
            if(spellZoneIconPos != -1)
            {
               savedHeight = this.lbl_content.height;
               this.lbl_content.height = 2000;
               spellZoneIconOffset = this.lbl_content.getCharBoundaries(spellZoneIconPos);
               this.lbl_content.height = savedHeight;
            }
            if(spellZoneIconOffset == null)
            {
               this.tx_spellZoneIcon.visible = false;
            }
            else
            {
               this.tx_spellZoneIcon.visible = true;
               this.tx_spellZoneIcon.y = this.lbl_content.y + spellZoneIconOffset.y;
            }
         }
         else if(this.tx_spellZoneIcon)
         {
            this.tx_spellZoneIcon.visible = false;
         }
      }
      
      protected function onTimerDisplay(event:TimerEvent) : void
      {
         if(this._timerDisplay)
         {
            this._timerDisplay.removeEventListener(TimerEvent.TIMER,this.onTimerDisplay);
         }
         this._timerDisplay = null;
         mainCtr.visible = true;
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimer);
         this._timerHide.stop();
         uiApi.hideTooltip(uiApi.me().name);
      }
      
      public function unload() : void
      {
         if(this._timerDisplay)
         {
            this._timerDisplay.removeEventListener(TimerEvent.TIMER,this.onTimerDisplay);
            this._timerDisplay.stop();
            this._timerDisplay = null;
         }
         if(this._timerHide)
         {
            this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerHide.stop();
            this._timerHide = null;
         }
         if(sysApi)
         {
            sysApi.removeHook(BeriliaHookList.KeyUp);
            sysApi.removeHook(BeriliaHookList.KeyDown);
         }
      }
      
      private function getSpellZoneIconUri() : Uri
      {
         var i:Object = null;
         var uri:String = null;
         if(!this._spell || !this._spell.hasOwnProperty("spellZoneEffects") || !this._spell.spellZoneEffects || !this._spell.spellZoneEffects.length || !this._spell.spellZoneEffects[0])
         {
            return null;
         }
         var zoneEffect:Object = this._spell.spellZoneEffects[0];
         var ray:uint = zoneEffect.zoneSize;
         for each(i in this._spell.spellZoneEffects)
         {
            if(this._spell.spellLevelInfos.effects[this._spell.spellZoneEffects.indexOf(i)].visibleInTooltip && i.zoneShape != 0 && i.zoneSize < 63 && (i.zoneSize > ray || i.zoneSize == ray && zoneEffect.zoneShape == SpellShapeEnum.P || !this._spell.spellLevelInfos.effects[this._spell.spellZoneEffects.indexOf(zoneEffect)].visibleInTooltip))
            {
               ray = i.zoneSize;
               zoneEffect = i;
            }
         }
         switch(zoneEffect.zoneShape)
         {
            case SpellShapeEnum.minus:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|diagonal";
               break;
            case SpellShapeEnum.A:
            case SpellShapeEnum.a:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|everyone";
               break;
            case SpellShapeEnum.C:
               if(zoneEffect.zoneSize == 63)
               {
                  uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|everyone";
               }
               else
               {
                  uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|circle";
               }
               break;
            case SpellShapeEnum.D:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|checkerboard";
               break;
            case SpellShapeEnum.L:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|line";
               break;
            case SpellShapeEnum.O:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|ring";
               break;
            case SpellShapeEnum.Q:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|cross2";
               break;
            case SpellShapeEnum.T:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|line2";
               break;
            case SpellShapeEnum.U:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|alfcircle";
               break;
            case SpellShapeEnum.V:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|cone";
               break;
            case SpellShapeEnum.X:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|cross";
               break;
            case SpellShapeEnum.G:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|square";
               break;
            case SpellShapeEnum.plus:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|plus";
               break;
            case SpellShapeEnum.star:
               uri = sysApi.getConfigEntry("config.content.path") + "gfx/characteristics/spellAreas.swf|star";
               break;
            case SpellShapeEnum.P:
         }
         if(uri)
         {
            return uiApi.createUri(uri);
         }
         return null;
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         var tooltip:* = undefined;
         var maker:SpellTooltipMaker = null;
         if(!this._useTheoreticalValues && keyCode == Keyboard.CONTROL && this.lbl_content.text != this._htmlTextTheoreticalValues)
         {
            this._useTheoreticalValues = true;
            this.configApi.setConfigProperty("dofus","useTheoreticalValuesInSpellTooltips",this._useTheoreticalValues);
            if(this._param.makerParam)
            {
               this._param.makerParam.isTheoretical = this._useTheoreticalValues;
            }
            if(!this._htmlTextTheoreticalValues)
            {
               maker = new SpellTooltipMaker();
               if(this._param.makerParam && this._param.makerParam.hasOwnProperty("advanced"))
               {
                  this._param.makerParam.advanced = true;
               }
               tooltip = maker.createTooltip(this._spell,this._param.makerParam);
               this._htmlTextTheoreticalValues = tooltip.updateAndReturnHtmlText();
               if(!this._htmlTextTheoreticalValues)
               {
                  tooltip.askTooltip(sysApi.createCallback(function(args:Array):void
                  {
                     lbl_content.text = tooltip.htmlText;
                     updateTooltip();
                  }));
                  return;
               }
            }
            this.lbl_content.text = this._htmlTextTheoreticalValues;
            this.updateTooltip();
         }
         else if(this._useTheoreticalValues && keyCode == Keyboard.CONTROL && this.lbl_content.text != this._htmlTextEffectiveValues)
         {
            this._useTheoreticalValues = false;
            this.configApi.setConfigProperty("dofus","useTheoreticalValuesInSpellTooltips",this._useTheoreticalValues);
            if(this._param.makerParam)
            {
               this._param.makerParam.isTheoretical = this._useTheoreticalValues;
            }
            if(!this._htmlTextEffectiveValues)
            {
               maker = new SpellTooltipMaker();
               tooltip = maker.createTooltip(this._spell,this._param.makerParam);
               this._htmlTextEffectiveValues = tooltip.updateAndReturnHtmlText();
               if(!this._htmlTextEffectiveValues)
               {
                  tooltip.askTooltip(sysApi.createCallback(function(args:Array):void
                  {
                     lbl_content.text = tooltip.htmlText;
                     updateTooltip();
                  }));
                  return;
               }
            }
            this.lbl_content.text = this._htmlTextEffectiveValues;
            this.updateTooltip();
         }
      }
   }
}
