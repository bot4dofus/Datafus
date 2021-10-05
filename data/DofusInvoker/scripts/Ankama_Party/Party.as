package Ankama_Party
{
   import Ankama_Party.ui.EndSeasonRewardPopup;
   import Ankama_Party.ui.JoinParty;
   import Ankama_Party.ui.LeagueChangeRewardPopup;
   import Ankama_Party.ui.PartyDisplay;
   import Ankama_Party.ui.PvpArena;
   import Ankama_Party.ui.TeamSearch;
   import Ankama_Party.ui.items.PartyMember;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   
   public class Party extends Sprite
   {
      
      private static var _self:Party;
      
      public static const PARTY_DISPLAY_UI:String = "partyDisplay";
      
      public static const PARTY_JOIN_UI:String = "partyJoin";
      
      public static var CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA:Boolean;
       
      
      protected var teamSearch:TeamSearch = null;
      
      protected var partyDisplay:PartyDisplay = null;
      
      protected var partyMember:PartyMember = null;
      
      protected var joinParty:JoinParty = null;
      
      protected var pvpArena:PvpArena = null;
      
      protected var leagueChangeRewardPopup:LeagueChangeRewardPopup = null;
      
      protected var endSeasonRewardPopup:EndSeasonRewardPopup = null;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      private var _teamSearchTab:int;
      
      private var _teamSearchDonjon:int;
      
      public function Party()
      {
         super();
      }
      
      public static function getInstance() : Party
      {
         return _self;
      }
      
      public function main() : void
      {
         _self = this;
         this.sysApi.addHook(TriggerHookList.OpenTeamSearch,this.onOpenTeamSearch);
         this.sysApi.addHook(TriggerHookList.OpenArena,this.onOpenArena);
         this.sysApi.addHook(RoleplayHookList.ArenaLeagueRewards,this.onReceiveRewards);
         this.sysApi.addHook(HookList.PartyInvitation,this.onPartyInvitation);
         this.sysApi.addHook(HookList.PartyCannotJoinError,this.onPartyCannotJoinError);
         this.sysApi.addHook(HookList.PartyRefuseInvitationNotification,this.onPartyRefuseInvitationNotification);
         this.sysApi.addHook(HookList.PartyJoin,this.onPartyJoin);
         this.sysApi.addHook(HookList.PartyCancelledInvitation,this.onPartyCancelledInvitation);
      }
      
      public function get teamSearchTab() : int
      {
         return this._teamSearchTab;
      }
      
      public function set teamSearchTab(value:int) : void
      {
         this._teamSearchTab = value;
      }
      
      public function get teamSearchDonjon() : int
      {
         return this._teamSearchDonjon;
      }
      
      public function set teamSearchDonjon(value:int) : void
      {
         this._teamSearchDonjon = value;
      }
      
      public function onPartyInvitation(partyId:uint, fromName:String, leaderId:Number, typeId:uint, members:Object, guests:Object, dungeonId:uint = 0, membersReady:Object = null, partyName:String = "") : void
      {
         if(this.socialApi.isIgnored(fromName))
         {
            return;
         }
         if(this.uiApi.getUi(PARTY_JOIN_UI))
         {
            this.uiApi.unloadUi(PARTY_JOIN_UI);
         }
         this.uiApi.loadUi(PARTY_JOIN_UI,PARTY_JOIN_UI,[partyId,fromName,leaderId,typeId,members,guests,dungeonId,membersReady,partyName]);
      }
      
      public function onPartyJoin(id:int, pMembers:Object, restrict:Boolean, isArenaParty:Boolean, name:String = "") : void
      {
         if(this.uiApi.getUi(PARTY_JOIN_UI))
         {
            this.uiApi.unloadUi(PARTY_JOIN_UI);
         }
         if(!this.uiApi.getUi(PARTY_DISPLAY_UI))
         {
            this.uiApi.loadUi(PARTY_DISPLAY_UI,PARTY_DISPLAY_UI,{
               "partyMembers":pMembers,
               "restricted":restrict,
               "arena":isArenaParty,
               "id":id,
               "name":name
            });
         }
      }
      
      public function onOpenTeamSearch() : void
      {
         if(this.uiApi.getUi("teamSearch"))
         {
            this.uiApi.unloadUi("teamSearch");
         }
         else
         {
            this.uiApi.loadUi("teamSearch","teamSearch");
         }
      }
      
      public function onOpenArena() : void
      {
         if(this.uiApi.getUi("pvpArena"))
         {
            this.uiApi.unloadUi("pvpArena");
         }
         else
         {
            this.uiApi.loadUi("pvpArena","pvpArena");
         }
      }
      
      public function onReceiveRewards(seasonId:uint, leagueId:uint, ladderPosition:int, endSeason:Boolean) : void
      {
         if(endSeason)
         {
            if(this.uiApi.getUi("endSeasonRewardPopup"))
            {
               this.uiApi.unloadUi("endSeasonRewardPopup");
            }
            else
            {
               this.uiApi.loadUi("endSeasonRewardPopup","endSeasonRewardPopup",{
                  "seasonId":seasonId,
                  "leagueId":leagueId
               });
            }
         }
         else if(this.uiApi.getUi("leagueChangeRewardPopup"))
         {
            this.uiApi.unloadUi("leagueChangeRewardPopup");
         }
         else
         {
            this.uiApi.loadUi("leagueChangeRewardPopup","leagueChangeRewardPopup",{
               "seasonId":seasonId,
               "leagueId":leagueId
            });
         }
      }
      
      private function onPartyCannotJoinError(reason:String) : void
      {
         this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),reason,[this.uiApi.getText("ui.common.ok")]);
      }
      
      private function onPartyRefuseInvitationNotification() : void
      {
         if(this.uiApi.getUi(PARTY_JOIN_UI))
         {
            this.uiApi.unloadUi(PARTY_JOIN_UI);
         }
      }
      
      private function onPartyCancelledInvitation(partyId:uint = 0) : void
      {
         if(this.uiApi.getUi(PARTY_JOIN_UI))
         {
            this.uiApi.unloadUi(PARTY_JOIN_UI);
         }
      }
   }
}
