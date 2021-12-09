package Ankama_Connection.ui
{
   import Ankama_Common.Common;
   import Ankama_Connection.Connection;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.internalDatacenter.connection.BasicCharacterWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterDeletionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterReplayRequestAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterSelectionAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ConnectionApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SecurityApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.types.Uri;
   import flash.utils.Dictionary;
   
   public class CharacterSelection
   {
      
      private static const DEATH_STATE_ALIVE:uint = 0;
      
      private static const DEATH_STATE_DEAD:uint = 1;
      
      private static const DEATH_STATE_WAITING_CONFIRMATION:uint = 2;
      
      private static const LINES_COUNT_IN_SMALL_DISPLAY:uint = 10;
      
      private static const LINES_COUNT_IN_LARGE_DISPLAY:uint = 16;
      
      private static const MAX_LEVEL_TO_DELETE_WITHOUT_SECRET_ANSWER:uint = 20;
       
      
      public var output:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="ConnectionApi")]
      public var connecApi:ConnectionApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SecurityApi")]
      public var securityApi:SecurityApi;
      
      [Api(name="ConnectionApi")]
      public var connectionApi:ConnectionApi;
      
      private var _aCharactersList:Array;
      
      private var _nbCharacters:uint;
      
      private var _selectedChar:Object;
      
      private var _interactiveComponentsList:Dictionary;
      
      private var _cbProvider:Array;
      
      private var _askedToDeleteCharacterId:Number = 0;
      
      private var _lockPopup:String;
      
      private var _bgLevelUri:Uri;
      
      private var _bgPrestigeUri:Uri;
      
      private var _additionalHeightCtrWindow:int;
      
      private var _additionalHeightCtrBlock:int;
      
      private var _yCtrWindow:int;
      
      private var _yCtrGrid:int;
      
      private var _serverHeroicActivated:Boolean = false;
      
      private var _bonusXpCreation:int = 0;
      
      public var ctr_window:GraphicContainer;
      
      public var ctr_block:GraphicContainer;
      
      public var ctr_create:GraphicContainer;
      
      public var tx_breedIllu:Texture;
      
      public var tx_bgLight:Texture;
      
      public var tx_fakeGridLine:Texture;
      
      public var ctr_grid:GraphicContainer;
      
      public var gd_character:Grid;
      
      public var ed_chara:EntityDisplayer;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var ctr_articles:GraphicContainer;
      
      public var btn_articles:ButtonContainer;
      
      public var ctr_hardcore:GraphicContainer;
      
      public var lbl_deathCounter:Label;
      
      public var tx_bonusXp:Texture;
      
      public var tx_bonusXpCreation:Texture;
      
      public var btn_play:ButtonContainer;
      
      public var btn_create:ButtonContainer;
      
      public var btn_resetCharacter:ButtonContainer;
      
      public var ctr_resetCharacter:GraphicContainer;
      
      public var currentCharacterRollOver:Object;
      
      public function CharacterSelection()
      {
         this._interactiveComponentsList = new Dictionary(true);
         this._cbProvider = [];
         super();
      }
      
      public function main(charaList:Vector.<BasicCharacterWrapper>) : void
      {
         this._serverHeroicActivated = this.configApi.isFeatureWithKeywordEnabled("server.heroic");
         this.soundApi.switchIntroMusic(false);
         this.btn_create.soundId = SoundEnum.OK_BUTTON;
         this.btn_play.isMute = true;
         this.sysApi.addHook(HookList.CharactersListUpdated,this.onCharactersListUpdated);
         this.sysApi.addHook(HookList.CharacterDeletionError,this.onCharacterDeletionError);
         this.sysApi.addHook(HookList.CharacterImpossibleSelection,this.onCharacterImpossibleSelection);
         this.sysApi.addHook(HookList.GiftAssigned,this.onGiftAssigned);
         this.sysApi.addHook(HookList.CharacterCanBeCreated,this.onCharacterCanBeCreated);
         this.uiApi.addComponentHook(this.gd_character,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.tx_bonusXp,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_bonusXp,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_bonusXpCreation,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_bonusXpCreation,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_articles,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_articles,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_play,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_play,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_create,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ed_chara,ComponentHookList.ON_DOUBLE_CLICK);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this._bgLevelUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgLevel_uri"));
         this._bgPrestigeUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgPrestige_uri"));
         this._additionalHeightCtrWindow = this.uiApi.me().getConstant("additional_height_ctr_window");
         this._additionalHeightCtrBlock = this.uiApi.me().getConstant("additional_height_ctr_block");
         this._yCtrWindow = this.ctr_window.y;
         this._yCtrGrid = this.ctr_grid.y;
         this._aCharactersList = [];
         this.gd_character.autoSelectMode = 2;
         this.ed_chara.clearSubEntities = false;
         this.ed_chara.handCursor = true;
         this.ctr_articles.visible = this.sysApi.getGiftList().length > 0;
         this.onCharactersListUpdated(charaList);
      }
      
      public function unload() : void
      {
      }
      
      private function updateSelectedCharacter() : void
      {
         var deathCount:uint = 0;
         var deathState:uint = 0;
         if(!this._selectedChar)
         {
            return;
         }
         this.lbl_name.text = this._selectedChar.name;
         if(this._selectedChar.level > ProtocolConstantsEnum.MAX_LEVEL)
         {
            this.lbl_level.text = this.uiApi.getText("ui.common.short.prestige") + " " + (this._selectedChar.level - ProtocolConstantsEnum.MAX_LEVEL);
         }
         else
         {
            this.lbl_level.text = this.uiApi.getText("ui.common.short.level") + " " + this._selectedChar.level;
         }
         this.tx_breedIllu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus_uri") + "bgSelectCharacter/base_" + this._selectedChar.breedId + ".png");
         this.ed_chara.look = this._selectedChar.entityLook;
         if(this._selectedChar.bonusXp == 1)
         {
            this.tx_bonusXp.visible = false;
         }
         else
         {
            this.tx_bonusXp.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture_onboarding") + "xpBonusCircle" + (this._selectedChar.bonusXp - 1) + ".png");
            this.tx_bonusXp.visible = true;
         }
         var server:Server = this.sysApi.getCurrentServer();
         if(server.gameTypeId == 0)
         {
            this.btn_play.disabled = false;
            this.ctr_hardcore.visible = false;
            this.ctr_resetCharacter.visible = false;
            this.lbl_deathCounter.text = "x 12";
         }
         else
         {
            deathCount = this._selectedChar.deathCount;
            deathState = this._selectedChar.deathState;
            if(deathState == DEATH_STATE_ALIVE)
            {
               this.btn_play.disabled = false;
               this.ctr_hardcore.visible = false;
               this.ctr_resetCharacter.visible = false;
            }
            else
            {
               this.btn_play.disabled = true;
               this.ctr_hardcore.visible = true;
               this.ctr_resetCharacter.visible = true;
               this.lbl_deathCounter.text = "x " + deathCount;
            }
         }
         if(this._selectedChar.unusable)
         {
            this.btn_play.softDisabled = true;
         }
         else
         {
            this.btn_play.softDisabled = false;
         }
      }
      
      private function resizeCharactersGrid() : void
      {
         var gridSmallHeight:int = LINES_COUNT_IN_SMALL_DISPLAY * this.gd_character.slotHeight;
         var gridLargeHeight:int = LINES_COUNT_IN_LARGE_DISPLAY * this.gd_character.slotHeight;
         this.tx_fakeGridLine.y = 1 + (LINES_COUNT_IN_LARGE_DISPLAY + 1) * this.gd_character.slotHeight;
         if(this._nbCharacters > LINES_COUNT_IN_SMALL_DISPLAY)
         {
            return;
         }
         var yOffset:int = gridLargeHeight - gridSmallHeight;
         this.ctr_window.y = this._yCtrWindow + yOffset;
         this.ctr_grid.y = this._yCtrGrid + yOffset;
         this.tx_fakeGridLine.y = 1 + (LINES_COUNT_IN_SMALL_DISPLAY + 1) * this.gd_character.slotHeight;
         this.gd_character.height = gridSmallHeight;
         this.tx_bgLight.height = gridSmallHeight + this.gd_character.slotHeight;
         this.ctr_window.height = gridSmallHeight + this._additionalHeightCtrWindow;
         this.ctr_block.height = gridSmallHeight + this._additionalHeightCtrBlock;
         this.uiApi.me().render();
      }
      
      private function updateCreateButton() : void
      {
         if(!this.sysApi.getPlayerManager().canCreateNewCharacter && !this.sysApi.isCharacterCreationAllowed())
         {
            this.btn_create.disabled = true;
         }
         else
         {
            this.btn_create.disabled = false;
         }
         this.ctr_create.x = this.ctr_grid.x;
         this.ctr_create.y = this.ctr_grid.y + Math.min(this._nbCharacters + 1,LINES_COUNT_IN_LARGE_DISPLAY + 1) * this.gd_character.slotHeight;
         this.tx_fakeGridLine.visible = this.gd_character.pageYOffset % 2 == 0;
      }
      
      private function validateCharacterChoice() : void
      {
         var server:Server = null;
         if(this._selectedChar)
         {
            server = this.sysApi.getCurrentServer();
            if(this.securityApi.SecureModeisActive() && this.connectionApi.isCharacterWaitingForChange(this._selectedChar.id))
            {
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.characterToBeModifiedForbidden"),[this.uiApi.getText("ui.common.ok")]);
            }
            else
            {
               if(this._serverHeroicActivated || server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_EPIC)
               {
                  if(this._selectedChar.deathState != DEATH_STATE_ALIVE)
                  {
                     this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.popup.resetCharacter"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onPopupReset,this.onPopupClose],this.onPopupReset,this.onPopupClose);
                     return;
                  }
               }
               this.btn_play.disabled = true;
               this.sysApi.sendAction(new CharacterSelectionAction([this._selectedChar.id,false]));
               this.soundApi.playSound(SoundTypeEnum.PLAY_BUTTON);
            }
         }
      }
      
      public function updateCharacterLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(!this.gd_character.dataProvider.length > 0)
         {
            return;
         }
         if(data)
         {
            if(!this._interactiveComponentsList[componentsRef.btn_cross.name])
            {
               this.uiApi.addComponentHook(componentsRef.btn_cross,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(componentsRef.btn_cross,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_cross,ComponentHookList.ON_ROLL_OUT);
            }
            if(!this._interactiveComponentsList[componentsRef.btn_gridCharacter.name])
            {
               this.uiApi.addComponentHook(componentsRef.btn_gridCharacter,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_gridCharacter,ComponentHookList.ON_ROLL_OUT);
            }
            if(!this._interactiveComponentsList[componentsRef.tx_bonusXp.name])
            {
               this.uiApi.addComponentHook(componentsRef.tx_bonusXp,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_bonusXp,ComponentHookList.ON_ROLL_OUT);
            }
            this._interactiveComponentsList[componentsRef.btn_cross.name] = data;
            this._interactiveComponentsList[componentsRef.btn_gridCharacter.name] = data;
            this._interactiveComponentsList[componentsRef.tx_bonusXp.name] = data;
            if(data.bonusXp <= 1 || data.bonusXp >= 7)
            {
               componentsRef.tx_bonusXp.visible = false;
            }
            else
            {
               componentsRef.tx_bonusXp.visible = true;
               componentsRef.tx_bonusXp.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "XPBonus" + (data.bonusXp - 1).toString() + ".png");
            }
            componentsRef.lbl_name.text = data.name;
            componentsRef.lbl_breed.text = this.dataApi.getBreed(data.breedId).shortName;
            if(data.level > ProtocolConstantsEnum.MAX_LEVEL)
            {
               componentsRef.lbl_level.cssClass = "darkboldcenter";
               componentsRef.lbl_level.text = data.level - ProtocolConstantsEnum.MAX_LEVEL;
               componentsRef.tx_level.uri = this._bgPrestigeUri;
               this.uiApi.addComponentHook(componentsRef.tx_level,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_level,ComponentHookList.ON_ROLL_OUT);
            }
            else
            {
               componentsRef.lbl_level.cssClass = "boldcenter";
               componentsRef.lbl_level.text = data.level;
               componentsRef.tx_level.uri = this._bgLevelUri;
               this.uiApi.removeComponentHook(componentsRef.tx_level,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.removeComponentHook(componentsRef.tx_level,ComponentHookList.ON_ROLL_OUT);
            }
            if(!this.sysApi.isCharacterCreationAllowed())
            {
               componentsRef.btn_cross.disabled = true;
            }
            componentsRef.btn_gridCharacter.selected = selected;
            componentsRef.btn_cross.visible = true;
            componentsRef.btn_gridCharacter.disabled = false;
            this.updateCreateButton();
         }
         else
         {
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_breed.text = "";
            componentsRef.lbl_level.text = "";
            componentsRef.tx_level.uri = null;
            componentsRef.tx_bonusXp.gotoAndStop = "1";
            componentsRef.btn_cross.visible = false;
            componentsRef.btn_gridCharacter.selected = false;
            componentsRef.btn_gridCharacter.disabled = true;
            componentsRef.tx_bonusXp.visible = false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         switch(target)
         {
            case this.btn_play:
            case this.btn_resetCharacter:
               this.validateCharacterChoice();
               break;
            case this.btn_create:
               if(this.sysApi.getPlayerManager().canCreateNewCharacter && this.sysApi.isCharacterCreationAllowed())
               {
                  Connection.getInstance().characterCreationStart(this._aCharactersList);
               }
               else if(!this.sysApi.getPlayerManager().canCreateNewCharacter && this.sysApi.isCharacterCreationAllowed() && this.sysApi.getCurrentServer().gameTypeId != GameServerTypeEnum.SERVER_TYPE_TEMPORIS)
               {
                  this.createAddCharacterSlotPopup();
               }
               break;
            case this.btn_articles:
               this.uiApi.loadUi("giftMenu","giftMenu",{
                  "gift":this.sysApi.getGiftList(),
                  "chara":this.sysApi.getCharaListMinusDeadPeople()
               });
               break;
            default:
               if(target.name.indexOf("btn_cross") != -1)
               {
                  data = this._interactiveComponentsList[target.name];
                  this._askedToDeleteCharacterId = data.id;
                  if(data.level >= MAX_LEVEL_TO_DELETE_WITHOUT_SECRET_ANSWER && this.sysApi.getPlayerManager().secretQuestion != "")
                  {
                     this.uiApi.loadUi("secretPopup","secretPopup",[data.id,data.name]);
                  }
                  else
                  {
                     this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.popup.warnBeforeDelete",data.name),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onPopupDelete,this.onPopupClose],this.onPopupDelete,this.onPopupClose);
                  }
               }
         }
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_play:
               this.validateCharacterChoice();
               break;
            case this.ed_chara:
               this.validateCharacterChoice();
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               if(this._askedToDeleteCharacterId == 0)
               {
                  this.validateCharacterChoice();
               }
               return true;
            default:
               return false;
         }
      }
      
      public function onCharactersListUpdated(charactersList:Vector.<BasicCharacterWrapper>) : void
      {
         var cha:BasicCharacterWrapper = null;
         if(this._askedToDeleteCharacterId > 0)
         {
            this.soundApi.playSound(SoundTypeEnum.DELETE_CHARACTER);
            this._askedToDeleteCharacterId = 0;
            this.btn_play.disabled = false;
            this._lockPopup = null;
         }
         var server:Server = this.sysApi.getCurrentServer();
         this._bonusXpCreation = 0;
         this._aCharactersList = [];
         for each(cha in charactersList)
         {
            this._aCharactersList.push(cha);
            if(!this._serverHeroicActivated && server.gameTypeId != GameServerTypeEnum.SERVER_TYPE_EPIC)
            {
               if(cha.level > 1 && this._bonusXpCreation < 3)
               {
                  ++this._bonusXpCreation;
               }
            }
         }
         if(this._serverHeroicActivated || server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_EPIC)
         {
            this._bonusXpCreation = 2;
         }
         if(server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_CLASSICAL || this._serverHeroicActivated || server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_EPIC)
         {
            if(this._bonusXpCreation == 0)
            {
               this.tx_bonusXpCreation.visible = false;
            }
            else
            {
               this.tx_bonusXpCreation.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture_onboarding") + "xpBonusRectangle" + this._bonusXpCreation + ".png");
               this.tx_bonusXpCreation.visible = true;
            }
         }
         else
         {
            this.tx_bonusXpCreation.visible = false;
         }
         this._nbCharacters = this._aCharactersList.length;
         this.resizeCharactersGrid();
         if(this._nbCharacters == 0)
         {
            this.btn_play.disabled = true;
            this.ctr_resetCharacter.visible = false;
            this.gd_character.dataProvider = [];
            this._selectedChar = null;
            this.updateSelectedCharacter();
         }
         else
         {
            this.gd_character.dataProvider = this._aCharactersList;
            this._selectedChar = this.gd_character.selectedItem;
            if(!this._selectedChar)
            {
               this.gd_character.selectedIndex = 0;
               return;
            }
            this.updateSelectedCharacter();
         }
      }
      
      public function lockSelection() : void
      {
         this.btn_play.disabled = true;
         this._lockPopup = this.modCommon.openLockedPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.queue.wait"),null,true,[HookList.CharactersListUpdated,HookList.CharacterDeletionError],true,true);
      }
      
      public function onCharacterDeletionError(reason:String) : void
      {
         this._askedToDeleteCharacterId = 0;
         this.btn_play.disabled = false;
         this._lockPopup = null;
         this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.charSel.deletionError" + reason),[this.uiApi.getText("ui.common.ok")]);
      }
      
      public function onCharacterImpossibleSelection(pCharacterId:Number) : void
      {
         this.btn_play.disabled = false;
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.impossible_action"),this.uiApi.getText("ui.common.cantSelectThisCharacter"),[this.uiApi.getText("ui.common.ok")]);
      }
      
      private function onGiftAssigned(giftId:uint) : void
      {
         this.ctr_articles.visible = this.sysApi.getGiftList().length > 0;
      }
      
      private function onCharacterCanBeCreated() : void
      {
         this.updateCreateButton();
         this.gd_character.updateItems();
      }
      
      public function onPopupClose() : void
      {
      }
      
      public function onPopupDelete() : void
      {
         this.lockSelection();
         this.sysApi.sendAction(new CharacterDeletionAction([this._askedToDeleteCharacterId,"000000000000000000"]));
      }
      
      public function onPopupReset() : void
      {
         this.sysApi.sendAction(new CharacterReplayRequestAction([this._selectedChar.id]));
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:* = null;
         var server:Server = this.sysApi.getCurrentServer();
         switch(target)
         {
            case this.btn_articles:
               tooltipText = this.uiApi.getText("ui.charsel.newGift");
               break;
            case this.btn_play:
               if(this._selectedChar.unusable)
               {
                  tooltipText = this.uiApi.getText("ui.split.unavailableCharacter");
               }
               break;
            case this.tx_bonusXp:
               if(this._serverHeroicActivated || server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_EPIC)
               {
                  tooltipText = this.uiApi.getText("ui.common.experiencePoint") + " x " + this._selectedChar.bonusXp + "\n\n";
                  if(this._selectedChar.bonusXp == 6)
                  {
                     tooltipText += this.uiApi.getText("ui.information.xpHardcoreEpicDeathBonus");
                  }
                  else
                  {
                     tooltipText += this.uiApi.getText("ui.information.xpHardcoreEpicBonus");
                  }
               }
               else
               {
                  tooltipText = this.uiApi.getText("ui.common.experiencePoint") + " x " + this._selectedChar.bonusXp + "\n\n" + this.uiApi.getText("ui.information.xpFamilyBonus");
               }
               break;
            case this.tx_bonusXpCreation:
               if(this._serverHeroicActivated || server.gameTypeId == GameServerTypeEnum.SERVER_TYPE_EPIC)
               {
                  tooltipText = this.uiApi.getText("ui.common.experiencePoint") + " x 3\n\n" + this.uiApi.getText("ui.information.xpHardcoreEpicBonus");
               }
               else
               {
                  tooltipText = this.uiApi.getText("ui.common.experiencePoint") + " x " + (this._bonusXpCreation + 1) + "\n\n" + this.uiApi.getText("ui.information.xpFamilyBonus");
               }
               break;
            default:
               if(target.name.indexOf("btn_cross") != -1)
               {
                  tooltipText = this.uiApi.getText("ui.charsel.characterDelete");
                  if(this.currentCharacterRollOver)
                  {
                     this.currentCharacterRollOver.state = !!this.currentCharacterRollOver.selected ? StatesEnum.STATE_SELECTED_CLICKED : StatesEnum.STATE_OVER;
                  }
               }
               else if(target.name.indexOf("btn_gridCharacter") != -1)
               {
                  this.currentCharacterRollOver = target;
               }
               else if(target.name.indexOf("tx_level") != -1)
               {
                  tooltipText = this.uiApi.getText("ui.tooltip.OmegaLevel");
               }
               else if(target.name.indexOf("tx_bonusXp") != -1)
               {
                  tooltipText = this.uiApi.getText("ui.common.experiencePoint") + " x " + this._interactiveComponentsList[target.name].bonusXp + "\n\n" + this.uiApi.getText("ui.information.xpFamilyBonus");
               }
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",0,8,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
         if(this.currentCharacterRollOver && (this.currentCharacterRollOver.state != StatesEnum.STATE_SELECTED_CLICKED && this.currentCharacterRollOver.state != StatesEnum.STATE_SELECTED))
         {
            this.currentCharacterRollOver.state = StatesEnum.STATE_NORMAL;
         }
      }
      
      public function onPopupAddCharacterSlot() : void
      {
         this.sysApi.goToUrl(this.uiApi.getText("ui.link.addCharacterSlot"));
      }
      
      private function createAddCharacterSlotPopup() : void
      {
         var server:Server = this.sysApi.getCurrentServer();
         var characterLimit:int = this.getNbCharacters(server.gameTypeId);
         var serveurTypeTxt:String = server.gameTypeId != -1 ? this.uiApi.getText("ui.server.type." + server.gameTypeId) : "unknown";
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.popup.warnAddNewCharacterSlot",characterLimit,serveurTypeTxt),[this.uiApi.getText("ui.shop.addNewCharacterSlot")],[this.onPopupAddCharacterSlot],this.onPopupAddCharacterSlot,null,null,false,false,true,[{
            "uri":this.uiApi.me().getConstant("texture") + "btnIcon/btnIcon_external_link.png",
            "size":22
         }]);
      }
      
      public function getNbCharacters(type:int) : int
      {
         var server:GameServerInformations = null;
         var currServer:Server = null;
         var serversList:Vector.<GameServerInformations> = this.connecApi.getServers();
         var _nbCharacter:int = 0;
         for each(server in serversList)
         {
            currServer = this.dataApi.getServer(server.id);
            if(currServer.gameTypeId == type)
            {
               _nbCharacter += server.charactersCount;
            }
         }
         return _nbCharacter;
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.gd_character:
               this._selectedChar = this.gd_character.selectedItem;
               if(!this._selectedChar)
               {
                  this.gd_character.selectedIndex = 0;
                  return;
               }
               if(isNewSelection)
               {
                  this.updateSelectedCharacter();
               }
               if(selectMethod == SelectMethodEnum.DOUBLE_CLICK)
               {
                  this.validateCharacterChoice();
               }
               break;
         }
      }
   }
}
