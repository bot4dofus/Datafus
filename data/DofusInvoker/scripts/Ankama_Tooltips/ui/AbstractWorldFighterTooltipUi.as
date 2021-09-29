package Ankama_Tooltips.ui
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.Tooltips;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import damageCalculation.tools.StatIds;
   import flash.events.TimerEvent;
   
   public class AbstractWorldFighterTooltipUi
   {
      
      public static const TX_ICON_SIZES:int = 17;
      
      public static const TX_LINE_HEIGHT:int = 1;
      
      public static const Y_GAP:int = 2;
      
      public static const Y_PADDING:int = 12;
      
      public static const SPACE_FOR_ICON:String = "   ";
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      protected var beforeLevelText:String;
      
      protected var specifiedLevel:int = -1;
      
      protected var _timerHide:BenchmarkTimer;
      
      protected var _icons:Vector.<Texture>;
      
      protected var _iconsLife:Vector.<Texture>;
      
      protected var _iconsLine:Vector.<Texture>;
      
      protected var offsetName:int = 0;
      
      public var lbl_name:Label;
      
      public var lbl_info:Label;
      
      public var lbl_damage:Label;
      
      public var lbl_fightStatus:Label;
      
      public var backgroundCtr:GraphicContainer;
      
      public var mainCtr:GraphicContainer;
      
      public var parentCtr:GraphicContainer = null;
      
      public function AbstractWorldFighterTooltipUi()
      {
         this._icons = new Vector.<Texture>(0);
         this._iconsLife = new Vector.<Texture>(0);
         this._iconsLine = new Vector.<Texture>(0);
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         if(this.parentCtr == null)
         {
            this.parentCtr = this.mainCtr;
         }
         this.beforeLevelText = Api.ui.getText("ui.common.level");
         this.updateContent(oParam);
         this.placeTooltip(oParam);
      }
      
      public function placeTooltip(oParam:Object) : void
      {
         var cellId:uint = oParam.makerParam && oParam.makerParam.cellId ? uint(oParam.makerParam.cellId) : uint(oParam.data.disposition.cellId);
         var offsetRect:IRectangle = oParam.makerParam && oParam.makerParam.offsetRect ? oParam.makerParam.offsetRect : null;
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset,true,cellId,offsetRect);
         if(oParam.autoHide)
         {
            this._timerHide = new BenchmarkTimer(ProtocolConstantsEnum.DEFAULT_TOOLTIP_DURATION,0,"AbstractWorldFighterTooltipUi._timerHide");
            this._timerHide.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerHide.start();
         }
      }
      
      public function updateContent(oParam:Object) : void
      {
         var tx:Texture = null;
         var offsetIcon:Number = NaN;
         for each(tx in this._icons)
         {
            tx.remove();
         }
         this._icons.length = 0;
         for each(tx in this._iconsLife)
         {
            tx.remove();
         }
         this._iconsLife.length = 0;
         for each(tx in this._iconsLine)
         {
            tx.remove();
         }
         this._iconsLine.length = 0;
         this.updateName(oParam);
         this.updateInfo(oParam);
         this.updateState(oParam);
         offsetIcon = this.updateSpellEffect(oParam);
         this.alignLabels(offsetIcon);
         if(!(oParam.makerParam && oParam.makerParam.spellDamage) || this.fightApi.isMouseOverFighter(oParam.data.contextualId))
         {
            this.lbl_name.alpha = 1;
         }
         else
         {
            this.lbl_name.alpha = 0.7;
         }
         var hasPrevizuInfo:Boolean = oParam.makerParam && oParam.makerParam.spellDamage;
         this.backgroundCtr.height = this.lbl_info.textHeight + this.lbl_name.textHeight + (!!hasPrevizuInfo ? this.lbl_damage.height : this.lbl_damage.textHeight) + this.lbl_fightStatus.textHeight + Y_PADDING * 1.5;
      }
      
      protected function updateName(oParam:Object) : void
      {
         var stats:EntityStats = null;
         var shieldPoints:Number = NaN;
         this.lbl_name.y = 0;
         this.lbl_name.text = "";
         if(Api.fight.preFightIsActive())
         {
            this.lbl_name.text = Api.fight.getFighterName(oParam.data.contextualId);
            this.lbl_name.fullWidthAndHeight();
         }
         else
         {
            stats = StatsManager.getInstance().getStats(oParam.data.contextualId);
            this.lbl_name.appendText(Api.fight.getFighterName(oParam.data.contextualId) + " | " + stats.getHealthPoints());
            this.lbl_name.fullWidthAndHeight();
            this.addIcon(Tooltips.STATS_ICONS_PATH + "pv.png",this.offsetName + this.lbl_name.width,this.lbl_name.y + (this.lbl_name.height - TX_ICON_SIZES) / 2 - Y_GAP,this._iconsLife);
            shieldPoints = stats.getStatTotalValue(StatIds.SHIELD);
            if(shieldPoints > 0)
            {
               this.lbl_name.appendText(SPACE_FOR_ICON + "+" + shieldPoints);
               this.lbl_name.fullWidthAndHeight();
               this.addIcon(Tooltips.STATS_ICONS_PATH + "armor.png",this.offsetName + this.lbl_name.width,this.lbl_name.y + (this.lbl_name.height - TX_ICON_SIZES) / 2 - Y_GAP,this._iconsLife);
            }
            this.lbl_name.fullWidthAndHeight();
            this.lbl_name.width += TX_ICON_SIZES;
         }
         this.parentCtr.addContent(this.lbl_name);
      }
      
      protected function updateInfo(oParam:Object) : void
      {
         var level:int = 0;
         this.lbl_info.y = this.lbl_name.y + (this.lbl_name.text == "" ? 0 : this.lbl_name.height);
         if(Api.fight.preFightIsActive())
         {
            level = this.specifiedLevel > -1 ? int(this.specifiedLevel) : int(Api.fight.getFighterLevel(oParam.data.contextualId));
            this.lbl_info.text = this.beforeLevelText + " " + level;
            this.parentCtr.addContent(this.lbl_info);
         }
         else
         {
            this.lbl_info.text = "";
         }
         this.lbl_info.fullWidthAndHeight();
      }
      
      protected function updateState(oParam:Object) : void
      {
         var chatColors:Object = null;
         var fightStatus:String = null;
         var fightStatusStr:* = null;
         this.lbl_fightStatus.text = "";
         this.lbl_fightStatus.width = 1;
         this.lbl_fightStatus.y = this.lbl_info.y + (this.lbl_info.text == "" ? 0 : this.lbl_info.height);
         this.lbl_fightStatus.removeFromParent();
         if(oParam.makerParam && oParam.makerParam.fightStatus)
         {
            this.parentCtr.addContent(this.lbl_fightStatus);
            chatColors = this.chatApi.getChatColors();
            fightStatus = this.dataApi.getSpellState(oParam.makerParam.fightStatus).name;
            fightStatusStr = "<font color=\"#" + chatColors[10].toString(16) + "\">" + fightStatus + "</font>";
            this.lbl_fightStatus.appendText(fightStatusStr);
            this.lbl_fightStatus.fullWidthAndHeight();
         }
      }
      
      protected function updateSpellEffect(oParam:Object) : Number
      {
         var offsetIcon:Number = 0;
         this.lbl_damage.text = "";
         this.lbl_damage.width = 1;
         this.lbl_damage.removeFromParent();
         this.lbl_damage.y = this.lbl_fightStatus.y + (this.lbl_fightStatus.text == "" ? 0 : this.lbl_fightStatus.height);
         if(oParam.makerParam && oParam.makerParam.spellDamage)
         {
            this.parentCtr.addContent(this.lbl_damage);
            this.lbl_damage.appendText(oParam.makerParam.spellDamage);
            this.lbl_damage.fullWidthAndHeight();
            offsetIcon = this.showDamagePreviewIcons(this.lbl_damage,this.getMaxLabelWidth(),oParam.makerParam.spellDamage.effectIcons);
         }
         return offsetIcon;
      }
      
      protected function alignLabels(offset:Number) : void
      {
         var txLife:Texture = null;
         var tx:Texture = null;
         var maxWidth:Number = this.getMaxLabelWidth();
         var halfMaxWidth:Number = maxWidth / 2;
         this.lbl_name.x = halfMaxWidth - this.lbl_name.width / 2 + this.offsetName / 2 + offset;
         this.lbl_info.x = halfMaxWidth - this.lbl_info.width / 2 + offset;
         this.lbl_damage.x = halfMaxWidth - this.lbl_damage.width / 2 + offset;
         this.lbl_fightStatus.x = halfMaxWidth - this.lbl_fightStatus.width / 2 + offset;
         this.backgroundCtr.width = maxWidth + 12 + offset;
         for each(txLife in this._iconsLife)
         {
            txLife.x += this.lbl_name.x;
         }
         for each(tx in this._iconsLine)
         {
            tx.width = this.backgroundCtr.width * 0.75;
            tx.x = (this.backgroundCtr.width - tx.width) / 2;
            tx.finalize();
         }
      }
      
      public function unload() : void
      {
         if(this._timerHide)
         {
            this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerHide.stop();
            this._timerHide = null;
         }
      }
      
      protected function getMaxLabelWidth() : Number
      {
         var maxWidth:Number = NaN;
         if(this.lbl_info.text != "")
         {
            maxWidth = this.lbl_info.width;
         }
         if(this.lbl_name.text != "" && (isNaN(maxWidth) || this.lbl_name.width + this.offsetName > maxWidth))
         {
            maxWidth = this.lbl_name.width + this.offsetName;
         }
         if(this.lbl_damage.text != "" && (isNaN(maxWidth) || this.lbl_damage.width > maxWidth))
         {
            maxWidth = this.lbl_damage.width;
         }
         if(this.lbl_fightStatus.text != "" && (isNaN(maxWidth) || this.lbl_fightStatus.width > maxWidth))
         {
            maxWidth = this.lbl_fightStatus.width;
         }
         return maxWidth;
      }
      
      protected function onTimer(e:TimerEvent) : void
      {
         this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimer);
         this._timerHide.stop();
         this.uiApi.hideTooltip(this.uiApi.me().name);
      }
      
      protected function addIcon(uri:String, posX:Number, posY:Number, container:Vector.<Texture>, width:Number = 17, height:Number = 17) : Texture
      {
         var tx_icon:Texture = Api.ui.createComponent("Texture") as Texture;
         tx_icon.uri = Api.ui.createUri(uri);
         tx_icon.width = width;
         tx_icon.height = height;
         tx_icon.x = posX;
         tx_icon.y = posY;
         tx_icon.finalize();
         this.parentCtr.addContent(tx_icon);
         container.push(tx_icon);
         return tx_icon;
      }
      
      protected function showDamagePreviewIcons(pLabel:Label, pMaxWidth:Number, pEffectIcons:Array) : Number
      {
         var line:String = null;
         var i:int = 0;
         var tx_icon:Texture = null;
         var lineSize:Object = null;
         var tx:Texture = null;
         var offsetIcon:Number = 0;
         var centerX:Number = pMaxWidth / 2;
         for(i = 0; i < pLabel.textfield.numLines; i++)
         {
            line = pLabel.textfield.getLineText(i);
            lineSize = Api.ui.getTextSize(line,pLabel.css,pLabel.cssClass);
            if(pEffectIcons[i])
            {
               if(pEffectIcons[i].indexOf("common") != -1)
               {
                  tx_icon = this.addIcon(Tooltips.STATS_ICONS_PATH.substring(0,Tooltips.STATS_ICONS_PATH.indexOf("texture")) + "/" + pEffectIcons[i] + ".png",0,pLabel.y + lineSize.height * i + (lineSize.height - TX_LINE_HEIGHT) / 2 + Y_GAP,this._icons,TX_ICON_SIZES,TX_LINE_HEIGHT);
                  tx_icon.alpha = 0.5;
                  this._iconsLine.push(tx_icon);
               }
               else
               {
                  tx_icon = this.addIcon(Tooltips.STATS_ICONS_PATH + pEffectIcons[i] + ".png",centerX - lineSize.width / 2 - TX_ICON_SIZES - 2 + offsetIcon,pLabel.y + lineSize.height * i + (lineSize.height - TX_ICON_SIZES) / 2 + Y_GAP,this._icons);
               }
               if(tx_icon.x < 0)
               {
                  offsetIcon = Math.abs(tx_icon.x);
                  for each(tx in this._icons)
                  {
                     tx.x += offsetIcon;
                  }
                  tx_icon.x = 0;
               }
            }
         }
         return offsetIcon;
      }
   }
}
