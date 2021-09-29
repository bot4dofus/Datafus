package Ankama_Party.ui.items
{
   import Ankama_Party.Party;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.people.PartyCompanionWrapper;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.PlayerStatusEnum;
   import com.ankamagames.dofus.network.enums.PvpArenaStepEnum;
   import com.ankamagames.dofus.uiApi.MountApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   
   public class PartyMember
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="MountApi")]
      public var mountApi:MountApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      private var _data;
      
      private var _selected:Boolean;
      
      private var _playerStatus:String = "";
      
      public var ctr_main:GraphicContainer;
      
      public var tx_bg:Texture;
      
      public var ed_player:EntityDisplayer;
      
      public var tx_leaderCrown:Texture;
      
      public var tx_followArrow:Texture;
      
      public var tx_guest:Texture;
      
      public var tx_arenaStatus:Texture;
      
      public var pb_lifePoints:ProgressBar;
      
      public var pb_lifePointsThreshold:ProgressBar;
      
      public function PartyMember()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this.sysApi.addHook(HookList.PartyMemberUpdate,this.onPartyMemberUpdate);
         this.sysApi.addHook(HookList.PartyMemberLifeUpdate,this.onPartyMemberLifeUpdate);
         this.sysApi.addHook(HookList.PartyMemberLifeThresholdUpdate,this.onPartyMemberLifeThresholdUpdate);
         this.sysApi.addHook(HookList.PartyCompanionMemberUpdate,this.onPartyCompanionMemberUpdate);
         this.sysApi.addHook(HookList.PartyMemberFollowUpdate,this.onPartyMemberFollowUpdate);
         this.sysApi.addHook(SocialHookList.PlayerStatusUpdate,this.onPartyMemberStatusUpdate);
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(RoleplayHookList.ArenaFighterStatusUpdate,this.onArenaFighterStatusUpdate);
         this.sysApi.addHook(RoleplayHookList.ArenaRegistrationStatusUpdate,this.onArenaRegistrationStatusUpdate);
         this.uiApi.addComponentHook(this.tx_followArrow,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_followArrow,ComponentHookList.ON_ROLL_OVER);
         this._data = oParam.data;
         this._selected = oParam.selected;
         this.ed_player.setAnimationAndDirection("AnimArtwork",3);
         this.ed_player.view = "timeline";
         var glow:GlowFilter = new GlowFilter(16777215,0.2,20,20,2,BitmapFilterQuality.HIGH);
         this.ed_player.filters = [glow];
         var charMask:Sprite = new Sprite();
         charMask.graphics.beginFill(16733440);
         charMask.graphics.drawRect(this.tx_bg.x,this.tx_bg.y,this.tx_bg.width,this.tx_bg.height);
         charMask.graphics.endFill();
         this.ctr_main.addChild(charMask);
         this.ed_player.mask = charMask;
         this.tx_followArrow.visible = false;
         this.tx_leaderCrown.visible = false;
         this.pb_lifePointsThreshold.value = 1;
         this.pb_lifePointsThreshold.width = 0;
         this.pb_lifePointsThreshold.visible = false;
         this.update(this._data,this._selected);
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function update(pData:*, selected:Boolean) : void
      {
         this._data = pData;
         if(this._data)
         {
            this.ed_player.look = this.mountApi.getRiderEntityLook(this._data.entityLook);
            this.tx_leaderCrown.visible = false;
            this.tx_guest.visible = false;
            this.tx_arenaStatus.visible = false;
            if(this._data is PartyCompanionWrapper)
            {
               this.tx_bg.alpha = 0.5;
            }
            else
            {
               this.tx_bg.alpha = 1;
            }
            if(!this._data.isMember)
            {
               this.pb_lifePoints.visible = false;
               this.pb_lifePointsThreshold.visible = false;
               this.tx_guest.visible = true;
            }
            else
            {
               if(this._data.isLeader)
               {
                  this.tx_leaderCrown.visible = true;
               }
               this.pb_lifePoints.value = this._data.lifePoints / this._data.maxLifePoints;
               this.pb_lifePoints.visible = true;
            }
            this.tx_followArrow.visible = !Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA && this.playerApi.getFollowingPlayerIds().indexOf(this._data.id) != -1 && !(this._data is PartyCompanionWrapper);
            switch(this.data.status)
            {
               case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                  this._playerStatus = "";
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.idle");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_AFK:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.away");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.private");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.solo");
            }
         }
         else
         {
            this.ed_player.look = null;
            this.pb_lifePoints.visible = false;
            this.pb_lifePointsThreshold.visible = false;
            this.tx_leaderCrown.visible = false;
            this.tx_followArrow.visible = false;
            this.tx_bg.visible = false;
            this.tx_guest.visible = false;
         }
      }
      
      public function select(b:Boolean) : void
      {
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var info:* = null;
         var pos:Object = {
            "point":2,
            "relativePoint":0
         };
         switch(target)
         {
            case this.ctr_main:
               if(this._data == null)
               {
                  break;
               }
               if(!this._data.isMember)
               {
                  if(this._data.hostName && this._data.hostName != "")
                  {
                     info = this._data.name + "\n" + this.uiApi.getText("ui.party.invitedBy") + "\n" + this._data.hostName;
                  }
                  else
                  {
                     info = this._data.name;
                  }
               }
               else
               {
                  if(this._data.isLeader)
                  {
                     info = this.uiApi.getText("ui.party.leader") + "\n";
                  }
                  else
                  {
                     info = "";
                  }
                  if(this._playerStatus != "")
                  {
                     info = "(" + this._playerStatus + ") ";
                  }
                  if(!Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA)
                  {
                     if(this._data.level > ProtocolConstantsEnum.MAX_LEVEL)
                     {
                        info += this.uiApi.getText("ui.party.rollOverPlayerInformationsWithPrestige",this._data.name,this._data.level - ProtocolConstantsEnum.MAX_LEVEL,this._data.prospecting,this._data.lifePoints,this._data.maxLifePoints,this._data.initiative,ProtocolConstantsEnum.MAX_LEVEL);
                     }
                     else
                     {
                        info += this.uiApi.getText("ui.party.rollOverPlayerInformations",this._data.name,this._data.level == 0 ? "--" : this._data.level,this._data.prospecting,this._data.lifePoints,this._data.maxLifePoints,this._data.initiative);
                     }
                  }
                  else if(this._data.level > ProtocolConstantsEnum.MAX_LEVEL)
                  {
                     info += this.uiApi.getText("ui.party.rollOverArenaPlayerInformationsWithPrestige",this._data.name,this._data.level - ProtocolConstantsEnum.MAX_LEVEL,this._data.rank == 0 ? "-" : this._data.rank,this._data.lifePoints,this._data.maxLifePoints,this._data.initiative);
                  }
                  else
                  {
                     info += this.uiApi.getText("ui.party.rollOverArenaPlayerInformations",this._data.name,this._data.level == 0 ? "--" : this._data.level,this._data.rank == 0 ? "-" : this._data.rank,this._data.lifePoints,this._data.maxLifePoints,this._data.initiative);
                  }
               }
               if(info)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(info),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
               }
               break;
            case this.tx_followArrow:
               info = this.uiApi.getText("ui.party.following",this._data.name);
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(info),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onArenaFighterStatusUpdate(playerId:Number, answer:Boolean) : void
      {
         if(answer && playerId == this._data.id)
         {
            this.tx_arenaStatus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("arenaStatusReady_uri"));
         }
      }
      
      public function onArenaRegistrationStatusUpdate(isRegistered:Boolean, currentStatus:int) : void
      {
         switch(currentStatus)
         {
            case PvpArenaStepEnum.ARENA_STEP_UNREGISTER:
            case PvpArenaStepEnum.ARENA_STEP_STARTING_FIGHT:
               this.tx_arenaStatus.visible = false;
               break;
            case PvpArenaStepEnum.ARENA_STEP_REGISTRED:
               if(this._data.isInArenaParty)
               {
                  this.tx_arenaStatus.visible = true;
                  this.tx_arenaStatus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("arenaStatusNotReady_uri"));
               }
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onGameFightEnd(... rest) : void
      {
         this.pb_lifePointsThreshold.visible = false;
      }
      
      private function onPartyMemberUpdate(id:int, pId:Number, guest:Boolean) : void
      {
      }
      
      private function onPartyMemberLifeUpdate(id:int, pId:Number, pLifePoints:int, pInitiative:int) : void
      {
         if(this._data != null && pId == this._data.id && !(this._data is PartyCompanionWrapper))
         {
            this.pb_lifePoints.value = pLifePoints / this._data.maxLifePoints;
         }
      }
      
      private function onPartyMemberLifeThresholdUpdate(id:int, pId:Number, pLifePointsThreshold:int) : void
      {
         if(this._data != null && pId == this._data.id && !(this._data is PartyCompanionWrapper))
         {
            if(pLifePointsThreshold <= 0)
            {
               this.pb_lifePointsThreshold.width = 0;
               this.pb_lifePointsThreshold.visible = false;
               return;
            }
            this.pb_lifePointsThreshold.visible = true;
            this.pb_lifePointsThreshold.width = this.pb_lifePoints.width * (pLifePointsThreshold / this._data.maxLifePoints);
         }
      }
      
      private function onPartyCompanionMemberUpdate(partyId:int, playerId:Number, index:int, companion:Object) : void
      {
         if(this._data != null && playerId == this._data.id && this._data is PartyCompanionWrapper && index == (this._data as PartyCompanionWrapper).index)
         {
            this.pb_lifePoints.value = companion.lifePoints / this._data.maxLifePoints;
         }
      }
      
      private function onPartyMemberFollowUpdate(partyId:int, memberId:Number, followed:Boolean) : void
      {
         if(this._data == null || Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA || memberId != this._data.id || this._data is PartyCompanionWrapper)
         {
            return;
         }
         this.tx_followArrow.visible = followed;
      }
      
      private function onPartyMemberStatusUpdate(accountId:uint, playerId:Number, status:uint, message:String) : void
      {
         if(this._data && playerId == this._data.id)
         {
            switch(status)
            {
               case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                  this._playerStatus = "";
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_AFK:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.idle");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.away");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.private");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                  this._playerStatus = this.uiApi.getText("ui.chat.status.solo");
            }
         }
      }
   }
}
