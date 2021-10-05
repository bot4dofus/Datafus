package Ankama_Party.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Party.Party;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.communication.NamingRule;
   import com.ankamagames.dofus.datacenter.idols.Idol;
   import com.ankamagames.dofus.internalDatacenter.people.PartyCompanionWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyNameSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyPledgeLoyaltyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyShowMenuAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleLockPartyAction;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PartyApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.types.Uri;
   
   public class PartyDisplay
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PartyApi")]
      public var partyApi:PartyApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      public var gd_party:Grid;
      
      public var btn_minimize:ButtonContainer;
      
      public var tx_button_minimize:Texture;
      
      public var tx_background_grid:TextureBitmap;
      
      public var tx_partyType:Texture;
      
      public var btn_info:ButtonContainer;
      
      public var btn_switchParty:ButtonContainer;
      
      private var _isArenaParty:Boolean = false;
      
      private var _isMinimized:Boolean;
      
      private var _leaderId:Number;
      
      private var _selectedMember:PartyMemberWrapper;
      
      private var _members:Array;
      
      private var _othersFollowingPlayerId:Number;
      
      private var _arenaPartyId:int;
      
      private var _partyId:int;
      
      private var _arenaPartyName:String;
      
      private var _partyName:String;
      
      private var _fightLocked:Boolean;
      
      private var _partyLocked:Boolean;
      
      private var _arenaPartyLocked:Boolean;
      
      private var _partyIdols:Vector.<uint>;
      
      private var _idolsScore:uint;
      
      private var _membersYOffset:int;
      
      private var _bonusHeight:int;
      
      private var _arenaIconUri:Uri;
      
      private var _partyIconUri:Uri;
      
      public function PartyDisplay()
      {
         this._partyIdols = new Vector.<uint>(0);
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this.sysApi.addHook(HookList.PartyJoin,this.onPartyJoin);
         this.sysApi.addHook(HookList.PartyLocateMembers,this.onPartyLocateMembers);
         this.sysApi.addHook(HookList.PartyUpdate,this.onPartyUpdate);
         this.sysApi.addHook(HookList.PartyLeave,this.onPartyLeave);
         this.sysApi.addHook(HookList.PartyLeaderUpdate,this.onPartyLeaderUpdate);
         this.sysApi.addHook(HookList.PartyMemberUpdate,this.onPartyMemberUpdate);
         this.sysApi.addHook(HookList.PartyMemberRemove,this.onPartyMemberRemove);
         this.sysApi.addHook(CustomUiHookList.FoldAll,this.onFoldAll);
         this.sysApi.addHook(HookList.OptionLockParty,this.onOptionLockParty);
         this.sysApi.addHook(HookList.PartyLoyaltyStatus,this.onPartyLoyaltyStatus);
         this.sysApi.addHook(HookList.PartyMemberLifeUpdate,this.onPartyMemberLifeUpdate);
         this.sysApi.addHook(HookList.PartyNameUpdate,this.onPartyNameUpdate);
         this.sysApi.addHook(HookList.IdolsList,this.onIdolsList);
         this.sysApi.addHook(HookList.IdolSelected,this.onIdolSelected);
         this.sysApi.addHook(HookList.IdolPartyLost,this.onIdolPartyLost);
         this.uiApi.addComponentHook(this.btn_switchParty,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_switchParty,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_switchParty,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_info,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_info,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_info,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_minimize,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_minimize,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_minimize,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.gd_party,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_party,ComponentHookList.ON_SELECT_ITEM);
         this._isMinimized = false;
         this._membersYOffset = int(this.uiApi.me().getConstant("vertical_offset_between_members"));
         this._bonusHeight = int(this.uiApi.me().getConstant("bonus_height"));
         this.updateGrid(oParam.partyMembers);
         this.gd_party.mouseEnabled = false;
         this._fightLocked = oParam.restricted;
         this._partyLocked = false;
         this._arenaPartyLocked = false;
         this._isArenaParty = oParam.arena;
         Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA = this._isArenaParty;
         this.btn_switchParty.softDisabled = true;
         this._arenaIconUri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_sword.png");
         this._partyIconUri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_green_group.png");
         if(this._isArenaParty)
         {
            this.tx_partyType.uri = this._arenaIconUri;
         }
         else
         {
            this.tx_partyType.uri = this._partyIconUri;
         }
         if(this._isArenaParty)
         {
            this._arenaPartyId = oParam.id;
            this._arenaPartyName = oParam.name;
         }
         else
         {
            this._partyId = oParam.id;
            this._partyName = oParam.name;
         }
         if(this.playerApi.isPartyLeader())
         {
            this.onIdolsList(null,this.playerApi.getSoloIdols(),null);
            this.playerApi.setPartyIdols(this.playerApi.getSoloIdols());
         }
      }
      
      public function getCurrentGroupId() : int
      {
         if(this._isArenaParty)
         {
            return this._arenaPartyId;
         }
         return this._partyId;
      }
      
      private function updateGrid(members:Object = null) : void
      {
         var member:Object = null;
         var companion:PartyCompanionWrapper = null;
         this._members = [];
         this._leaderId = 0;
         if(members == null)
         {
            if(this._isArenaParty)
            {
               members = this.partyApi.getPartyMembers(1);
            }
            else
            {
               members = this.partyApi.getPartyMembers(0);
            }
         }
         for each(member in members)
         {
            if(member.isLeader)
            {
               this._leaderId = member.id;
            }
            this._members.push(member);
            if(member.companions && member.companions.length > 0)
            {
               for each(companion in member.companions)
               {
                  this._members.push(companion);
               }
            }
         }
         this._members.sortOn(["isMember","initiative","id"],[Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.NUMERIC]);
         this.gd_party.dataProvider = this._members;
         this.updateBackground();
      }
      
      private function updateGridOrder() : void
      {
         this._members.sortOn(["isMember","initiative","id"],[Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.NUMERIC]);
         this.gd_party.updateItems();
      }
      
      private function updateBackground() : void
      {
         if(this.gd_party.dataProvider == null)
         {
            return;
         }
         this.gd_party.height = Math.min(this._members.length,8) * (this.gd_party.slotHeight + this._membersYOffset);
         this.tx_background_grid.height = this.gd_party.height + this._bonusHeight;
      }
      
      private function showMembersParty(value:Boolean) : void
      {
         this.gd_party.visible = value;
         this.tx_background_grid.visible = value;
         this.btn_info.visible = value;
         this.btn_switchParty.visible = value;
         this._isMinimized = !value;
         if(value)
         {
            this.tx_button_minimize.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_minus_floating_menu.png");
         }
         else
         {
            this.tx_button_minimize.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_plus_floating_menu.png");
         }
      }
      
      private function updateIdolsScore() : void
      {
         var i:int = 0;
         var idol:Idol = null;
         var coeff:Number = NaN;
         var numPartyIdols:uint = this._partyIdols.length;
         this._idolsScore = 0;
         for(i = 0; i < numPartyIdols; i++)
         {
            idol = this.dataApi.getIdol(this._partyIdols[i]);
            coeff = this.getIdolCoeff(idol);
            this._idolsScore += idol.score * coeff;
         }
      }
      
      private function getIdolCoeff(pIdol:Idol) : Number
      {
         var i:int = 0;
         var j:int = 0;
         var coeff:Number = 1;
         var synergiesIds:Vector.<int> = pIdol.synergyIdolsIds;
         var synergiesCoeffs:Vector.<Number> = pIdol.synergyIdolsCoeff;
         var numSynergies:uint = synergiesIds.length;
         var numActiveIdols:uint = this._partyIdols.length;
         for(i = 0; i < numActiveIdols; i++)
         {
            for(j = 0; j < numSynergies; j++)
            {
               if(synergiesIds[j] == this._partyIdols[i])
               {
                  coeff *= synergiesCoeffs[j];
               }
            }
         }
         return coeff;
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
         this.modContextMenu.closeAllMenu();
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var contextMenu:ContextMenuData = null;
         switch(target)
         {
            case this.gd_party:
               if(selectMethod == GridItemSelectMethodEnum.AUTO)
               {
                  return;
               }
               this._selectedMember = (target as Grid).selectedItem;
               if(this._selectedMember is PartyCompanionWrapper)
               {
                  contextMenu = this.menuApi.create(this._selectedMember as PartyCompanionWrapper);
                  if(contextMenu.content.length > 0)
                  {
                     this.modContextMenu.createContextMenu(contextMenu);
                  }
               }
               else
               {
                  this.sysApi.sendAction(new PartyShowMenuAction([this._selectedMember.id,this.getCurrentGroupId()]));
               }
               break;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_minimize:
               if(this._isMinimized)
               {
                  this.showMembersParty(true);
               }
               else
               {
                  this.showMembersParty(false);
               }
               break;
            case this.btn_info:
               this.showOptionsMenu();
               break;
            case this.btn_switchParty:
               this.switchPartyType();
         }
      }
      
      private function switchPartyType() : void
      {
         this._isArenaParty = !this._isArenaParty;
         Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA = this._isArenaParty;
         if(this._isArenaParty)
         {
            this.tx_partyType.uri = this._arenaIconUri;
         }
         else
         {
            this.tx_partyType.uri = this._partyIconUri;
         }
         this.updateGrid();
      }
      
      private function showOptionsMenu() : void
      {
         var menu:Array = [];
         menu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.common.options")));
         var iamnoleader:* = this.playerApi.id() != this._leaderId;
         if(!this._isArenaParty)
         {
            menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.party.rename"),this.nameParty,null,iamnoleader || this.sysApi.isFightContext(),null,false,false,!!this._isArenaParty ? this._arenaPartyName : this._partyName,true));
            menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.party.lockFight"),this.optionLockFight,[!this._fightLocked],iamnoleader,null,this._fightLocked,false));
            menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.party.refuseOtherInvitations"),this.optionLockParty,[!this._partyLocked],false,null,this._partyLocked,false));
         }
         else
         {
            menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.party.refuseOtherInvitations"),this.optionLockParty,[!this._arenaPartyLocked],false,null,this._arenaPartyLocked,false));
         }
         this.modContextMenu.createContextMenu(menu);
      }
      
      private function optionLockFight(value:Boolean) : void
      {
         this.sysApi.sendAction(new ToggleLockPartyAction([]));
      }
      
      private function optionLockParty(value:Boolean) : void
      {
         this.sysApi.sendAction(new PartyPledgeLoyaltyRequestAction([this.getCurrentGroupId(),value]));
      }
      
      private function nameParty() : void
      {
         var namingRulePartyName:NamingRule = this.sysApi.getCurrentServer().community.namingRulePartyName;
         this.modCommon.openInputPopup(this.uiApi.getText("ui.party.rename"),this.uiApi.getText("ui.party.choseName"),this.onChangePartyName,null,!!this._isArenaParty ? this._arenaPartyName : this._partyName,null,namingRulePartyName.maxLength);
      }
      
      private function onChangePartyName(value:String) : void
      {
         var namingRulePartyName:NamingRule = this.sysApi.getCurrentServer().community.namingRulePartyName;
         var regexp:RegExp = new RegExp(namingRulePartyName.regexp,"g");
         if(value.length >= ProtocolConstantsEnum.MIN_PARTY_NAME_LEN && regexp.test(value))
         {
            this.sysApi.sendAction(new PartyNameSetRequestAction([this.getCurrentGroupId(),value]));
         }
         else
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.party.nameInvalid"),[this.uiApi.getText("ui.common.ok")],[]);
         }
      }
      
      private function onFoldAll(fold:Boolean) : void
      {
         this.showMembersParty(!fold);
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var data:TextTooltipInfo = null;
         var levelTotal:uint = 0;
         var initTotal:uint = 0;
         var info:String = null;
         var player:PartyMemberWrapper = null;
         switch(target)
         {
            case this.btn_info:
               levelTotal = 0;
               initTotal = 0;
               for each(player in this.gd_party.dataProvider)
               {
                  levelTotal += player.level > ProtocolConstantsEnum.MAX_LEVEL ? ProtocolConstantsEnum.MAX_LEVEL : player.level;
                  initTotal += player.initiative;
               }
               info = this.uiApi.getText("ui.party.partyInformation",levelTotal,this._idolsScore,this.gd_party.dataProvider.length == 0 ? "" : Math.round(initTotal / this.gd_party.dataProvider.length));
               if(info)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(info),target,false,"standard",2,0,3,null,null,null,"TextInfo");
               }
               break;
            case this.btn_switchParty:
               data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.switchPartyType"));
               this.uiApi.showTooltip(data,target,false,"standard",7,1,3,null,null,null,"TextInfo");
               break;
            case this.btn_minimize:
               if(this._isArenaParty)
               {
                  if(this._arenaPartyName != "")
                  {
                     data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.koliseum") + this.uiApi.getText("ui.common.colon") + this._arenaPartyName);
                  }
                  else
                  {
                     data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.koliseum"));
                  }
               }
               else if(this._partyName != "")
               {
                  data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.party") + this.uiApi.getText("ui.common.colon") + this._partyName);
               }
               else
               {
                  data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.party"));
               }
               this.uiApi.showTooltip(data,target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onPartyLeaderUpdate(id:int, partyLeaderId:Number) : void
      {
         var player:PartyMemberWrapper = null;
         if(id == this.getCurrentGroupId())
         {
            for each(player in this.gd_party.dataProvider)
            {
               if(player.id == partyLeaderId)
               {
                  this._leaderId = player.id;
               }
            }
            this.updateBackground();
         }
      }
      
      private function onPartyMemberUpdate(id:int, playerId:Number, guest:Boolean) : void
      {
         if(id == this.getCurrentGroupId())
         {
            this.updateGrid();
         }
      }
      
      private function onPartyMemberLifeUpdate(id:int, playerId:Number, pLifePoints:int, pInitiative:int) : void
      {
         if(id == this.getCurrentGroupId())
         {
            this.updateGridOrder();
         }
      }
      
      private function onPartyNameUpdate(id:int, partyName:String) : void
      {
         if(id == this._arenaPartyId)
         {
            this._arenaPartyName = partyName;
         }
         else
         {
            this._partyName = partyName;
         }
      }
      
      private function onPartyMemberRemove(id:int, playerId:Number) : void
      {
         if(id == this.getCurrentGroupId())
         {
            this.updateGrid();
         }
      }
      
      private function onPartyLocateMembers(geopositions:Vector.<uint>) : void
      {
      }
      
      public function onPartyJoin(id:int, pMembers:Object, restrict:Boolean, isArenaParty:Boolean, name:String = "") : void
      {
         this.updateGrid(pMembers);
         this._fightLocked = restrict;
         this._isArenaParty = isArenaParty;
         Party.CURRENT_PARTY_TYPE_DISPLAYED_IS_ARENA = this._isArenaParty;
         if(this._isArenaParty)
         {
            this.tx_partyType.uri = this._arenaIconUri;
         }
         else
         {
            this.tx_partyType.uri = this._partyIconUri;
         }
         this.btn_switchParty.softDisabled = false;
         if(this._isArenaParty)
         {
            this._arenaPartyId = id;
            this._arenaPartyName = name;
         }
         else
         {
            this._partyId = id;
            this._partyName = name;
         }
      }
      
      private function onPartyUpdate(id:int, pMembers:Object) : void
      {
         if(id == this.getCurrentGroupId())
         {
            this.updateGrid(pMembers);
         }
      }
      
      private function onPartyLeave(id:int, isArena:Boolean) : void
      {
         if(this._isArenaParty)
         {
            if(id == this._arenaPartyId)
            {
               if(this._partyId != 0)
               {
                  this.switchPartyType();
                  this.btn_switchParty.softDisabled = true;
                  this._arenaPartyId = 0;
               }
               else if(this.uiApi && this.uiApi.me())
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
            }
            else
            {
               this.btn_switchParty.softDisabled = true;
               this._partyId = 0;
            }
         }
         else if(id == this._partyId)
         {
            if(this._arenaPartyId != 0)
            {
               this.switchPartyType();
               this.btn_switchParty.softDisabled = true;
               this._partyId = 0;
            }
            else
            {
               this.uiApi.unloadUi(this.uiApi.me().name);
            }
         }
         else
         {
            this.btn_switchParty.softDisabled = true;
            this._arenaPartyId = 0;
         }
      }
      
      private function onOptionLockParty(restricted:Boolean) : void
      {
         this._fightLocked = restricted;
      }
      
      private function onPartyLoyaltyStatus(id:int, loyal:Boolean) : void
      {
         if(id == this._arenaPartyId)
         {
            this._arenaPartyLocked = loyal;
         }
         else if(id == this._partyId)
         {
            this._partyLocked = loyal;
         }
      }
      
      private function onIdolsList(pChosenIdols:Object, pPartyChosenIdols:Object, pPartyIdols:Object) : void
      {
         var idolId:uint = 0;
         this._partyIdols.length = 0;
         for each(idolId in pPartyChosenIdols)
         {
            this._partyIdols.push(idolId);
         }
         this.updateIdolsScore();
      }
      
      private function onIdolSelected(pIdolId:uint, pActivate:Boolean, pParty:Boolean) : void
      {
         var idolIndex:int = 0;
         if(pParty)
         {
            if(pActivate)
            {
               this._partyIdols.push(pIdolId);
            }
            else
            {
               idolIndex = this._partyIdols.indexOf(pIdolId);
               if(idolIndex != -1)
               {
                  this._partyIdols.splice(idolIndex,1);
               }
            }
            this.updateIdolsScore();
         }
      }
      
      private function onIdolPartyLost(pIdolId:uint) : void
      {
         var idolIndex:int = this._partyIdols.indexOf(pIdolId);
         if(idolIndex != -1)
         {
            this._partyIdols.splice(idolIndex,1);
         }
         this.updateIdolsScore();
      }
   }
}
