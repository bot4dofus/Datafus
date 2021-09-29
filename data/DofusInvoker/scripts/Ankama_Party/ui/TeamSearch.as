package Ankama_Party.ui
{
   import Ankama_Common.Common;
   import Ankama_Party.Party;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.datacenter.world.Dungeon;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderAvailableDungeonsAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderListenAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderRegisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyInvitationAction;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.DungeonPartyFinderPlayer;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PartyApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   
   public class TeamSearch
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PartyApi")]
      public var partyApi:PartyApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private const MAX_CHOSEN_DUNGEONS:uint = 10;
      
      private const FIGHTERS_LEVEL_FILTER_RANGE:uint = 50;
      
      private var _chosenDonjonsList:Array;
      
      private var _donjonsList:Array;
      
      private var _fightersList:Array;
      
      private var _donjonsFilter:Object;
      
      private var _fightersBreedFilter:Object;
      
      private var _fightersLevelFilter:Object;
      
      private var _nCurrentTab:uint = 0;
      
      private var _currentRegisterState:uint = 0;
      
      private var _bDescendingSortDonjons:Boolean = false;
      
      private var _bDescendingSortPlayers:Boolean = false;
      
      private var _addBtnList:Dictionary;
      
      private var _removeBtnList:Dictionary;
      
      private var _delaySendUpdateTimer:BenchmarkTimer;
      
      private var _updateNeeded:Boolean = false;
      
      private var _neverOpenedBefore:Boolean = true;
      
      public var btn_register:ButtonContainer;
      
      public var btn_search:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var ctr_donjons:GraphicContainer;
      
      public var inp_searchDonjon:Input;
      
      public var cbx_level:ComboBox;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var gd_donjons:Grid;
      
      public var ctr_register:GraphicContainer;
      
      public var gd_chosenDonjons:Grid;
      
      public var btn_subscribe:ButtonContainer;
      
      public var btn_lbl_btn_subscribe:Label;
      
      public var ctr_search:GraphicContainer;
      
      public var btn_tabSearchName:ButtonContainer;
      
      public var btn_tabSearchBreed:ButtonContainer;
      
      public var btn_tabSearchLevel:ButtonContainer;
      
      public var gd_fightersSearch:Grid;
      
      public var cbx_levelFighters:ComboBox;
      
      public var cbx_breedFighters:ComboBox;
      
      public var btn_invite:ButtonContainer;
      
      public function TeamSearch()
      {
         this._addBtnList = new Dictionary(true);
         this._removeBtnList = new Dictionary(true);
         super();
      }
      
      public function main(... params) : void
      {
         var breed:Breed = null;
         var cbxLevelFighters:Array = null;
         var lvl:uint = 0;
         var count:int = 0;
         var djId:int = 0;
         this.btn_register.soundId = SoundEnum.TAB;
         this.btn_search.soundId = SoundEnum.TAB;
         this.sysApi.addHook(RoleplayHookList.DungeonPartyFinderAvailableDungeons,this.onDungeonPartyFinderAvailableDungeons);
         this.sysApi.addHook(RoleplayHookList.DungeonPartyFinderRoomContent,this.onDungeonPartyFinderRoomContent);
         this.sysApi.addHook(RoleplayHookList.DungeonPartyFinderRegister,this.onDungeonPartyFinderRegister);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.uiApi.addComponentHook(this.btn_register,"onRelease");
         this.uiApi.addComponentHook(this.btn_search,"onRelease");
         this.uiApi.addComponentHook(this.btn_subscribe,"onRelease");
         this.uiApi.addComponentHook(this.btn_invite,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabName,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabLevel,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabSearchBreed,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabSearchLevel,"onRelease");
         this.uiApi.addComponentHook(this.btn_tabSearchName,"onRelease");
         this.uiApi.addComponentHook(this.gd_donjons,"onSelectItem");
         this.uiApi.addComponentHook(this.gd_chosenDonjons,"onSelectItem");
         this.uiApi.addComponentHook(this.gd_fightersSearch,"onSelectItem");
         this.uiApi.addComponentHook(this.cbx_level,"onSelectItem");
         this.uiApi.addComponentHook(this.cbx_breedFighters,"onSelectItem");
         this.uiApi.addComponentHook(this.cbx_levelFighters,"onSelectItem");
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._delaySendUpdateTimer = new BenchmarkTimer(5000,0,"TeamSearch._delaySendUpdateTimer");
         this._delaySendUpdateTimer.addEventListener(TimerEvent.TIMER,this.onDelayUpdateTimer);
         this._fightersList = [];
         this._donjonsList = [];
         this._chosenDonjonsList = [];
         this.gd_fightersSearch.dataProvider = [];
         var cbxBreedFighters:Array = [];
         cbxBreedFighters.push({
            "label":this.uiApi.getText("ui.common.allBreeds"),
            "value":0
         });
         for each(breed in this.dataApi.getBreeds())
         {
            cbxBreedFighters.push({
               "label":breed.shortName,
               "value":breed.id
            });
         }
         this.cbx_breedFighters.dataProvider = cbxBreedFighters;
         this._fightersBreedFilter = cbxBreedFighters[0];
         cbxLevelFighters = [];
         cbxLevelFighters.push({
            "label":this.uiApi.getText("ui.common.allLevels"),
            "value":0
         });
         for each(lvl in [50,100,150,200])
         {
            cbxLevelFighters.push({
               "label":lvl - this.FIGHTERS_LEVEL_FILTER_RANGE + 1 + "-" + lvl,
               "value":lvl
            });
         }
         this.cbx_levelFighters.dataProvider = cbxLevelFighters;
         this._fightersLevelFilter = cbxLevelFighters[0];
         this.sysApi.sendAction(new DungeonPartyFinderAvailableDungeonsAction([]));
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_register,this.uiApi.me());
         this.btn_register.selected = true;
         this.btn_subscribe.disabled = true;
         this.btn_invite.disabled = true;
         this._nCurrentTab = Party.getInstance().teamSearchTab;
         this.displaySelectedTab(this._nCurrentTab);
         if(this.partyApi.getAllSubscribedDungeons() && this.partyApi.getAllSubscribedDungeons().length > 0)
         {
            count = 0;
            for each(djId in this.partyApi.getAllSubscribedDungeons())
            {
               if(count < ProtocolConstantsEnum.MAX_DUNGEON_REGISTER)
               {
                  this._chosenDonjonsList.push(this.dataApi.getDungeon(djId));
               }
               count++;
            }
            this.onDungeonPartyFinderRegister(true);
         }
         if(this._chosenDonjonsList.length > 0)
         {
            this.btn_subscribe.disabled = false;
         }
         this.gd_chosenDonjons.dataProvider = this._chosenDonjonsList;
      }
      
      public function unload() : void
      {
         var chosenDonjonsTemp:Array = null;
         var dj:Dungeon = null;
         if(this._delaySendUpdateTimer)
         {
            this._delaySendUpdateTimer.removeEventListener(TimerEvent.TIMER,this.onDelayUpdateTimer);
            this._delaySendUpdateTimer.stop();
            this._delaySendUpdateTimer = null;
            if(this._updateNeeded)
            {
               chosenDonjonsTemp = [];
               for each(dj in this._chosenDonjonsList)
               {
                  chosenDonjonsTemp.push(dj.id);
               }
               this.sysApi.sendAction(new DungeonPartyFinderRegisterAction([chosenDonjonsTemp]));
            }
            this.sysApi.sendAction(new DungeonPartyFinderListenAction([0]));
         }
      }
      
      private function displaySelectedTab(tab:uint) : void
      {
         switch(tab)
         {
            case 0:
               this.ctr_register.visible = true;
               this.ctr_search.visible = false;
               this.btn_register.selected = true;
               break;
            case 1:
               this.ctr_register.visible = false;
               this.ctr_search.visible = true;
               this.btn_search.selected = true;
         }
         if(Party.getInstance().teamSearchTab != tab)
         {
            Party.getInstance().teamSearchTab = tab;
         }
         var sel:int = this.gd_donjons.selectedIndex;
         this.gd_donjons.selectedIndex = -1;
         this.gd_donjons.selectedIndex = sel;
      }
      
      private function filterFighters() : void
      {
         var tempFighters:Array = null;
         var fighter:DungeonPartyFinderPlayer = null;
         if(this._fightersBreedFilter && this._fightersLevelFilter)
         {
            tempFighters = [];
            if(this._fightersBreedFilter.value == 0)
            {
               if(this._fightersLevelFilter.value == 0)
               {
                  if(this.gd_fightersSearch.dataProvider != this._fightersList)
                  {
                     tempFighters = this._fightersList;
                  }
               }
               else
               {
                  for each(fighter in this._fightersList)
                  {
                     if(fighter.level <= this._fightersLevelFilter.value && fighter.level > this._fightersLevelFilter.value - this.FIGHTERS_LEVEL_FILTER_RANGE)
                     {
                        tempFighters.push(fighter);
                     }
                  }
               }
            }
            else if(this._fightersLevelFilter.value == 0)
            {
               for each(fighter in this._fightersList)
               {
                  if(fighter.breed == this._fightersBreedFilter.value)
                  {
                     tempFighters.push(fighter);
                  }
               }
            }
            else
            {
               for each(fighter in this._fightersList)
               {
                  if(fighter.level <= this._fightersLevelFilter.value && fighter.level > this._fightersLevelFilter.value - this.FIGHTERS_LEVEL_FILTER_RANGE && fighter.breed == this._fightersBreedFilter.value)
                  {
                     tempFighters.push(fighter);
                  }
               }
            }
            if(tempFighters.length > 50)
            {
               tempFighters = tempFighters.slice(0,50);
            }
            this.gd_fightersSearch.dataProvider = tempFighters;
            if(tempFighters.length == 0 || this.gd_fightersSearch.selectedIndex == -1)
            {
               this.btn_invite.disabled = true;
            }
            else
            {
               this.btn_invite.disabled = false;
            }
         }
      }
      
      private function filterDungeons() : void
      {
         var dj:Dungeon = null;
         var textFilter:String = this.inp_searchDonjon.text;
         var gridProvider:Array = [];
         if(this._donjonsFilter.value == 0 && !textFilter)
         {
            if(this.gd_donjons.dataProvider.length == this._donjonsList.length)
            {
               return;
            }
            gridProvider = this._donjonsList;
         }
         else
         {
            for each(dj in this._donjonsList)
            {
               if(dj.optimalPlayerLevel >= this._donjonsFilter.value)
               {
                  if(textFilter)
                  {
                     if(this.utilApi.noAccent(dj.name).toLowerCase().indexOf(this.utilApi.noAccent(textFilter).toLowerCase()) != -1)
                     {
                        gridProvider.push(dj);
                     }
                  }
                  else
                  {
                     gridProvider.push(dj);
                  }
               }
            }
         }
         this.gd_donjons.dataProvider = gridProvider;
      }
      
      public function updateDonjonLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(!this._addBtnList[componentsRef.btn_add.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_add,"onRelease");
            this.uiApi.addComponentHook(componentsRef.btn_add,"onRollOver");
            this.uiApi.addComponentHook(componentsRef.btn_add,"onRollOut");
         }
         this._addBtnList[componentsRef.btn_add.name] = data;
         if(data)
         {
            componentsRef.btn_donjon.softDisabled = false;
            componentsRef.btn_donjon.selected = selected;
            if(selected && this._nCurrentTab == 0)
            {
               componentsRef.btn_add.visible = true;
            }
            else
            {
               componentsRef.btn_add.visible = false;
            }
            if(this._chosenDonjonsList.length >= ProtocolConstantsEnum.MAX_DUNGEON_REGISTER)
            {
               componentsRef.btn_add.disabled = true;
            }
            else
            {
               componentsRef.btn_add.disabled = false;
            }
            componentsRef.lbl_name.text = data.name;
            componentsRef.lbl_level.text = "" + data.optimalPlayerLevel;
         }
         else
         {
            componentsRef.btn_add.selected = false;
            componentsRef.btn_add.visible = false;
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_level.text = "";
            componentsRef.btn_donjon.selected = false;
            componentsRef.btn_donjon.softDisabled = true;
         }
      }
      
      public function updateChosenDonjonLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(!this._removeBtnList[componentsRef.btn_remove.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_remove,"onRelease");
            this.uiApi.addComponentHook(componentsRef.btn_remove,"onRollOver");
            this.uiApi.addComponentHook(componentsRef.btn_remove,"onRollOut");
         }
         this._removeBtnList[componentsRef.btn_remove.name] = data;
         if(data)
         {
            componentsRef.btn_donjon.softDisabled = false;
            componentsRef.btn_donjon.selected = selected;
            if(this._currentRegisterState == 0)
            {
               componentsRef.tx_bg.bgAlpha = 0.3;
            }
            else
            {
               componentsRef.tx_bg.bgAlpha = 0;
            }
            componentsRef.lbl_name.text = data.name;
            componentsRef.lbl_level.text = data.optimalPlayerLevel;
            componentsRef.btn_remove.visible = true;
         }
         else
         {
            componentsRef.tx_bg.bgAlpha = 0;
            componentsRef.btn_remove.visible = false;
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_level.text = "";
            componentsRef.btn_donjon.selected = false;
            componentsRef.btn_donjon.softDisabled = true;
         }
      }
      
      public function updateFighterLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var playerLink:* = null;
         if(data)
         {
            componentsRef.btn_fighter.softDisabled = false;
            componentsRef.btn_fighter.selected = selected;
            playerLink = "{player," + data.playerName + "," + data.playerId + "::" + data.playerName + "}";
            componentsRef.lbl_name.text = playerLink;
            componentsRef.lbl_breed.text = this.dataApi.getBreed(data.breed).shortName;
            componentsRef.lbl_level.text = data.level;
         }
         else
         {
            componentsRef.btn_fighter.selected = false;
            componentsRef.btn_fighter.softDisabled = true;
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_breed.text = "";
            componentsRef.lbl_level.text = "";
         }
      }
      
      private function onDungeonPartyFinderAvailableDungeons(donjonsList:Object) : void
      {
         var donjonId:int = 0;
         var lvl:uint = 0;
         var sel:int = 0;
         var djId:int = 0;
         var dj:Dungeon = null;
         var dj2:Object = null;
         this._donjonsList = [];
         var cbxDP:Array = [];
         var tempLvl:Array = [];
         cbxDP.push({
            "label":this.uiApi.getText("ui.common.allLevels"),
            "value":0
         });
         for each(donjonId in donjonsList)
         {
            dj = this.dataApi.getDungeon(donjonId);
            this._donjonsList.push(dj);
            if(tempLvl.indexOf(dj.optimalPlayerLevel) == -1)
            {
               tempLvl.push(dj.optimalPlayerLevel);
            }
         }
         this._donjonsList.sortOn("optimalPlayerLevel",Array.NUMERIC);
         tempLvl.sort(Array.NUMERIC);
         for each(lvl in tempLvl)
         {
            cbxDP.push({
               "label":">" + lvl,
               "value":lvl
            });
         }
         sel = this.gd_donjons.selectedIndex;
         this.gd_donjons.dataProvider = this._donjonsList;
         this.cbx_level.dataProvider = cbxDP;
         this._donjonsFilter = cbxDP[0];
         djId = 0;
         if(this._neverOpenedBefore)
         {
            djId = Party.getInstance().teamSearchDonjon;
            sel = 0;
            for each(dj2 in this.gd_donjons.dataProvider)
            {
               if(dj2.id == djId)
               {
                  break;
               }
               sel++;
            }
         }
         this.gd_donjons.selectedIndex = -1;
         this.gd_donjons.selectedIndex = sel;
      }
      
      private function onDungeonPartyFinderRoomContent(players:Object) : void
      {
         var fighter:DungeonPartyFinderPlayer = null;
         this._fightersList = [];
         for each(fighter in players)
         {
            if(fighter.playerId != this.playerApi.id())
            {
               this._fightersList.push(fighter);
            }
         }
         this.filterFighters();
      }
      
      private function onDungeonPartyFinderRegister(result:Boolean) : void
      {
         this.btn_subscribe.softDisabled = false;
         this._updateNeeded = false;
         if(result)
         {
            this._currentRegisterState = 1;
            this.btn_lbl_btn_subscribe.text = this.uiApi.getText("ui.teamSearch.unregistration");
            this.gd_chosenDonjons.dataProvider = this._chosenDonjonsList;
            this.btn_subscribe.disabled = false;
            if(!this._delaySendUpdateTimer.running)
            {
               this._delaySendUpdateTimer.start();
            }
         }
         else
         {
            this._currentRegisterState = 0;
            this.btn_lbl_btn_subscribe.text = this.uiApi.getText("ui.teamSearch.registration");
            this.btn_subscribe.disabled = true;
            this.gd_chosenDonjons.dataProvider = [];
            this._chosenDonjonsList = [];
         }
      }
      
      public function onDelayUpdateTimer(e:TimerEvent) : void
      {
         var chosenDonjonsTemp:Array = null;
         var dj:Dungeon = null;
         if(this._updateNeeded)
         {
            this.btn_subscribe.softDisabled = true;
            chosenDonjonsTemp = [];
            for each(dj in this._chosenDonjonsList)
            {
               chosenDonjonsTemp.push(dj.id);
            }
            this.sysApi.sendAction(new DungeonPartyFinderRegisterAction([chosenDonjonsTemp]));
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               if(!this.inp_searchDonjon.haveFocus)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               return true;
            default:
               return false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var chosenDonjonsTemp:Array = null;
         var dj:Dungeon = null;
         var playerName:String = null;
         var sel:int = 0;
         var sel2:int = 0;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_subscribe:
               if(this.gd_chosenDonjons.dataProvider.length > 0)
               {
                  this.btn_subscribe.softDisabled = true;
                  chosenDonjonsTemp = [];
                  if(this._currentRegisterState == 0)
                  {
                     for each(dj in this._chosenDonjonsList)
                     {
                        chosenDonjonsTemp.push(dj.id);
                     }
                  }
                  this.sysApi.sendAction(new DungeonPartyFinderRegisterAction([chosenDonjonsTemp]));
               }
               else if(this._currentRegisterState == 1)
               {
                  this.sysApi.sendAction(new DungeonPartyFinderRegisterAction([]));
                  this._delaySendUpdateTimer.reset();
               }
               break;
            case this.btn_invite:
               if(this.gd_fightersSearch.selectedItem)
               {
                  playerName = this.gd_fightersSearch.selectedItem.playerName;
                  this.sysApi.sendAction(new PartyInvitationAction([playerName,this.gd_donjons.selectedItem.id]));
               }
               break;
            case this.btn_register:
               if(this._nCurrentTab != 0)
               {
                  this._neverOpenedBefore = false;
                  this._nCurrentTab = 0;
                  this.displaySelectedTab(this._nCurrentTab);
               }
               break;
            case this.btn_search:
               if(this._nCurrentTab != 1)
               {
                  this._neverOpenedBefore = false;
                  this._nCurrentTab = 1;
                  this.displaySelectedTab(this._nCurrentTab);
               }
               break;
            case this.btn_tabLevel:
               if(this._bDescendingSortDonjons)
               {
                  this.gd_donjons.sortOn("optimalPlayerLevel",Array.NUMERIC);
               }
               else
               {
                  this.gd_donjons.sortOn("optimalPlayerLevel",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSortDonjons = !this._bDescendingSortDonjons;
               break;
            case this.btn_tabName:
               if(this._bDescendingSortDonjons)
               {
                  this.gd_donjons.sortOn("name",Array.CASEINSENSITIVE);
               }
               else
               {
                  this.gd_donjons.sortOn("name",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               this._bDescendingSortDonjons = !this._bDescendingSortDonjons;
               break;
            case this.btn_tabSearchName:
               if(this._bDescendingSortPlayers)
               {
                  this.gd_fightersSearch.sortOn("playerName",Array.CASEINSENSITIVE);
               }
               else
               {
                  this.gd_fightersSearch.sortOn("playerName",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               this._bDescendingSortPlayers = !this._bDescendingSortPlayers;
               break;
            case this.btn_tabSearchLevel:
               if(this._bDescendingSortPlayers)
               {
                  this.gd_fightersSearch.sortOn("level",Array.NUMERIC);
               }
               else
               {
                  this.gd_fightersSearch.sortOn("level",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSortPlayers = !this._bDescendingSortPlayers;
               break;
            case this.btn_tabSearchBreed:
               if(this._bDescendingSortPlayers)
               {
                  this.gd_fightersSearch.sortOn("breed",Array.NUMERIC);
               }
               else
               {
                  this.gd_fightersSearch.sortOn("breed",Array.NUMERIC | Array.DESCENDING);
               }
               this._bDescendingSortPlayers = !this._bDescendingSortPlayers;
               break;
            default:
               if(target.name.indexOf("btn_add") != -1)
               {
                  if(this._chosenDonjonsList.indexOf(this._addBtnList[target.name]) == -1 && this._chosenDonjonsList.length < ProtocolConstantsEnum.MAX_DUNGEON_REGISTER)
                  {
                     this._chosenDonjonsList.push(this._addBtnList[target.name]);
                     this.gd_chosenDonjons.dataProvider = this._chosenDonjonsList;
                     this.btn_subscribe.disabled = false;
                     this._updateNeeded = true;
                     sel = this.gd_donjons.selectedIndex;
                     this.gd_donjons.selectedIndex = -1;
                     this.gd_donjons.selectedIndex = sel;
                  }
               }
               else if(target.name.indexOf("btn_remove") != -1)
               {
                  this._chosenDonjonsList.splice(this.gd_chosenDonjons.selectedIndex,1);
                  this.gd_chosenDonjons.dataProvider = this._chosenDonjonsList;
                  if(this._chosenDonjonsList.length == 0)
                  {
                     this.btn_subscribe.disabled = true;
                  }
                  this._updateNeeded = true;
                  sel2 = this.gd_donjons.selectedIndex;
                  this.gd_donjons.selectedIndex = -1;
                  this.gd_donjons.selectedIndex = sel2;
               }
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var donjonId:int = 0;
         switch(target)
         {
            case this.gd_donjons:
               if(this.gd_donjons.selectedIndex >= 0)
               {
                  if(!this.gd_donjons.dataProvider[this.gd_donjons.selectedIndex])
                  {
                     break;
                  }
                  donjonId = this.gd_donjons.dataProvider[this.gd_donjons.selectedIndex].id;
                  if(this._nCurrentTab == 1)
                  {
                     this.sysApi.sendAction(new DungeonPartyFinderListenAction([donjonId]));
                  }
                  if(Party.getInstance().teamSearchDonjon != donjonId)
                  {
                     Party.getInstance().teamSearchDonjon = donjonId;
                  }
                  this._neverOpenedBefore = false;
               }
               break;
            case this.cbx_level:
               switch(selectMethod)
               {
                  case 0:
                  case 3:
                  case 4:
                  case 8:
                     this._donjonsFilter = this.cbx_level.dataProvider[(target as ComboBox).selectedIndex];
                     this.filterDungeons();
               }
               break;
            case this.cbx_breedFighters:
               switch(selectMethod)
               {
                  case 0:
                  case 3:
                  case 4:
                  case 8:
                     this._fightersBreedFilter = this.cbx_breedFighters.dataProvider[(target as ComboBox).selectedIndex];
                     this.filterFighters();
               }
               break;
            case this.cbx_levelFighters:
               switch(selectMethod)
               {
                  case 0:
                  case 3:
                  case 4:
                  case 8:
                     this._fightersLevelFilter = this.cbx_levelFighters.dataProvider[(target as ComboBox).selectedIndex];
                     this.filterFighters();
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         if(target.name.indexOf("btn_add") != -1)
         {
            tooltipText = this.uiApi.getText("ui.teamSearch.addDonjon");
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
         else if(target.name.indexOf("btn_remove") != -1)
         {
            tooltipText = this.uiApi.getText("ui.teamSearch.removeDonjon");
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(this.inp_searchDonjon.haveFocus)
         {
            this.filterDungeons();
         }
      }
   }
}
