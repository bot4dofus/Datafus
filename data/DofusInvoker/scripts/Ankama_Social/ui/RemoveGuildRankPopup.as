package Ankama_Social.ui
{
   import Ankama_Common.ui.TextButtonPopup;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.logic.game.common.actions.guild.RemoveGuildRankRequestAction;
   import com.ankamagames.dofus.network.types.game.guild.GuildRankInformation;
   import com.ankamagames.dofus.uiApi.SocialApi;
   
   public class RemoveGuildRankPopup extends TextButtonPopup
   {
       
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      public var ctr_associateRank:GraphicContainer;
      
      public var ctr_rankComboBox:GraphicContainer;
      
      public var lbl_currentRank:Label;
      
      public var lbl_associateRank:Label;
      
      public var cbb_ranks:ComboBox;
      
      private var _guildRankToRemove:GuildRankInformation;
      
      private var _replacementGuildRank:GuildRankInformation;
      
      private var _othersGuildRank:Array;
      
      public function RemoveGuildRankPopup()
      {
         super();
      }
      
      override public function main(params:Object) : void
      {
         this._guildRankToRemove = params.guildRankInfo as GuildRankInformation;
         if(!params.hasOwnProperty("title"))
         {
            params.title = uiApi.getText("ui.guild.removeRankTitle");
         }
         if(!params.hasOwnProperty("content"))
         {
            params.content = uiApi.getText("ui.guild.removeRankContent","");
         }
         if(!params.hasOwnProperty("buttonText"))
         {
            params.buttonText = [uiApi.getText("ui.popup.delete"),uiApi.getText("ui.common.cancel")];
         }
         if(!params.hasOwnProperty("buttonCallback"))
         {
            params.buttonCallback = [this.remove,this.cancel];
         }
         if(!params.hasOwnProperty("onCancel"))
         {
            params.onCancel = this.cancel;
         }
         if(!params.hasOwnProperty("onEnterKey"))
         {
            params.onEnterKey = this.remove;
         }
         this.lbl_currentRank.text = this._guildRankToRemove.name;
         this.lbl_associateRank.text = uiApi.getText("ui.guild.associateAnotherRank",this._guildRankToRemove.name);
         this.ctr_rankComboBox.y = this.lbl_associateRank.y + this.lbl_associateRank.contentHeight;
         height += this.ctr_associateRank.anchorY + this.ctr_associateRank.contentHeight;
         super.main(params);
         this.createComboBoxParams();
         this.selectNearestRank();
      }
      
      public function updateRankRightsLine(data:GuildRankInformation, components:*, selected:Boolean) : void
      {
         if(data)
         {
            components.lbl_cb_rankName.text = data.name;
            components.lbl_cb_rankName.verticalAlign = "center";
         }
      }
      
      private function createComboBoxParams() : void
      {
         var rank:GuildRankInformation = null;
         var guildRanks:Vector.<GuildRankInformation> = this.socialApi.getGuildRanks();
         this._othersGuildRank = [];
         for each(rank in guildRanks)
         {
            if(rank.id != this._guildRankToRemove.id && rank.order > this.socialApi.playerGuildRank.order)
            {
               this._othersGuildRank.push(rank);
            }
         }
         this.cbb_ranks.dataProvider = this._othersGuildRank;
      }
      
      private function selectNearestRank() : void
      {
         var nearestGuildRank:GuildRankInformation = null;
         var guildRank:GuildRankInformation = null;
         var orderDiff:int = int.MAX_VALUE;
         for each(guildRank in this._othersGuildRank)
         {
            if(guildRank.order > this._guildRankToRemove.order)
            {
               if(guildRank.order - this._guildRankToRemove.order < orderDiff)
               {
                  orderDiff = guildRank.order - this._guildRankToRemove.order;
                  nearestGuildRank = guildRank;
               }
            }
         }
         if(!nearestGuildRank)
         {
            nearestGuildRank = this._othersGuildRank[this._othersGuildRank.length - 1];
         }
         var index:int = this._othersGuildRank.indexOf(nearestGuildRank);
         this.cbb_ranks.selectedIndex = index;
      }
      
      private function cancel() : void
      {
      }
      
      private function remove() : void
      {
         sysApi.sendAction(RemoveGuildRankRequestAction.create(this._guildRankToRemove.id,this._replacementGuildRank.id));
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.cbb_ranks)
         {
            this._replacementGuildRank = (target as ComboBox).selectedItem as GuildRankInformation;
         }
      }
   }
}
