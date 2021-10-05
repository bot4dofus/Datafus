package Ankama_Dungeon.ui
{
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.misc.lists.BreachHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.dofus.uiApi.BreachApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PartyApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.Dictionary;
   
   public class BreachTracking
   {
      
      private static const CTR_CAT_TYPE:String = "ctr_cat";
      
      private static const CTR_GROUP_INFO:String = "ctr_groupInfo";
      
      private static const CTR_BONUS:String = "ctr_bonus";
      
      private static const CTR_ROOM_INFO:String = "ctr_roomInfo";
      
      private static const CTR_LEAVE:String = "ctr_leave";
      
      private static const GROUP_INFO_CAT_ID:uint = 0;
      
      private static const BONUS_CAT_ID:uint = 1;
      
      private static const ROOM_INFO_CAT_ID:uint = 2;
      
      private static const LEAVE_CAT_ID:uint = 3;
      
      private static const OPACITY_DATA_ID:String = "breachTrackingBackgroundOpacity";
       
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="BreachApi")]
      public var breachApi:BreachApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playedCharacter:PlayedCharacterApi;
      
      [Api(name="PartyApi")]
      public var partyApi:PartyApi;
      
      public var mainCtr:GraphicContainer;
      
      public var mainCtrMinimize:GraphicContainer;
      
      public var btn_breachTrackingMaximized:ButtonContainer;
      
      public var btn_minimize:ButtonContainer;
      
      public var btn_options:ButtonContainer;
      
      public var tx_buttonMinimize:Texture;
      
      public var gd_breachTracking:Grid;
      
      private var _componentList:Dictionary;
      
      private var _openedCategories:Array;
      
      private var _dataMatrix:Array;
      
      private var _opacity:Number;
      
      private var _hideOwner:Boolean;
      
      private var _hideGroupInvitButton:Boolean = true;
      
      private var _hidden:Boolean = true;
      
      private var _lastX:Number;
      
      private var _lastY:Number;
      
      private var _owner:String;
      
      private var _bonuses:Vector.<EffectInstanceInteger>;
      
      private var _currentRoom:uint = 0;
      
      private var _bosses:Vector.<MonsterInGroupLightInformations>;
      
      public function BreachTracking()
      {
         this._componentList = new Dictionary(true);
         this._bosses = new Vector.<MonsterInGroupLightInformations>();
         super();
      }
      
      public function main(params:Object = null) : void
      {
         this.sysApi.addHook(BreachHookList.BreachState,this.onBreachState);
         this.sysApi.addHook(BreachHookList.BreachMapInfos,this.onBreachMapInfos);
         this.sysApi.addHook(BreachHookList.BreachBonus,this.onBreachBonus);
         this.sysApi.addHook(BreachHookList.BreachBudget,this.onBreachBudget);
         this.sysApi.addHook(BreachHookList.BreachCharactersListUpdate,this.onBreachCharactersListUpdate);
         this.sysApi.addHook(HookList.GameFightJoin,this.onGameFightJoin);
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
         this.sysApi.addHook(HookList.GameFightStart,this.onGameFightStart);
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(HookList.PartyMemberUpdate,this.onPartyMemberUpdate);
         this.sysApi.addHook(HookList.PartyMemberRemove,this.onPartyMemberRemove);
         this.uiApi.addComponentHook(this.gd_breachTracking,ComponentHookList.ON_SELECT_ITEM);
         this.maximized();
         this._opacity = this.sysApi.getSetData(OPACITY_DATA_ID,0.7,DataStoreEnum.BIND_ACCOUNT);
         this._bonuses = new Vector.<EffectInstanceInteger>();
         this._openedCategories = [];
         this._dataMatrix = [];
         this.initData(params);
         this.onBreachCharactersListUpdate();
      }
      
      public function onUiLoaded(uiName:String) : void
      {
         if(uiName == "cartographyUi")
         {
            this.uiApi.me().visible = false;
         }
         if(uiName == this.uiApi.me().name)
         {
            this.initPosition();
         }
      }
      
      public function onUiUnloaded(uiName:String) : void
      {
         if(uiName == "cartographyUi")
         {
            this.uiApi.me().visible = true;
         }
      }
      
      public function unload() : void
      {
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         var boss:Monster = null;
         var description:String = null;
         var gfxId:String = null;
         switch(this.getCatLineType(data,line))
         {
            case CTR_CAT_TYPE:
               if(data.id == ROOM_INFO_CAT_ID)
               {
                  if(this.breachApi.getRoom() == 0)
                  {
                     componentsRef.lbl_catName.text = this.uiApi.getText("ui.breach.floor",this.breachApi.getFloor());
                     componentsRef.tx_catPlusminus.uri = null;
                     componentsRef.btn_cat.mouseEnabled = false;
                  }
                  else
                  {
                     componentsRef.btn_cat.mouseEnabled = true;
                     componentsRef.lbl_catName.text = this.uiApi.getText("ui.breach.floor",this.breachApi.getFloor()) + " - " + this.uiApi.getText("ui.breach.roomNumber",this._currentRoom);
                     if(this._openedCategories.indexOf(data.id) != -1)
                     {
                        componentsRef.tx_catPlusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_minus_grey.png");
                     }
                     else
                     {
                        componentsRef.tx_catPlusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_plus_grey.png");
                     }
                  }
                  componentsRef.btn_cat.selected = selected;
               }
               else
               {
                  componentsRef.lbl_catName.text = data.name;
                  componentsRef.btn_cat.selected = selected;
                  if(this._openedCategories.indexOf(data.id) != -1)
                  {
                     componentsRef.tx_catPlusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_minus_grey.png");
                  }
                  else
                  {
                     componentsRef.tx_catPlusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_plus_grey.png");
                  }
               }
               break;
            case CTR_GROUP_INFO:
               if(!this._componentList[componentsRef.ctr_budget.name])
               {
                  this.uiApi.addComponentHook(componentsRef.ctr_budget,ComponentHookList.ON_ROLL_OUT);
                  this.uiApi.addComponentHook(componentsRef.ctr_budget,ComponentHookList.ON_ROLL_OVER);
               }
               this._componentList[componentsRef.ctr_budget.name] = data;
               this.changeOpacity(this._opacity,componentsRef.ctr_groupInfo);
               componentsRef.ctr_invitAllMembers.visible = !this._hideGroupInvitButton && this.breachApi.getOwnerId() == this.playedCharacter.id();
               if(!this._hideOwner)
               {
                  componentsRef.lbl_ownerName.text = this.uiApi.getText("ui.breach.breachOwner") + this.uiApi.getText("ui.common.colon") + data.owner;
                  componentsRef.ctr_groupInfo.height = this.uiApi.me().getConstant("heightGridSlot") * (!!componentsRef.ctr_invitAllMembers.visible ? 3 : 2);
                  componentsRef.ctr_budget.y = !!componentsRef.ctr_invitAllMembers.visible ? this.uiApi.me().getConstant("heightGridSlot") * 2 : this.uiApi.me().getConstant("heightGridSlot");
                  componentsRef.ctr_invitAllMembers.y = this.uiApi.me().getConstant("heightGridSlot");
               }
               else
               {
                  componentsRef.lbl_ownerName.text = null;
                  componentsRef.ctr_groupInfo.height = this.uiApi.me().getConstant("heightGridSlot") * (!!componentsRef.ctr_invitAllMembers.visible ? 2 : 1);
                  componentsRef.ctr_budget.y = !!componentsRef.ctr_invitAllMembers.visible ? this.uiApi.me().getConstant("heightGridSlot") : 0;
                  componentsRef.ctr_invitAllMembers.y = 0;
               }
               componentsRef.lbl_budget.text = this.utilApi.stringToKamas(data.budget,"");
               componentsRef.tx_budget.x = componentsRef.lbl_budget.x + 7 + this.uiApi.getTextSize(componentsRef.lbl_budget.text,componentsRef.lbl_budget.css,componentsRef.lbl_budget.cssClass).width;
               componentsRef.tx_budget.y = componentsRef.lbl_budget.y + 2;
               break;
            case CTR_BONUS:
               if(!this._componentList[componentsRef.lbl_bonus.name])
               {
                  this.uiApi.addComponentHook(componentsRef.lbl_bonus,ComponentHookList.ON_ROLL_OUT);
                  this.uiApi.addComponentHook(componentsRef.lbl_bonus,ComponentHookList.ON_ROLL_OVER);
               }
               this._componentList[componentsRef.lbl_bonus.name] = data;
               this.changeOpacity(this._opacity,componentsRef.ctr_bonus);
               if(!data.bonus)
               {
                  componentsRef.lbl_bonus.text = this.uiApi.getText("ui.breach.noBonus");
                  componentsRef.lbl_bonus.cssClass = "left";
                  componentsRef.tx_bonus.visible = false;
                  componentsRef.tx_bonus.uri = null;
               }
               else
               {
                  description = data.bonus.bonusType < 0 ? "-" : (data.bonus.bonusType > 0 ? "+" : "");
                  componentsRef.lbl_bonus.text = description + " " + data.bonus.description;
                  componentsRef.lbl_bonus.cssClass = "whiteleft";
                  gfxId = this.dataApi.getCharacteristic(this.dataApi.getEffect(data.bonus.effectId).characteristic).asset;
                  if(gfxId != "null")
                  {
                     componentsRef.tx_bonus.visible = true;
                     componentsRef.tx_bonus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + gfxId);
                  }
                  else
                  {
                     componentsRef.tx_bonus.visible = false;
                     componentsRef.tx_bonus.uri = null;
                  }
               }
               break;
            case CTR_ROOM_INFO:
               if(!this._componentList[componentsRef.lbl_bossName.name])
               {
                  this.uiApi.addComponentHook(componentsRef.lbl_bossName,ComponentHookList.ON_ROLL_OUT);
                  this.uiApi.addComponentHook(componentsRef.lbl_bossName,ComponentHookList.ON_ROLL_OVER);
               }
               this._componentList[componentsRef.lbl_bossName.name] = data;
               if(!this._componentList[componentsRef.ed_boss.name])
               {
                  this.uiApi.addComponentHook(componentsRef.ed_boss,ComponentHookList.ON_ROLL_OUT);
                  this.uiApi.addComponentHook(componentsRef.ed_boss,ComponentHookList.ON_ROLL_OVER);
               }
               this._componentList[componentsRef.ed_boss.name] = data;
               this.changeOpacity(this._opacity,componentsRef.ctr_roomInfo);
               boss = this.dataApi.getMonsterFromId(data.bossId);
               componentsRef.ed_boss.look = boss.look;
               componentsRef.lbl_bossName.text = boss.name + "\n" + this.uiApi.getText("ui.common.level") + " " + this.breachApi.getFloor();
               componentsRef.lbl_bossName.y = (this.uiApi.me().getConstant("heightGridSlot") * 4 - componentsRef.lbl_bossName.textHeight) / 2;
         }
      }
      
      public function getCatLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data.isCat)
         {
            return CTR_CAT_TYPE;
         }
         if(data.cat == GROUP_INFO_CAT_ID)
         {
            return CTR_GROUP_INFO;
         }
         if(data.cat == BONUS_CAT_ID)
         {
            return CTR_BONUS;
         }
         if(data.cat == ROOM_INFO_CAT_ID)
         {
            return CTR_ROOM_INFO;
         }
         return CTR_LEAVE;
      }
      
      private function onBreachState(owner:String, bonuses:Vector.<EffectInstanceInteger>, saved:Boolean) : void
      {
         if(this._bonuses.length <= 0)
         {
            this._openedCategories.push(BONUS_CAT_ID);
         }
         this.initData({
            "owner":owner,
            "bonuses":bonuses
         });
         this.displayBreachInfo();
      }
      
      private function onBreachMapInfos(bosses:Vector.<MonsterInGroupLightInformations>) : void
      {
         this._currentRoom = this.breachApi.getRoom();
         this._bosses = bosses;
         this._openedCategories.push(ROOM_INFO_CAT_ID);
         this.updateData();
      }
      
      private function onBreachBonus(bonus:EffectInstanceInteger) : void
      {
         var effect:EffectInstanceInteger = null;
         if(this._bonuses.length <= 0)
         {
            this._openedCategories.push(BONUS_CAT_ID);
         }
         var replace:Boolean = false;
         for each(effect in this._bonuses)
         {
            if(effect.effectId == bonus.effectId)
            {
               this._bonuses.splice(this._bonuses.indexOf(effect),1);
               this._bonuses.push(bonus);
               replace = true;
               break;
            }
         }
         if(!replace)
         {
            this._bonuses.push(bonus);
         }
         this.updateData();
      }
      
      private function onBreachBudget() : void
      {
         this.updateData();
      }
      
      private function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:uint, fightType:int, alliesPreparation:Boolean) : void
      {
         this.updateData();
      }
      
      private function onGameFightStart() : void
      {
         this._hideGroupInvitButton = true;
         this.updateData();
      }
      
      private function onGameFightEnd(resultsKey:String) : void
      {
         this.onBreachCharactersListUpdate();
      }
      
      private function onBreachCharactersListUpdate() : void
      {
         if(this.breachApi.getOwnerId() != this.playedCharacter.id())
         {
            return;
         }
         if(!this.playedCharacter.isInParty() || this.breachApi.getBreachGroupPlayers().length >= (this.partyApi.getPartyMembers().length <= 4 ? this.partyApi.getPartyMembers().length : 4))
         {
            this._hideGroupInvitButton = true;
         }
         else
         {
            this._hideGroupInvitButton = false;
         }
         this.updateData();
      }
      
      private function onPartyMemberUpdate(id:int, playerId:Number, guest:Boolean) : void
      {
         if(this.breachApi.getOwnerId() != this.playedCharacter.id() || guest)
         {
            return;
         }
         this.onBreachCharactersListUpdate();
      }
      
      private function onPartyMemberRemove(pPartyId:uint, pMemberId:Number) : void
      {
         if(this.breachApi.getOwnerId() != this.playedCharacter.id())
         {
            return;
         }
         this.onBreachCharactersListUpdate();
      }
      
      private function initData(params:Object) : void
      {
         this._owner = params.owner;
         this._bonuses = params.bonuses;
         this.updateData();
      }
      
      private function updateData() : void
      {
         var e:EffectInstanceInteger = null;
         var boss:MonsterInGroupLightInformations = null;
         this._dataMatrix = [];
         this._dataMatrix.push({
            "owner":this._owner,
            "budget":this.breachApi.getBudget(),
            "cat":GROUP_INFO_CAT_ID
         });
         this._dataMatrix.push({
            "name":this.uiApi.getText("ui.fight.challenge.bonusGroup"),
            "id":BONUS_CAT_ID,
            "isCat":true
         });
         if(this._bonuses.length <= 0)
         {
            this._dataMatrix.push({
               "bonus":null,
               "cat":BONUS_CAT_ID
            });
         }
         else
         {
            for each(e in this._bonuses)
            {
               this._dataMatrix.push({
                  "bonus":EffectInstance(e),
                  "cat":BONUS_CAT_ID
               });
            }
         }
         this._dataMatrix.push({
            "name":this.uiApi.getText("ui.common.roomInformation",this._currentRoom),
            "id":ROOM_INFO_CAT_ID,
            "isCat":true
         });
         if(this.breachApi.getRoom() > 0)
         {
            for each(boss in this._bosses)
            {
               this._dataMatrix.push({
                  "bossId":boss.genericId,
                  "cat":ROOM_INFO_CAT_ID
               });
            }
         }
         if(!this.playedCharacter.isInFight())
         {
            this._dataMatrix.push({"cat":LEAVE_CAT_ID});
         }
         this.displayBreachInfo();
      }
      
      private function showBreachDetails() : void
      {
         this.gd_breachTracking.visible = !this.gd_breachTracking.visible;
         if(this.gd_breachTracking.visible)
         {
            this.tx_buttonMinimize.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_minus_floating_menu.png");
         }
         else
         {
            this.tx_buttonMinimize.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_plus_floating_menu.png");
         }
      }
      
      private function displayBreachInfo(selectedCategory:Object = null, forceOpen:Boolean = false) : void
      {
         var myIndex:int = 0;
         var entry:Object = null;
         var scrollValue:int = 0;
         var selecCatId:int = 0;
         if(selectedCategory)
         {
            selecCatId = selectedCategory.id;
            if(this._openedCategories.indexOf(selecCatId) != -1)
            {
               this._openedCategories.splice(this._openedCategories.indexOf(selecCatId),1);
            }
            else
            {
               this._openedCategories.push(selecCatId);
            }
         }
         var index:int = -1;
         var tempCats:Array = [];
         for each(entry in this._dataMatrix)
         {
            if(entry.isCat)
            {
               tempCats.push(entry);
               index++;
               if(entry.id == selecCatId)
               {
                  myIndex = index;
               }
            }
            if(!entry.isCat && this._openedCategories.indexOf(entry.cat) != -1 || entry.cat == GROUP_INFO_CAT_ID)
            {
               if(entry.cat == GROUP_INFO_CAT_ID)
               {
                  tempCats.push(entry);
                  if(!this._hideOwner)
                  {
                     if(!this._hideGroupInvitButton && this.breachApi.getOwnerId() == this.playedCharacter.id())
                     {
                        tempCats = this.addEmptyLine(tempCats,2);
                     }
                     else
                     {
                        tempCats = this.addEmptyLine(tempCats,1);
                     }
                  }
                  else if(!this._hideGroupInvitButton && this.breachApi.getOwnerId() == this.playedCharacter.id())
                  {
                     tempCats = this.addEmptyLine(tempCats,1);
                  }
               }
               else if(entry.cat == ROOM_INFO_CAT_ID)
               {
                  tempCats.push(entry);
                  tempCats = this.addEmptyLine(tempCats,3);
               }
               else
               {
                  tempCats.push(entry);
               }
               index++;
            }
            else if(entry.cat == LEAVE_CAT_ID)
            {
               tempCats.push(entry);
               index++;
            }
         }
         this.gd_breachTracking.height = tempCats.length * this.uiApi.me().getConstant("heightGridSlot");
         scrollValue = this.gd_breachTracking.verticalScrollValue;
         this.gd_breachTracking.dataProvider = tempCats;
         if(this.gd_breachTracking.selectedIndex != myIndex)
         {
            this.gd_breachTracking.silent = true;
            this.gd_breachTracking.selectedIndex = myIndex;
            this.gd_breachTracking.silent = false;
         }
         this.gd_breachTracking.verticalScrollValue = scrollValue;
      }
      
      private function addEmptyLine(array:Array, nb:uint) : Array
      {
         for(var i:int = 0; i < nb; i++)
         {
            array.push(null);
         }
         return array;
      }
      
      private function showOptions() : void
      {
         var menu:Array = [];
         menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.breach.hideBreachOwner"),this.showBreachOwner,null,false,null,this._hideOwner,true,null,true));
         var opacities:Array = [];
         opacities.push(this.modContextMenu.createContextMenuItemObject("50%",this.changeOpacity,[0.5],false,null,this._opacity == 0.5));
         opacities.push(this.modContextMenu.createContextMenuItemObject("60%",this.changeOpacity,[0.6],false,null,this._opacity == 0.6));
         opacities.push(this.modContextMenu.createContextMenuItemObject("70%",this.changeOpacity,[0.7],false,null,this._opacity == 0.7));
         opacities.push(this.modContextMenu.createContextMenuItemObject("80%",this.changeOpacity,[0.8],false,null,this._opacity == 0.8));
         menu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.cartography.opacitymenu"),null,null,false,opacities));
         this.modContextMenu.createContextMenu(menu);
      }
      
      private function showBreachOwner() : void
      {
         this._hideOwner = !this._hideOwner;
         this.updateData();
      }
      
      private function changeOpacity(opacity:Number, ctr:GraphicContainer = null) : void
      {
         this._opacity = opacity;
         this.sysApi.setData(OPACITY_DATA_ID,this._opacity,DataStoreEnum.BIND_ACCOUNT);
         if(ctr)
         {
            ctr.bgAlpha = opacity;
         }
         else
         {
            this.gd_breachTracking.updateItems();
         }
      }
      
      private function minimize() : void
      {
         if(!this._hidden)
         {
            this.mainCtr.visible = false;
            this.mainCtrMinimize.x = this.mainCtr.x;
            this.mainCtrMinimize.y = this.mainCtr.y;
            this.mainCtrMinimize.visible = true;
            this._hidden = true;
         }
      }
      
      private function maximized() : void
      {
         if(this._hidden)
         {
            this.mainCtr.visible = true;
            this.mainCtr.x = this.mainCtrMinimize.x;
            this.mainCtr.y = this.mainCtrMinimize.y;
            this.mainCtrMinimize.visible = false;
            this._hidden = false;
         }
      }
      
      private function initPosition() : void
      {
         var ctrMainQuestList:GraphicContainer = null;
         var topMargin:uint = 0;
         var questListUi:UiRootContainer = this.uiApi.getUi(UIEnum.QUEST_LIST);
         if(questListUi && questListUi.visible)
         {
            ctrMainQuestList = questListUi.getElement("ctr_main");
            topMargin = 200;
            if(this.mainCtr.contentHeight + topMargin < ctrMainQuestList.y)
            {
               this.mainCtr.x = 0;
               this.mainCtr.y = topMargin;
            }
            else if(ctrMainQuestList.y + ctrMainQuestList.contentHeight + this.mainCtr.contentHeight < this.uiApi.getStageHeight())
            {
               this.mainCtr.x = 0;
               this.mainCtr.y = ctrMainQuestList.y + ctrMainQuestList.contentHeight;
            }
            else
            {
               this.mainCtr.x = ctrMainQuestList.contentWidth;
               this.mainCtr.y = ctrMainQuestList.y;
            }
         }
         else
         {
            this.mainCtr.x = this.mainCtr.anchorX;
            this.mainCtr.y = this.mainCtr.anchorY;
         }
         this.uiApi.me().render();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_minimize:
               if(!this._hidden)
               {
                  this.minimize();
               }
               else
               {
                  this.showBreachDetails();
               }
               break;
            case this.btn_options:
               this.showOptions();
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.gd_breachTracking)
         {
            if(selectMethod != GridItemSelectMethodEnum.AUTO && this.gd_breachTracking.selectedItem && this.gd_breachTracking.selectedItem.isCat)
            {
               this.displayBreachInfo(this.gd_breachTracking.selectedItem);
            }
            else if(this.gd_breachTracking.selectedItem && !this.gd_breachTracking.selectedItem.isCat)
            {
               this.gd_breachTracking.focus();
            }
         }
      }
      
      public function onPress(target:GraphicContainer) : void
      {
         if(target == this.btn_breachTrackingMaximized)
         {
            this._lastX = Math.round(this.mainCtrMinimize.x);
            this._lastY = Math.round(this.mainCtrMinimize.y);
         }
      }
      
      public function onMouseUp(target:GraphicContainer) : void
      {
         var wasDragging:Boolean = false;
         if(target == this.btn_breachTrackingMaximized)
         {
            wasDragging = Math.round(this.mainCtrMinimize.x) != this._lastX || Math.round(this.mainCtrMinimize.y) != this._lastY;
            if(!wasDragging)
            {
               this.maximized();
            }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         if(target.name.indexOf("ctr_budget") != -1)
         {
            text = this.uiApi.getText("ui.breach.groupBudget");
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPLEFT,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}
