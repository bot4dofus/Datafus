package Ankama_Party.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.people.PartyCompanionWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAcceptInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyRefuseInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddIgnoredAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.PartyTypeEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.MountApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class JoinParty
   {
       
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="MountApi")]
      public var mountApi:MountApi;
      
      private var _partyId:uint;
      
      private var _members:Array;
      
      private var _fromName:String;
      
      private var _partyName:String;
      
      private var _leaderId:Number;
      
      private var _typeId:uint = 0;
      
      private var _dungeonId:uint = 0;
      
      private var _acceptMembersDungeon:Array;
      
      public var lbl_fromName:Label;
      
      public var lbl_dungeon:Label;
      
      public var btnClose:ButtonContainer;
      
      public var btnValidate:ButtonContainer;
      
      public var btnCancel:ButtonContainer;
      
      public var btnIgnore:ButtonContainer;
      
      public var grid_members:Grid;
      
      public var tx_slotPlayer:Texture;
      
      public function JoinParty()
      {
         super();
      }
      
      public function main(params:Array) : void
      {
         var i:PartyMemberWrapper = null;
         var j:PartyCompanionWrapper = null;
         var b:* = null;
         this.sysApi.addHook(HookList.PartyMemberUpdateDetails,this.onPartyMemberUpdate);
         this.sysApi.addHook(HookList.PartyMemberRemove,this.onPartyMemberRemove);
         this._partyId = params[0];
         this._fromName = params[1];
         this._leaderId = params[2];
         this._typeId = params[3];
         this._dungeonId = params[6];
         this._partyName = params[8];
         this._members = [];
         for each(i in params[4])
         {
            this._members.push(i);
            for each(j in i.companions)
            {
               this._members.push(j);
            }
         }
         for each(i in params[5])
         {
            this._members.push(i);
            for each(j in i.companions)
            {
               this._members.push(j);
            }
         }
         this._acceptMembersDungeon = [];
         for(b in params[4])
         {
            this._acceptMembersDungeon.push(b);
         }
         if(this._typeId == PartyTypeEnum.PARTY_TYPE_ARENA)
         {
            this.lbl_fromName.text = this.uiApi.getText("ui.common.invitationArena");
         }
         else
         {
            this.lbl_fromName.text = this.uiApi.getText("ui.common.invitationGroupe");
         }
         this.lbl_dungeon.text = this.uiApi.getText("ui.common.invitationPresentation",this._fromName,this._partyName);
         if(this._dungeonId != 0)
         {
            if(this._partyName != "")
            {
               this.lbl_dungeon.text += " ";
            }
            this.lbl_dungeon.text += this.uiApi.getText("ui.common.invitationDonjon",this.dataApi.getDungeon(this._dungeonId).name);
         }
         this.lbl_dungeon.text += ".";
         this.updateGrid();
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function updateGrid() : void
      {
         this.grid_members.dataProvider = this._members;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btnClose:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btnCancel:
               this.sysApi.sendAction(new PartyRefuseInvitationAction([this._partyId]));
               break;
            case this.btnValidate:
               this.sysApi.sendAction(new PartyAcceptInvitationAction([this._partyId]));
               break;
            case this.btnIgnore:
               this.sysApi.sendAction(new AddIgnoredAction([this._fromName]));
               this.sysApi.sendAction(new PartyRefuseInvitationAction([this._partyId]));
         }
      }
      
      public function updateEntry(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            componentsRef.ed_Player.look = this.mountApi.getRiderEntityLook(data.entityLook);
            componentsRef.ed_Player.visible = true;
            if(!data.isMember)
            {
               componentsRef.tx_slotPlayerLine.visible = true;
            }
            else
            {
               componentsRef.tx_slotPlayerLine.visible = this.isReady(data.id);
            }
            componentsRef.lbl_name.text = "{player," + data.name + "," + data.id + "::" + data.name + "}";
            if(data.breedId)
            {
               componentsRef.lbl_breed.text = this.dataApi.getBreed(data.breedId).shortName;
            }
            else
            {
               componentsRef.lbl_breed.text = "";
            }
            if(data.level == 0 || data is PartyCompanionWrapper)
            {
               componentsRef.lbl_level.text = "";
            }
            else if(data.level > ProtocolConstantsEnum.MAX_LEVEL)
            {
               componentsRef.lbl_level.text = this.uiApi.getText("ui.common.prestige") + " " + (data.level - ProtocolConstantsEnum.MAX_LEVEL);
            }
            else
            {
               componentsRef.lbl_level.text = this.uiApi.getText("ui.common.level") + " " + data.level;
            }
            componentsRef.tx_leaderCrown.gotoAndStop = 2;
            componentsRef.tx_leaderCrown.visible = data.id == this._leaderId && !(data is PartyCompanionWrapper);
         }
         else
         {
            componentsRef.tx_slotPlayerLine.visible = false;
            componentsRef.tx_leaderCrown.visible = false;
            componentsRef.ed_Player.visible = false;
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_breed.text = "";
            componentsRef.lbl_level.text = "";
         }
      }
      
      private function isReady(playerId:Number) : Boolean
      {
         var m:int = 0;
         if(this._acceptMembersDungeon == null || this._acceptMembersDungeon.length <= 0)
         {
            return false;
         }
         for each(m in this._acceptMembersDungeon)
         {
            if(m == playerId)
            {
               return true;
            }
         }
         return false;
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         var txt:* = null;
         if(item.data)
         {
            if(item.data.subAreaId)
            {
               txt = this.uiApi.getText("ui.common.invitationLocation") + " " + this.dataApi.getSubArea(item.data.subAreaId).name + " (" + item.data.worldX + "," + item.data.worldY + ")";
            }
            if(txt != "")
            {
               this.uiApi.showTooltip(txt,item.container,false,"standard",2,0,0,null,null,null,null);
            }
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onPartyMemberUpdate(pPartyId:uint, pGuest:PartyMemberWrapper, pIsInGroup:Boolean) : void
      {
         var c:PartyCompanionWrapper = null;
         var newMembers:Array = null;
         var m:PartyMemberWrapper = null;
         var i:int = 0;
         var c2:PartyCompanionWrapper = null;
         if(this._partyId != pPartyId)
         {
            return;
         }
         var index:int = this.getMemberIndex(pGuest.id);
         if(index == -1)
         {
            this._members.push(pGuest);
            for each(c in pGuest.companions)
            {
               this._members.push(c);
            }
         }
         else
         {
            newMembers = [];
            for each(m in this._members)
            {
               if(m.id != pGuest.id)
               {
                  newMembers.push(m);
               }
            }
            this._members = newMembers;
            this._members.splice(index,0,pGuest);
            i = 0;
            for each(c2 in pGuest.companions)
            {
               i++;
               this._members.splice(index + i,0,c2);
            }
         }
         this.updateGrid();
      }
      
      private function onPartyMemberRemove(pPartyId:uint, pMemberId:Number) : void
      {
         var m:PartyMemberWrapper = null;
         if(this._partyId != pPartyId)
         {
            return;
         }
         var newMembers:Array = [];
         for each(m in this._members)
         {
            if(m.id != pMemberId)
            {
               newMembers.push(m);
            }
         }
         this._members = newMembers;
         this.updateGrid();
      }
      
      private function getMemberIndex(guestId:Number) : int
      {
         var m:PartyMemberWrapper = null;
         for each(m in this._members)
         {
            if(m.id == guestId)
            {
               return this._members.indexOf(m);
            }
         }
         return -1;
      }
   }
}
