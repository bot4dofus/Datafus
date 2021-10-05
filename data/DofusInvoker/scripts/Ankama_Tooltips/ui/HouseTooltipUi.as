package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.house.HouseInstanceWrapper;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.TimerEvent;
   
   public class HouseTooltipUi
   {
      
      private static const MAX_LINES_COUNT:int = 30;
       
      
      private var _timerHide:BenchmarkTimer;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      public var lbl_type:Label;
      
      public var lbl_instancesList:Label;
      
      public var infosCtr:GraphicContainer;
      
      private var _guild:GuildWrapper;
      
      public function HouseTooltipUi()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var guildColor:String = null;
         var content:* = null;
         var hasGuild:Boolean = false;
         var houseIndex:int = 0;
         var houseInstance:HouseInstanceWrapper = null;
         var guildName:* = null;
         this.lbl_type.text = oParam.data.name;
         if(oParam.data.houseInstances.length > 0)
         {
            guildColor = (this.sysApi.getConfigEntry("colors.tooltip.text.violet") as String).replace("0x","#");
            content = "";
            hasGuild = false;
            houseIndex = 0;
            for each(houseInstance in oParam.data.houseInstances)
            {
               content += houseInstance.label;
               if(houseInstance.guildIdentity)
               {
                  hasGuild = true;
                  guildName = " - <font color=\'" + guildColor + "\'>" + houseInstance.guildIdentity.guildName + "</font> ";
                  content += " " + guildName;
               }
               if(houseInstance.isOnSale)
               {
                  if(houseInstance.isSaleLocked)
                  {
                     content += " (" + this.uiApi.getText("ui.mount.paddockToBuySoon",this.utilApi.kamasToString(houseInstance.price)) + ")";
                  }
                  else
                  {
                     content += " (" + this.uiApi.getText("ui.mount.paddockToBuy",this.utilApi.kamasToString(houseInstance.price)) + ")";
                  }
               }
               if(houseIndex >= MAX_LINES_COUNT - 1)
               {
                  content += "\n[...]";
               }
               content += "\n";
               houseIndex++;
            }
            this.lbl_instancesList.setStyleSheet(UiApi.styleForTagName);
            this.lbl_instancesList.htmlText = "\n" + content;
            this.lbl_instancesList.finalize();
         }
         var longestLabel:Label = this.findLongestLabel(this.lbl_type,this.lbl_instancesList);
         this.infosCtr.width = longestLabel.x + longestLabel.textfield.width + 8;
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset);
         if(oParam.autoHide)
         {
            this._timerHide = new BenchmarkTimer(ProtocolConstantsEnum.DEFAULT_TOOLTIP_DURATION,0,"HouseTooltipUi._timerHide");
            this._timerHide.addEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerHide.start();
         }
      }
      
      private function findLongestLabel(firstLabel:Label, secondLabel:Label) : Label
      {
         if(firstLabel.textfield.width + firstLabel.x > secondLabel.textfield.width + secondLabel.x)
         {
            return firstLabel;
         }
         if(firstLabel.textfield.width + firstLabel.x < secondLabel.textfield.width + secondLabel.x)
         {
            return secondLabel;
         }
         return firstLabel;
      }
      
      private function onTimer(e:TimerEvent) : void
      {
         this._timerHide.removeEventListener(TimerEvent.TIMER,this.onTimer);
         this._timerHide.stop();
         this.uiApi.hideTooltip(this.uiApi.me().name);
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
   }
}
