package Ankama_Tooltips.ui
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.dofus.internalDatacenter.guild.PaddockInstanceWrapper;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class WorldRpPaddockTooltipUi
   {
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      public var lbl_type:Label;
      
      public var lbl_paddockSize:Label;
      
      public var lbl_instancesList:Label;
      
      public var infosCtr:Object;
      
      public function WorldRpPaddockTooltipUi()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var guildColor:String = null;
         var content:* = null;
         var hasGuild:Boolean = false;
         var paddockInstance:PaddockInstanceWrapper = null;
         var guildName:* = null;
         if(oParam.data.paddockInstances.length == 0)
         {
            this.lbl_type.text = this.uiApi.getText("ui.mount.paddockPublic");
            this.lbl_paddockSize.text = this.uiApi.getText("ui.mount.maxMount",oParam.data.maxItems);
         }
         else
         {
            guildColor = (this.sysApi.getConfigEntry("colors.tooltip.text.violet") as String).replace("0x","#");
            this.lbl_type.text = this.uiApi.getText("ui.mount.paddockPrivate");
            this.lbl_paddockSize.text = this.uiApi.getText("ui.mount.paddockSize",oParam.data.maxItems);
            content = "";
            hasGuild = false;
            for each(paddockInstance in oParam.data.paddockInstances)
            {
               if(paddockInstance.guildIdentity)
               {
                  hasGuild = true;
                  guildName = "<font color=\'" + guildColor + "\'>" + paddockInstance.guildIdentity.guildName + "</font>";
                  if(Api.social.getGuild() && paddockInstance.guildIdentity.guildId == Api.social.getGuild().guildId)
                  {
                     guildName = "<b>" + guildName + "</b>";
                  }
                  content += guildName + " ";
                  if(paddockInstance.isAbandonned)
                  {
                     content += "(" + this.uiApi.getText("ui.mount.paddockAbandonned") + ")";
                  }
               }
               if(paddockInstance.price > 0)
               {
                  if(hasGuild)
                  {
                     content += "(";
                  }
                  if(paddockInstance.isSaleLocked)
                  {
                     content += this.uiApi.getText("ui.mount.paddockToBuySoon",this.utilApi.kamasToString(paddockInstance.price));
                  }
                  else
                  {
                     content += this.uiApi.getText("ui.mount.paddockToBuy",this.utilApi.kamasToString(paddockInstance.price));
                  }
                  if(hasGuild)
                  {
                     content += ")";
                  }
               }
               content += "\n";
            }
            this.lbl_instancesList.text = "\n\n" + content;
         }
         var longestLabel:Label = this.findLongestLabel(this.findLongestLabel(this.lbl_type,this.lbl_paddockSize),this.lbl_instancesList);
         this.infosCtr.width = longestLabel.x + longestLabel.textfield.width + 8;
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset);
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
   }
}
