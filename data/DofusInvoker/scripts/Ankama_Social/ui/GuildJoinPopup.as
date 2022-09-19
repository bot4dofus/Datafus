package Ankama_Social.ui
{
   import Ankama_Common.ui.TextButtonPopup;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.EmblemSymbol;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildJoinRequestAction;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class GuildJoinPopup extends TextButtonPopup
   {
       
      
      public var tx_emblemUpGuild:Texture;
      
      public var tx_emblemBackGuild:Texture;
      
      public var lbl_guildName:Label;
      
      protected var guild:GuildWrapper;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      public function GuildJoinPopup()
      {
         super();
      }
      
      override public function main(params:Object) : void
      {
         if(!params.hasOwnProperty("title"))
         {
            params.title = uiApi.getText("ui.guild.joinAGuild");
         }
         if(!params.hasOwnProperty("content"))
         {
            params.content = uiApi.getText("ui.guild.joinAutoRecruitment");
         }
         if(!params.hasOwnProperty("buttonText"))
         {
            params.buttonText = [uiApi.getText("ui.guild.joinGuild"),uiApi.getText("ui.common.cancel")];
         }
         if(!params.hasOwnProperty("buttonCallback"))
         {
            params.buttonCallback = [this.join,this.cancel];
         }
         if(!params.hasOwnProperty("onCancel"))
         {
            params.onCancel = this.cancel;
         }
         if(!params.hasOwnProperty("onEnterKey"))
         {
            params.onEnterKey = this.join;
         }
         this.guild = params.guild as GuildWrapper;
         uiApi.addComponentHook(this.tx_emblemBackGuild,ComponentHookList.ON_TEXTURE_READY);
         uiApi.addComponentHook(this.tx_emblemUpGuild,ComponentHookList.ON_TEXTURE_READY);
         this.tx_emblemUpGuild.uri = this.guild.upEmblem.fullSizeIconUri;
         this.tx_emblemBackGuild.uri = this.guild.backEmblem.fullSizeIconUri;
         this.lbl_guildName.text = this.chatApi.getGuildLink(this.guild,this.guild.guildName);
         this.lbl_guildName.fullWidthAndHeight();
         this.tx_emblemBackGuild.x = (this.tx_emblemBackGuild.getParent().width - this.lbl_guildName.width - this.lbl_guildName.anchorX - this.tx_emblemBackGuild.width) / 2;
         height += this.tx_emblemBackGuild.height;
         super.main(params);
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var icon:EmblemSymbol = null;
         if(target == this.tx_emblemBackGuild)
         {
            this.utilApi.changeColor(this.tx_emblemBackGuild.getChildByName("back"),this.guild.backEmblem.color,1);
            uiApi.removeComponentHook(this.tx_emblemBackGuild,ComponentHookList.ON_TEXTURE_READY);
         }
         else if(target == this.tx_emblemUpGuild)
         {
            uiApi.removeComponentHook(this.tx_emblemUpGuild,ComponentHookList.ON_TEXTURE_READY);
            icon = this.dataApi.getEmblemSymbol(this.guild.upEmblem.idEmblem);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(this.tx_emblemUpGuild,this.guild.upEmblem.color,0);
            }
            else
            {
               this.utilApi.changeColor(this.tx_emblemUpGuild,this.guild.upEmblem.color,0,true);
            }
         }
      }
      
      private function cancel() : void
      {
      }
      
      private function join() : void
      {
         sysApi.sendAction(new GuildJoinRequestAction([this.guild.guildId]));
      }
   }
}
