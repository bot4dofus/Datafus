package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.quest.AchievementRewardsWrapper;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   
   public class AchievementModsterTooltipUi
   {
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      private var _achievement:Achievement;
      
      public var backgroundCtr:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var lbl_content:Label;
      
      public var tx_tempoton:Texture;
      
      public var lbl_quantity:Label;
      
      public function AchievementModsterTooltipUi()
      {
         super();
      }
      
      public function main(oParams:* = null) : void
      {
         var item:ItemWrapper = null;
         var i:uint = 0;
         this._achievement = oParams.data as Achievement;
         this.backgroundCtr.height = 0;
         this.lbl_title.text = this._achievement.name;
         this.lbl_content.text = this._achievement.description;
         this.lbl_title.fullWidthAndHeight(0,10);
         this.lbl_content.fullWidthAndHeight(0,10);
         var achievementRewards:AchievementRewardsWrapper = this._achievement.getAchievementRewardByLevel(this.playerApi.getPlayedCharacterInfo().level);
         if(achievementRewards && achievementRewards.itemsReward.length)
         {
            for(i = 0; i < achievementRewards.itemsReward.length; i++)
            {
               item = this.dataApi.getItemWrapper(achievementRewards.itemsReward[i],0,0,achievementRewards.itemsQuantityReward[i]);
               this.tx_tempoton.uri = item.iconUri;
               this.lbl_quantity.text = "x" + item.quantity;
            }
            this.tx_tempoton.y = this.lbl_content.y + this.lbl_content.textHeight + 5;
            this.lbl_quantity.x = this.tx_tempoton.x + this.tx_tempoton.width;
            this.lbl_quantity.y = this.tx_tempoton.y + this.tx_tempoton.height - this.lbl_quantity.height;
            this.backgroundCtr.height = this.lbl_quantity.y + this.lbl_quantity.contentHeight + 14;
         }
         else
         {
            this.tx_tempoton.visible = false;
            this.backgroundCtr.height = this.lbl_content.y + this.lbl_content.contentHeight + 14;
         }
         if(this.lbl_content.x + this.lbl_content.width > this.lbl_title.x + this.lbl_title.width)
         {
            this.backgroundCtr.width = this.lbl_content.x + this.lbl_content.width + 14;
         }
         else
         {
            this.backgroundCtr.width = this.lbl_title.x + this.lbl_title.width + 14;
         }
         this.tooltipApi.place(oParams.position,oParams.showDirectionalArrow,oParams.point,oParams.relativePoint,oParams.offset);
      }
   }
}
