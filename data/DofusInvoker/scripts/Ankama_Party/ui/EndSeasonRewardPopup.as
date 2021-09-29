package Ankama_Party.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.arena.ArenaLeague;
   import com.ankamagames.dofus.datacenter.arena.ArenaLeagueReward;
   import com.ankamagames.dofus.datacenter.arena.ArenaLeagueSeason;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class EndSeasonRewardPopup
   {
       
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      public var btn_close_popup:ButtonContainer;
      
      public var btn_openTitleOrnament:ButtonContainer;
      
      public var tx_illu:Texture;
      
      public var lbl_title:Label;
      
      public var lbl_content:Label;
      
      public var lbl_division:Label;
      
      public function EndSeasonRewardPopup()
      {
         super();
      }
      
      public function main(args:Object) : void
      {
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         if(this.btn_close_popup)
         {
            this.btn_close_popup.soundId = SoundEnum.WINDOW_CLOSE;
         }
         if(!args)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         var season:ArenaLeagueSeason = this.dataApi.getArenaLeagueSeasonById(args.seasonId);
         var league:ArenaLeague = this.dataApi.getArenaLeagueById(args.leagueId);
         var rewards:ArenaLeagueReward = this.dataApi.getArenaLeagueRewardsForCurrentRankAndSeason(league.id,season.id,true);
         if(!season || !league || !rewards)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         this.tx_illu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("leagueIllus") + league.illus + ".jpg");
         this.lbl_title.text = this.uiApi.getText("ui.party.endSeasonNumber",[season.name]);
         this.lbl_content.text = this.utilApi.applyTextParams(this.uiApi.getText("ui.party.endSeasonReward"),[league.name,rewards.titlesRewards[0]]);
         this.lbl_division.text = league.name;
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close_popup:
               this.closeMe();
               break;
            case this.btn_openTitleOrnament:
               this.sysApi.sendAction(new OpenBookAction(["titleTab"]));
               this.closeMe();
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
            case "closeUi":
               this.closeMe();
               return true;
            default:
               return false;
         }
      }
      
      private function closeMe() : void
      {
         if(this.uiApi)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
   }
}
