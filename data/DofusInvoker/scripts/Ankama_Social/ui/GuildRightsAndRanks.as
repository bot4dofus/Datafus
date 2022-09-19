package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.GuildChestTab;
   import com.ankamagames.dofus.datacenter.guild.GuildRight;
   import com.ankamagames.dofus.datacenter.guild.GuildRightGroup;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildRanksRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.UpdateAllGuildRankRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.UpdateGuildRightsAction;
   import com.ankamagames.dofus.logic.game.common.frames.InventoryManagementFrame;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.GuildRightsEnum;
   import com.ankamagames.dofus.network.types.game.guild.GuildRankInformation;
   import com.ankamagames.dofus.network.types.game.inventory.StorageTabInformation;
   import com.ankamagames.dofus.uiApi.CaptureApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SecurityApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.PixelSnapping;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.Dictionary;
   
   public class GuildRightsAndRanks
   {
      
      private static const CTR_RIGHT_CAT:String = "ctr_category";
      
      private static const CTR_RIGHT:String = "ctr_right";
       
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SecurityApi")]
      public var secureApi:SecurityApi;
      
      [Api(name="CaptureApi")]
      public var captureApi:CaptureApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      public var btn_close:ButtonContainer;
      
      public var btn_generalRights:ButtonContainer;
      
      public var btn_chestRights:ButtonContainer;
      
      public var btn_createRank:ButtonContainer;
      
      public var btn_saveRights:ButtonContainer;
      
      public var lbl_selectAll:Label;
      
      public var gd_ranks:Grid;
      
      public var gd_rights:Grid;
      
      private const CTR_RANK_NAME:String = "ctr_rank";
      
      private const BTN_LINE_NAME:String = "btn_line";
      
      private const BTN_REMOVE_RANK:String = "btn_removeRank";
      
      private const BTN_EDIT_RANK:String = "btn_editRank";
      
      private const BTN_MOVE_RANK:String = "btn_moveRank";
      
      private const GUILD_GENERAL_RIGHTS_TAB:uint = 0;
      
      private const GUILD_CHEST_RIGHTS_TAB:uint = 1;
      
      private const SELECTION_STATE_SELECTALL:uint = 0;
      
      private const SELECTION_STATE_UNSELECTALL:uint = 1;
      
      private const MAX_GUILD_RANK:uint = 30;
      
      private const GENERAL_RIGHT_GROUP_IDS:Array = [DataEnum.GUILD_RIGHTS_GROUP_MEMBERS_ID,DataEnum.GUILD_RIGHTS_GROUP_XP_ID,DataEnum.GUILD_RIGHTS_GROUP_LOGBOOK_ID,DataEnum.GUILD_RIGHTS_GROUP_TAX_COLLECTOR_ID,DataEnum.GUILD_RIGHTS_GROUP_PADDOCKS_ID,DataEnum.GUILD_RIGHTS_GROUP_ALLIANCE_ID];
      
      private const CHEST_RIGHT_GROUP_IDS:Array = [DataEnum.GUILD_RIGHTS_GROUP_CHEST_LOGBOOK_ID,DataEnum.GUILD_RIGHTS_GROUP_CHEST_1_ID,DataEnum.GUILD_RIGHTS_GROUP_CHEST_2_ID,DataEnum.GUILD_RIGHTS_GROUP_CHEST_3_ID,DataEnum.GUILD_RIGHTS_GROUP_CHEST_4_ID];
      
      private var _componentList:Dictionary;
      
      private var _chestTabActivated:Boolean;
      
      private var _nCurrentTab:uint = 0;
      
      private var _maxOrder:uint = 4.294967295E9;
      
      private var _currentRankRollOver:GraphicContainer;
      
      private var _selectedRank:GuildRankInformation;
      
      private var _selectedRankId:uint;
      
      private var _prevRights:Vector.<uint>;
      
      private var _guildRanks:Vector.<GuildRankInformation>;
      
      private var _currentMovingRank:GuildRankInformation;
      
      private var _moving:Boolean;
      
      private var _rankBitmap:Bitmap;
      
      private var _firstClick:Boolean;
      
      private var _openedCategoryIds:Array;
      
      private var _guildGeneralRightGroups:Vector.<GuildRightGroup>;
      
      private var _guildChestRightGroups:Vector.<GuildRightGroup>;
      
      private var _rightsGridArray:Array;
      
      public var currentTabName:String;
      
      private var _availableRightsToManage:Vector.<uint>;
      
      private var _currentSelectedRights:uint = 0;
      
      private var _labelSelectAllState:uint = 0;
      
      private var _preselectedRankId:int = -1;
      
      private var _inventoryFrame:InventoryManagementFrame;
      
      public function GuildRightsAndRanks()
      {
         this._componentList = new Dictionary(true);
         this._openedCategoryIds = [];
         this._guildGeneralRightGroups = new Vector.<GuildRightGroup>();
         this._guildChestRightGroups = new Vector.<GuildRightGroup>();
         this._rightsGridArray = [];
         this._availableRightsToManage = new Vector.<uint>();
         super();
      }
      
      public function main(... params) : void
      {
         this._chestTabActivated = this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.GUILD_CHEST_TAB);
         this._inventoryFrame = Kernel.getWorker().getFrame(InventoryManagementFrame) as InventoryManagementFrame;
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.uiApi.addComponentHook(this.btn_createRank,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_createRank,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_createRank,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_saveRights,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.lbl_selectAll,ComponentHookList.ON_RELEASE);
         this.sysApi.addHook(SocialHookList.GuildRanksReceived,this.onGuildRanksReceived);
         this.sysApi.addHook(ExchangeHookList.MultiTabStorage,this.onMultiTabStorage);
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_generalRights,this.uiApi.me());
         this.btn_generalRights.selected = true;
         this.currentTabName = this.btn_generalRights.name;
         this.initRights();
         this.displaySelectedTab(this._nCurrentTab);
         if(params[0])
         {
            this._preselectedRankId = params[0].selectedRank;
         }
         this.sysApi.sendAction(GuildRanksRequestAction.create());
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
         this.cleanMovingRank();
      }
      
      public function updateRank(data:*, components:*, selected:Boolean) : void
      {
         var rankComponents:RankComponents = null;
         var lblRankMaxWidth:Number = NaN;
         if(data)
         {
            rankComponents = new RankComponents();
            rankComponents.movableContainer = components.ctr_movable;
            rankComponents.hoverTexture = components.tx_insertRank;
            rankComponents.btnMoveRank = components.btn_moveRank;
            rankComponents.btnEditRank = components.btn_editRank;
            rankComponents.btnRemoveRank = components.btn_removeRank;
            if(!this._componentList[components.btn_line.name])
            {
               this.uiApi.addComponentHook(components.btn_line,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(components.btn_line,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.btn_line,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.btn_line.name] = {
               "data":data,
               "rankComponents":rankComponents
            };
            if(!this._componentList[components.ctr_rank.name])
            {
               this.uiApi.addComponentHook(components.ctr_rank,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(components.ctr_rank,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.ctr_rank,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.ctr_rank.name] = data;
            if(!this._componentList[components.btn_moveRank.name])
            {
               this.uiApi.addComponentHook(components.btn_moveRank,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(components.btn_moveRank,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.btn_moveRank,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.btn_moveRank.name] = data;
            if(!this._componentList[components.btn_removeRank.name])
            {
               this.uiApi.addComponentHook(components.btn_removeRank,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(components.btn_removeRank,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.btn_removeRank,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.btn_removeRank.name] = data;
            if(!this._componentList[components.btn_editRank.name])
            {
               this.uiApi.addComponentHook(components.btn_editRank,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(components.btn_editRank,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(components.btn_editRank,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentList[components.btn_editRank.name] = data;
            components.btn_line.visible = true;
            components.btn_line.selected = selected;
            components.tx_rank.uri = this.uiApi.createUri(this.uiApi.me().getConstant("ranks_uri") + data.gfxId + ".png");
            lblRankMaxWidth = this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) != -1 ? Number(this.uiApi.me().getConstant("minGuildRankLabelWidth")) : Number(this.uiApi.me().getConstant("maxGuildRankLabelWidth"));
            components.lbl_rank.text = data.name;
            components.lbl_rank.fullWidth();
            if(components.lbl_rank.width > lblRankMaxWidth)
            {
               components.lbl_rank.width = lblRankMaxWidth;
            }
            if((data as GuildRankInformation).order == this._maxOrder)
            {
               components.tx_insertRank.y = -1;
            }
            else
            {
               components.tx_insertRank.y = components.ctr_rank.height - 1;
            }
         }
         else
         {
            components.tx_rank.uri = null;
            components.lbl_rank.text = "";
            components.btn_line.visible = false;
            components.tx_insertRank.visible = false;
            components.btn_moveRank.visible = false;
            components.btn_removeRank.visible = false;
         }
      }
      
      public function updateRight(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         var tabIndex:int = 0;
         var tabName:String = null;
         var tab:GuildChestTab = null;
         switch(this.getRightLineType(data,line))
         {
            case CTR_RIGHT_CAT:
               if(!this._componentList[componentsRef.ctr_category.name])
               {
                  this.uiApi.addComponentHook(componentsRef.ctr_category,ComponentHookList.ON_RELEASE);
               }
               this._componentList[componentsRef.ctr_category.name] = data;
               if(this._openedCategoryIds.indexOf(data.id) != -1)
               {
                  componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_minus_grey.png");
               }
               else
               {
                  componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_plus_grey.png");
               }
               if(this.CHEST_RIGHT_GROUP_IDS.indexOf((data as GuildRightGroup).id) != -1 && (data as GuildRightGroup).id != DataEnum.GUILD_RIGHTS_GROUP_CHEST_LOGBOOK_ID)
               {
                  if(this._chestTabActivated)
                  {
                     tabIndex = this.CHEST_RIGHT_GROUP_IDS.indexOf((data as GuildRightGroup).id);
                     tabName = this._inventoryFrame.guildChestTabs[tabIndex - 1].name;
                     if(tabName.indexOf("guild.chest.tab") != -1)
                     {
                        tab = GuildChestTab.getGuildChestTabByIndex(tabIndex);
                        if(tab)
                        {
                           componentsRef.lbl_categoryName.text = StringUtils.replace((data as GuildRightGroup).name,"%1",tab.name);
                        }
                     }
                     else
                     {
                        componentsRef.lbl_categoryName.text = StringUtils.replace((data as GuildRightGroup).name,"%1",tabName);
                     }
                  }
                  else
                  {
                     componentsRef.lbl_categoryName.text = this.uiApi.getText("ui.guild.chestTitleOneTab");
                  }
               }
               else
               {
                  componentsRef.lbl_categoryName.text = (data as GuildRightGroup).name;
               }
               break;
            case CTR_RIGHT:
               if(!this._componentList[componentsRef.lblcb_right.name])
               {
                  this.uiApi.addComponentHook(componentsRef.lblcb_right,ComponentHookList.ON_RELEASE);
               }
               this._componentList[componentsRef.lblcb_right.name] = data;
               componentsRef.lblcb_right.visible = true;
               componentsRef.lblcb_right.selected = this._selectedRank && this._selectedRank.rights.indexOf((data as GuildRight).id) != -1;
               componentsRef.lblcb_right.disabled = this.disableRight(data);
               componentsRef.btn_label_lblcb_right.text = (data as GuildRight).name;
               break;
            default:
               componentsRef.lbl_categoryName.text = "";
               componentsRef.btn_label_lblcb_right.text = "";
               componentsRef.lblcb_right.visible = false;
         }
      }
      
      public function getRightLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data is GuildRightGroup)
         {
            return CTR_RIGHT_CAT;
         }
         return CTR_RIGHT;
      }
      
      private function initRights() : void
      {
         var rightGroup:GuildRightGroup = null;
         var id:uint = 0;
         var i:uint = 0;
         var index:int = 0;
         this._guildGeneralRightGroups = new Vector.<GuildRightGroup>();
         this._guildGeneralRightGroups = new Vector.<GuildRightGroup>();
         var initOpenedCategories:Array = [];
         if(this._openedCategoryIds.length == 0)
         {
            for each(rightGroup in this.dataApi.getGuildRightGroups())
            {
               initOpenedCategories.push(rightGroup.id);
            }
         }
         this._openedCategoryIds = this.sysApi.getSetData("openedGuildRightsCat",initOpenedCategories);
         rightGroup = null;
         for each(id in this.GENERAL_RIGHT_GROUP_IDS)
         {
            rightGroup = this.dataApi.getGuildRightGroupById(id);
            if(rightGroup)
            {
               this._guildGeneralRightGroups.push(rightGroup);
            }
         }
         this._guildGeneralRightGroups = this.utilApi.sort(this._guildGeneralRightGroups,"order",true,true);
         i = 0;
         if(this._chestTabActivated)
         {
            for(i = 0; i < this.CHEST_RIGHT_GROUP_IDS.length; i++)
            {
               if(this._inventoryFrame.guildChestTabs.length >= i)
               {
                  rightGroup = this.dataApi.getGuildRightGroupById(this.CHEST_RIGHT_GROUP_IDS[i]);
                  if(rightGroup)
                  {
                     this._guildChestRightGroups.push(rightGroup);
                  }
               }
            }
         }
         else
         {
            index = this.CHEST_RIGHT_GROUP_IDS.indexOf(DataEnum.GUILD_RIGHTS_GROUP_CHEST_1_ID);
            for(i = 0; i <= index; i++)
            {
               rightGroup = this.dataApi.getGuildRightGroupById(this.CHEST_RIGHT_GROUP_IDS[i]);
               if(rightGroup)
               {
                  this._guildChestRightGroups.push(rightGroup);
               }
            }
         }
         this._guildChestRightGroups = this.utilApi.sort(this._guildChestRightGroups,"order",true,true);
      }
      
      private function onGuildRanksReceived(ranks:Vector.<GuildRankInformation>) : void
      {
         var guildRank:GuildRankInformation = null;
         var rank:GuildRankInformation = null;
         this.cleanMovingRank();
         this._guildRanks = ranks;
         this._maxOrder = this._guildRanks[this._guildRanks.length - 1].order;
         this.gd_ranks.dataProvider = this._guildRanks;
         this._selectedRank = null;
         if(this._preselectedRankId != -1)
         {
            for each(guildRank in this.gd_ranks.dataProvider)
            {
               if(guildRank.id == this._preselectedRankId)
               {
                  this._selectedRank = guildRank;
               }
            }
            this._preselectedRankId = -1;
         }
         else
         {
            this._selectedRankId = this.sysApi.getSetData("lastGuildRankSelected_" + this.playerApi.id(),this._guildRanks[0].id);
            for each(rank in this._guildRanks)
            {
               if(this._selectedRankId == rank.id)
               {
                  this._selectedRank = rank;
                  break;
               }
            }
         }
         if(this._selectedRank)
         {
            this.selectRank(this._selectedRank);
         }
         else
         {
            this.selectRank(this._guildRanks[0]);
         }
         this.btn_createRank.softDisabled = this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) == -1 || this._guildRanks.length >= this.MAX_GUILD_RANK;
      }
      
      private function switchRanks(movingRank:GuildRankInformation, targetRank:GuildRankInformation) : void
      {
         var rank:GuildRankInformation = null;
         if(!movingRank.modifiable)
         {
            return;
         }
         var movingRankOrder:uint = movingRank.order;
         var targetRankOrder:uint = targetRank.order;
         if(targetRankOrder == this._maxOrder)
         {
            this._guildRanks.insertAt(this._guildRanks.length - 1,movingRank);
         }
         else
         {
            this._guildRanks.insertAt(targetRankOrder + 1,movingRank);
         }
         if(movingRankOrder < targetRankOrder)
         {
            this._guildRanks.splice(movingRankOrder,1);
         }
         else
         {
            this._guildRanks.splice(movingRankOrder + 1,1);
         }
         for each(rank in this._guildRanks)
         {
            rank.order = this._guildRanks.indexOf(rank) == this._guildRanks.length - 1 ? uint(this._maxOrder) : uint(this._guildRanks.indexOf(rank));
         }
         this.sysApi.sendAction(UpdateAllGuildRankRequestAction.create(this._guildRanks));
      }
      
      private function cleanMovingRank() : void
      {
         this.sysApi.removeEventListener(this.onEnterFrame);
         if(StageShareManager.stage.hasEventListener(MouseEvent.CLICK))
         {
            StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         }
         this.hideLineElements();
         this._currentMovingRank = null;
         this._moving = false;
         this.sysApi.setMouseCursor(MouseCursor.AUTO);
         if(this._rankBitmap)
         {
            StageShareManager.stage.removeChild(this._rankBitmap);
         }
         this._rankBitmap = null;
      }
      
      private function showLineElements() : void
      {
         var rankComponents:RankComponents = null;
         var rank:GuildRankInformation = null;
         var playerRank:GuildRankInformation = null;
         if(this._currentRankRollOver && this.socialApi.playerGuildRank && this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) != -1)
         {
            rankComponents = this._componentList[this._currentRankRollOver.name].rankComponents as RankComponents;
            rank = this._componentList[this._currentRankRollOver.name].data as GuildRankInformation;
            playerRank = this.socialApi.playerGuildRank;
            if(playerRank)
            {
               rankComponents.hoverTexture.visible = this._moving && playerRank.order <= rank.order;
               rankComponents.btnMoveRank.visible = !this._moving && rank.modifiable;
               rankComponents.btnMoveRank.softDisabled = playerRank.order >= rank.order;
               rankComponents.btnEditRank.visible = !this._moving && this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) != -1;
               rankComponents.btnEditRank.softDisabled = rank.order == 0 ? playerRank.order > rank.order : playerRank.order >= rank.order;
               rankComponents.btnRemoveRank.visible = !this._moving && rank.modifiable && this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) != -1;
               rankComponents.btnRemoveRank.softDisabled = playerRank.order >= rank.order;
            }
         }
      }
      
      private function hideLineElements() : void
      {
         var rankComponents:RankComponents = null;
         if(this._currentRankRollOver)
         {
            rankComponents = this._componentList[this._currentRankRollOver.name].rankComponents as RankComponents;
            rankComponents.hoverTexture.visible = false;
            rankComponents.btnMoveRank.visible = false;
            rankComponents.btnEditRank.visible = false;
            rankComponents.btnRemoveRank.visible = false;
         }
      }
      
      private function createBitmap() : void
      {
         var rankComponents:RankComponents = this._componentList[this._currentRankRollOver.name].rankComponents as RankComponents;
         var rect:Rectangle = new Rectangle(0,0,rankComponents.movableContainer.width,rankComponents.movableContainer.height);
         var adjustAlpha:ColorTransform = new ColorTransform();
         adjustAlpha.alphaMultiplier = 0.9;
         rankComponents.btnMoveRank.visible = false;
         var rankCtr:BitmapData = this.captureApi.getFromTarget(rankComponents.movableContainer,rect,1,true);
         rankCtr.colorTransform(rect,adjustAlpha);
         rankComponents.btnMoveRank.visible = true;
         this._rankBitmap = new Bitmap(rankCtr,PixelSnapping.AUTO,true);
         this._rankBitmap.width *= 0.85;
         this._rankBitmap.height *= 0.85;
         StageShareManager.stage.addChild(this._rankBitmap);
      }
      
      private function displaySelectedTab(tab:uint) : void
      {
         var group:GuildRightGroup = null;
         var right:GuildRight = null;
         this._rightsGridArray = [];
         switch(tab)
         {
            case this.GUILD_GENERAL_RIGHTS_TAB:
               for each(group in this._guildGeneralRightGroups)
               {
                  this._rightsGridArray.push(group);
                  for each(right in group.getSortedGuildRightsByOrder())
                  {
                     this._rightsGridArray.push(right);
                  }
               }
               break;
            case this.GUILD_CHEST_RIGHTS_TAB:
               for each(group in this._guildChestRightGroups)
               {
                  this._rightsGridArray.push(group);
                  for each(right in group.getSortedGuildRightsByOrder())
                  {
                     this._rightsGridArray.push(right);
                  }
               }
         }
         this.initSelectionState();
         this.gd_rights.dataProvider = this._rightsGridArray;
         this.displayCategories();
      }
      
      private function removeRank(guildRankInfo:GuildRankInformation) : void
      {
         this._currentRankRollOver = null;
         this.uiApi.loadUi(UIEnum.REMOVE_GUILD_RANK_POPUP,UIEnum.REMOVE_GUILD_RANK_POPUP,{"guildRankInfo":guildRankInfo});
      }
      
      private function modifyRank(guildRankInfo:GuildRankInformation) : void
      {
         this._currentRankRollOver = null;
         this.uiApi.loadUi(UIEnum.MODIFY_GUILD_RANK_POPUP,UIEnum.MODIFY_GUILD_RANK_POPUP,{"guildRankInfo":guildRankInfo});
      }
      
      private function displayCategories(selectedCategory:GuildRightGroup = null) : void
      {
         var myIndex:int = 0;
         var entry:* = undefined;
         var scrollValue:int = 0;
         var selecCatId:int = 0;
         if(selectedCategory)
         {
            selecCatId = selectedCategory.id;
            if(this._openedCategoryIds.indexOf(selecCatId) != -1)
            {
               this._openedCategoryIds.splice(this._openedCategoryIds.indexOf(selecCatId),1);
            }
            else
            {
               this._openedCategoryIds.push(selecCatId);
            }
         }
         var index:int = -1;
         var tempCats:Array = [];
         for each(entry in this._rightsGridArray)
         {
            if(entry is GuildRightGroup)
            {
               tempCats.push(entry);
               index++;
               if(entry.id == selecCatId)
               {
                  myIndex = index;
               }
            }
            if(entry is GuildRight && this._openedCategoryIds.indexOf((entry as GuildRight).groupId) != -1)
            {
               tempCats.push(entry);
               index++;
            }
         }
         scrollValue = this.gd_rights.verticalScrollValue;
         this.gd_rights.dataProvider = tempCats;
         if(this.gd_rights.selectedIndex != myIndex)
         {
            this.gd_rights.silent = true;
            this.gd_rights.selectedIndex = myIndex;
            this.gd_rights.silent = false;
         }
         this.gd_rights.verticalScrollValue = scrollValue;
         this.sysApi.setData("openedGuildRightsCat",this._openedCategoryIds);
      }
      
      private function selectRank(rank:GuildRankInformation, saveRights:Boolean = true) : void
      {
         if(saveRights)
         {
            this._prevRights = rank.rights.concat();
         }
         this.gd_ranks.selectedItem = rank;
         this._selectedRank = this.gd_ranks.selectedItem;
         this.sysApi.setData("lastGuildRankSelected_" + this.playerApi.id(),this._selectedRank.id);
         this.gd_rights.updateItems();
         this.initSelectionState();
         this.btn_saveRights.softDisabled = !this.hasModification() || this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) == -1;
      }
      
      private function initSelectionState() : void
      {
         var rightList:Vector.<GuildRightGroup> = null;
         var rightGroup:GuildRightGroup = null;
         var right:GuildRight = null;
         this._availableRightsToManage = new Vector.<uint>();
         this._currentSelectedRights = 0;
         if(this._selectedRank && this.socialApi.playerGuildRank.order < this._selectedRank.order)
         {
            rightList = this._nCurrentTab == this.GUILD_CHEST_RIGHTS_TAB ? this._guildChestRightGroups : this._guildGeneralRightGroups;
            for each(rightGroup in rightList)
            {
               for each(right in rightGroup.guildRights)
               {
                  if(!this.disableRight(right))
                  {
                     this._availableRightsToManage.push(right.id);
                  }
                  if(this._selectedRank && this._selectedRank.rights.indexOf(right.id) != -1 && this.socialApi.playerGuildRank.rights.indexOf(right.id) != -1)
                  {
                     ++this._currentSelectedRights;
                  }
               }
            }
         }
         this.updateSelectAllLabel();
      }
      
      private function selectRight(right:GuildRight) : void
      {
         var isChestRight:Boolean = false;
         if(this._guildChestRightGroups.indexOf(right.groupId) != -1 && this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_CHEST_RIGHTS) == -1)
         {
            return;
         }
         if(this._guildGeneralRightGroups.indexOf(right.groupId) != -1 && this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) == -1)
         {
            return;
         }
         var containRightFunc:Function = function(rightGroup:GuildRightGroup, index:int, vector:Vector.<GuildRightGroup>):Boolean
         {
            return rightGroup.id == right.groupId;
         };
         if(this._selectedRank.rights.indexOf(right.id) != -1)
         {
            this._selectedRank.rights.splice(this._selectedRank.rights.indexOf(right.id),1);
            if(this.socialApi.playerGuildRank.rights.indexOf(right.id) != -1)
            {
               --this._currentSelectedRights;
            }
            if(this._guildChestRightGroups.some(containRightFunc))
            {
               this.autoUnselectChestRights(right);
            }
         }
         else
         {
            this._selectedRank.rights.push(right.id);
            if(this.socialApi.playerGuildRank.rights.indexOf(right.id) != -1)
            {
               ++this._currentSelectedRights;
            }
            if(this._guildChestRightGroups.some(containRightFunc))
            {
               this.autoSelectChestRights(right);
            }
         }
         var scrollValue:uint = this.gd_rights.verticalScrollValue;
         this.gd_rights.updateItems();
         this.gd_rights.moveTo(scrollValue,true);
         this.updateSelectAllLabel();
         this.btn_saveRights.softDisabled = !this.hasModification() || this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) == -1;
      }
      
      private function selectAllRights(selectOrUnselect:Boolean) : Boolean
      {
         var rightId:uint = 0;
         var index:int = 0;
         if(!this._selectedRank)
         {
            return false;
         }
         if(!selectOrUnselect)
         {
            for each(rightId in this._availableRightsToManage)
            {
               index = this._selectedRank.rights.indexOf(rightId);
               if(index != -1)
               {
                  if(this.socialApi.playerGuildRank.rights.indexOf(rightId) != -1)
                  {
                     --this._currentSelectedRights;
                  }
                  this._selectedRank.rights.splice(index,1);
               }
            }
         }
         else
         {
            for each(rightId in this._availableRightsToManage)
            {
               if(this._selectedRank.rights.indexOf(rightId) == -1)
               {
                  if(this.socialApi.playerGuildRank.rights.indexOf(rightId) != -1)
                  {
                     ++this._currentSelectedRights;
                  }
                  this._selectedRank.rights.push(rightId);
               }
            }
         }
         return true;
      }
      
      private function autoSelectChestRights(right:GuildRight) : void
      {
         var rightsGroup:GuildRightGroup = GuildRightGroup.getGuildRightGroupById(right.groupId);
         if(rightsGroup)
         {
            rightsGroup.guildRights = this.utilApi.sort(rightsGroup.guildRights,"order",true,true);
         }
         var index:int = rightsGroup.guildRights.indexOf(right);
         if(index == -1)
         {
            return;
         }
         for(var i:int = index; i >= 0; i--)
         {
            if(this._selectedRank.rights.indexOf(rightsGroup.guildRights[i].id) == -1)
            {
               this._selectedRank.rights.push(rightsGroup.guildRights[i].id);
               if(this.socialApi.playerGuildRank.rights.indexOf(rightsGroup.guildRights[i].id) != -1)
               {
                  ++this._currentSelectedRights;
               }
            }
         }
      }
      
      private function autoUnselectChestRights(right:GuildRight) : void
      {
         var rightsGroup:GuildRightGroup = GuildRightGroup.getGuildRightGroupById(right.groupId);
         if(rightsGroup)
         {
            rightsGroup.guildRights = this.utilApi.sort(rightsGroup.guildRights,"order",true,true);
         }
         var index:int = rightsGroup.guildRights.indexOf(right);
         if(index == -1)
         {
            return;
         }
         for(var i:int = index; i < rightsGroup.guildRights.length; i++)
         {
            if(this._selectedRank.rights.indexOf(rightsGroup.guildRights[i].id) != -1)
            {
               this._selectedRank.rights.splice(this._selectedRank.rights.indexOf(rightsGroup.guildRights[i].id),1);
               if(this.socialApi.playerGuildRank.rights.indexOf(rightsGroup.guildRights[i].id) != -1)
               {
                  --this._currentSelectedRights;
               }
            }
         }
      }
      
      private function disableRight(right:GuildRight) : Boolean
      {
         if(this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) == -1)
         {
            return true;
         }
         if(this._selectedRank && this.socialApi.playerGuildRank.order >= this._selectedRank.order)
         {
            return true;
         }
         if(this._selectedRank && (this._selectedRank.order == 0 || this._selectedRank.order == this._maxOrder))
         {
            return true;
         }
         if(this.socialApi.playerGuildRank.rights.indexOf(right.id) == -1)
         {
            return true;
         }
         return false;
      }
      
      private function updateSelectAllLabel() : void
      {
         if(this._currentSelectedRights > 0)
         {
            this._labelSelectAllState = this.SELECTION_STATE_UNSELECTALL;
            this.lbl_selectAll.text = this.uiApi.getText("ui.guild.unselectAllRight");
         }
         else
         {
            this._labelSelectAllState = this.SELECTION_STATE_SELECTALL;
            this.lbl_selectAll.text = this.uiApi.getText("ui.guild.selectAllRight");
         }
         this.lbl_selectAll.softDisabled = this._availableRightsToManage.length == 0;
         this.lbl_selectAll.handCursor = !this.lbl_selectAll.softDisabled;
      }
      
      private function hasModification() : Boolean
      {
         var rightId:uint = 0;
         if(this._prevRights == null || this._selectedRank == null)
         {
            return false;
         }
         if(this._prevRights.length != this._selectedRank.rights.length)
         {
            return true;
         }
         for each(rightId in this._prevRights)
         {
            if(this._selectedRank.rights.indexOf(rightId) == -1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function cancel() : void
      {
         this.hideLineElements();
         this.selectRank(this._selectedRank,false);
      }
      
      private function closeUi() : void
      {
         this._selectedRank.rights = this._prevRights.concat();
         this.uiApi.unloadUi(UIEnum.GUILD_RIGHTS_AND_RANKS);
      }
      
      private function confirmSelectRank() : void
      {
         this._selectedRank.rights = this._prevRights.concat();
         this.gd_rights.moveTo(0,true);
         this.selectRank(this._componentList[this._currentRankRollOver.name].data);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var createFunction:Function = null;
         var success:Boolean = false;
         var data:GuildRankInformation = null;
         var moveFunction:Function = null;
         var removeFuntion:Function = null;
         var editFuntion:Function = null;
         var right:GuildRight = null;
         switch(target)
         {
            case this.btn_close:
               if(this.hasModification())
               {
                  this.modCommon.openTextButtonPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.guild.rightsNotSaved",this._selectedRank.name),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.closeUi,this.cancel],this.closeUi,this.cancel);
               }
               else
               {
                  this.uiApi.unloadUi(UIEnum.GUILD_RIGHTS_AND_RANKS);
               }
               return;
            case this.btn_generalRights:
               if(this._nCurrentTab != this.GUILD_GENERAL_RIGHTS_TAB)
               {
                  this._nCurrentTab = this.GUILD_GENERAL_RIGHTS_TAB;
                  this.displaySelectedTab(this._nCurrentTab);
                  this.currentTabName = target.name;
               }
               break;
            case this.btn_chestRights:
               if(this._nCurrentTab != this.GUILD_CHEST_RIGHTS_TAB)
               {
                  this._nCurrentTab = this.GUILD_CHEST_RIGHTS_TAB;
                  this.displaySelectedTab(this._nCurrentTab);
                  this.currentTabName = target.name;
               }
               break;
            case this.btn_createRank:
               createFunction = function():void
               {
                  _selectedRank.rights = _prevRights.concat();
                  gd_rights.updateItems();
                  if(!uiApi.getUi(UIEnum.GUILD_CREATE_RANK))
                  {
                     uiApi.loadUi(UIEnum.GUILD_CREATE_RANK,UIEnum.GUILD_CREATE_RANK,[]);
                  }
               };
               if(this.hasModification())
               {
                  this.modCommon.openTextButtonPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.guild.rightsNotSaved",this._selectedRank.name),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[createFunction,this.cancel],createFunction,this.cancel);
               }
               else
               {
                  createFunction();
               }
               break;
            case this.btn_saveRights:
               this.sysApi.sendAction(UpdateGuildRightsAction.create(this._selectedRank.id,this._selectedRank.rights));
               break;
            case this.lbl_selectAll:
               success = this.selectAllRights(this._labelSelectAllState == this.SELECTION_STATE_SELECTALL);
               if(!success)
               {
                  return;
               }
               this.gd_rights.updateItems();
               this.btn_saveRights.softDisabled = !this.hasModification() || this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) == -1;
               this.updateSelectAllLabel();
               break;
            default:
               if(target.name.indexOf(this.BTN_LINE_NAME) != -1)
               {
                  if(this._moving && this._currentMovingRank)
                  {
                     if(this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) != -1 && this.socialApi.playerGuildRank.order <= this._componentList[this._currentRankRollOver.name].data.order)
                     {
                        this.switchRanks(this._currentMovingRank,this._componentList[this._currentRankRollOver.name].data);
                     }
                     this.cleanMovingRank();
                     this.showLineElements();
                  }
                  if(this.hasModification())
                  {
                     this.modCommon.openTextButtonPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.guild.rightsNotSaved",this._selectedRank.name),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.confirmSelectRank,this.cancel],this.confirmSelectRank,this.cancel);
                  }
                  else
                  {
                     this.gd_rights.moveTo(0,true);
                     this.selectRank(this._componentList[this._currentRankRollOver.name].data);
                  }
               }
               else if(target.name.indexOf(this.BTN_MOVE_RANK) != -1 || target.name.indexOf(this.CTR_RANK_NAME) != -1)
               {
                  if(target.name.indexOf(this.BTN_MOVE_RANK) != -1)
                  {
                     if(!this._moving)
                     {
                        moveFunction = function startMovingRank():void
                        {
                           _selectedRank.rights = _prevRights.concat();
                           gd_rights.updateItems();
                           _currentMovingRank = _componentList[_currentRankRollOver.name].data;
                           _moving = true;
                           Mouse.cursor = "drag";
                           createBitmap();
                           _firstClick = true;
                           sysApi.addEventListener(onEnterFrame,Event.ENTER_FRAME);
                           StageShareManager.stage.addEventListener(MouseEvent.CLICK,onMouseClick);
                        };
                        if(this.hasModification())
                        {
                           this.modCommon.openTextButtonPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.guild.rightsNotSaved",this._selectedRank.name),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[moveFunction,this.cancel],moveFunction,this.cancel);
                        }
                        else
                        {
                           moveFunction();
                        }
                     }
                     else if(this._moving && this._currentMovingRank)
                     {
                        if(this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) != -1 && this.socialApi.playerGuildRank.order <= this._componentList[this._currentRankRollOver.name].data.order)
                        {
                           this.switchRanks(this._currentMovingRank,this._componentList[this._currentRankRollOver.name].data);
                        }
                        this.cleanMovingRank();
                        this.showLineElements();
                     }
                  }
                  else if(target.name.indexOf(this.CTR_RANK_NAME) != -1)
                  {
                     if(this._moving && this._currentMovingRank)
                     {
                        this.switchRanks(this._currentMovingRank,this._componentList[this._currentRankRollOver.name].data);
                        this.cleanMovingRank();
                        this.showLineElements();
                     }
                  }
               }
               else if(target.name.indexOf(this.BTN_REMOVE_RANK) != -1)
               {
                  if(this.socialApi.playerGuildRank && this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) != -1)
                  {
                     removeFuntion = function():void
                     {
                        _selectedRank.rights = _prevRights.concat();
                        gd_rights.updateItems();
                        data = _componentList[target.name];
                        hideLineElements();
                        removeRank(data);
                     };
                     if(this.hasModification())
                     {
                        this.modCommon.openTextButtonPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.guild.rightsNotSaved",this._selectedRank.name),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[removeFuntion,this.cancel],removeFuntion,this.cancel);
                     }
                     else
                     {
                        removeFuntion();
                     }
                  }
               }
               else if(target.name.indexOf(this.BTN_EDIT_RANK) != -1)
               {
                  if(this.socialApi.playerGuildRank && this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) != -1)
                  {
                     editFuntion = function():void
                     {
                        _selectedRank.rights = _prevRights.concat();
                        gd_rights.updateItems();
                        data = _componentList[target.name];
                        hideLineElements();
                        modifyRank(data);
                     };
                     if(this.hasModification())
                     {
                        this.modCommon.openTextButtonPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.guild.rightsNotSaved",this._selectedRank.name),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[editFuntion,this.cancel],editFuntion,this.cancel);
                     }
                     else
                     {
                        editFuntion();
                     }
                  }
               }
               else if(target.name.indexOf("ctr_category") != -1)
               {
                  this.displayCategories(this._componentList[target.name]);
               }
               else if(target.name.indexOf("lblcb_right") != -1)
               {
                  if(!target.softDisabled && !target.disabled)
                  {
                     right = this._componentList[target.name];
                     this.selectRight(right);
                  }
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = "";
         switch(target)
         {
            case this.btn_createRank:
               if(this.btn_createRank.softDisabled)
               {
                  if(this._guildRanks.length >= this.MAX_GUILD_RANK)
                  {
                     tooltipText = this.uiApi.getText("ui.guild.cantCreateRankMax");
                  }
                  else if(this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) == -1)
                  {
                     tooltipText = this.uiApi.getText("ui.guild.cantCreateRank");
                  }
               }
               break;
            default:
               if(this._currentRankRollOver)
               {
                  this.hideLineElements();
               }
               if(target.name.indexOf(this.BTN_LINE_NAME) != -1)
               {
                  this._currentRankRollOver = target;
                  if(this._moving && this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) != -1 && this.socialApi.playerGuildRank.order > this._componentList[this._currentRankRollOver.name].data.order)
                  {
                     tooltipText = this.uiApi.getText("ui.guild.cantMoveGuildRank");
                  }
               }
               else if(target.name.indexOf(this.BTN_MOVE_RANK) != -1 || target.name.indexOf(this.CTR_RANK_NAME) != -1 || target.name.indexOf(this.BTN_REMOVE_RANK) != -1 || target.name.indexOf(this.BTN_EDIT_RANK) != -1)
               {
                  if(this._moving && this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_RANKS_AND_RIGHTS) != -1 && this.socialApi.playerGuildRank.order > this._componentList[this._currentRankRollOver.name].data.order)
                  {
                     tooltipText = this.uiApi.getText("ui.guild.cantMoveGuildRank");
                  }
                  if(target.name.indexOf(this.BTN_MOVE_RANK) != -1)
                  {
                     if(target.softDisabled)
                     {
                        tooltipText = this.uiApi.getText("ui.guild.moveRankNotAllowed");
                     }
                     else
                     {
                        tooltipText = this.uiApi.getText("ui.guild.moveRank");
                     }
                  }
                  else if(target.name.indexOf(this.BTN_REMOVE_RANK) != -1)
                  {
                     if(target.softDisabled)
                     {
                        tooltipText = this.uiApi.getText("ui.guild.removeRankNotAllowed");
                     }
                     else
                     {
                        tooltipText = this.uiApi.getText("ui.guild.removeRank");
                     }
                  }
                  else if(target.name.indexOf(this.BTN_EDIT_RANK) != -1)
                  {
                     if(target.softDisabled)
                     {
                        tooltipText = this.uiApi.getText("ui.guild.cantModifyRank");
                     }
                     else
                     {
                        tooltipText = this.uiApi.getText("ui.guild.modifyRank");
                     }
                  }
                  if(this._currentRankRollOver)
                  {
                     (this._currentRankRollOver as ButtonContainer).state = !!(this._currentRankRollOver as ButtonContainer).selected ? StatesEnum.STATE_SELECTED_CLICKED : StatesEnum.STATE_OVER;
                  }
               }
               if(this._currentRankRollOver)
               {
                  this.showLineElements();
               }
         }
         if(tooltipText != "")
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
         this.sysApi.setMouseCursor(MouseCursor.AUTO);
         if(this._currentRankRollOver && ((this._currentRankRollOver as ButtonContainer).state != StatesEnum.STATE_SELECTED_CLICKED && (this._currentRankRollOver as ButtonContainer).state != StatesEnum.STATE_SELECTED))
         {
            (this._currentRankRollOver as ButtonContainer).state = StatesEnum.STATE_NORMAL;
            this.hideLineElements();
         }
      }
      
      private function onEnterFrame(e:Event) : void
      {
         this._rankBitmap.x = StageShareManager.stage.mouseX + 20;
         this._rankBitmap.y = StageShareManager.stage.mouseY;
      }
      
      private function onMouseClick(e:MouseEvent) : void
      {
         if(!this._firstClick)
         {
            this.sysApi.removeEventListener(this.onEnterFrame);
            StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
            this.hideLineElements();
            this._currentMovingRank = null;
            this._moving = false;
            this.sysApi.setMouseCursor(MouseCursor.AUTO);
            StageShareManager.stage.removeChild(this._rankBitmap);
            this._rankBitmap = null;
         }
         else
         {
            this._firstClick = false;
         }
      }
      
      private function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case ShortcutHookListEnum.CLOSE_UI:
               if(this.hasModification())
               {
                  this.modCommon.openTextButtonPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.guild.rightsNotSaved",this._selectedRank.name),[this.uiApi.getText("ui.common.ok"),this.uiApi.getText("ui.common.cancel")],[this.closeUi,this.cancel],this.closeUi,this.cancel);
               }
               else
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               return true;
            default:
               return false;
         }
      }
      
      private function onMultiTabStorage(tabs:Vector.<StorageTabInformation>) : void
      {
         var rightGroup:GuildRightGroup = null;
         this._guildChestRightGroups = new Vector.<GuildRightGroup>();
         for(var i:uint = 0; i < this.CHEST_RIGHT_GROUP_IDS.length; i++)
         {
            if(this._inventoryFrame.guildChestTabs.length >= i)
            {
               rightGroup = this.dataApi.getGuildRightGroupById(this.CHEST_RIGHT_GROUP_IDS[i]);
               if(rightGroup)
               {
                  this._guildChestRightGroups.push(rightGroup);
               }
            }
         }
         this._guildChestRightGroups = this.utilApi.sort(this._guildChestRightGroups,"order",true,true);
         if(this._nCurrentTab == this.GUILD_CHEST_RIGHTS_TAB)
         {
            this.displaySelectedTab(this.GUILD_CHEST_RIGHTS_TAB);
         }
      }
   }
}

import com.ankamagames.berilia.components.Texture;
import com.ankamagames.berilia.types.graphic.ButtonContainer;
import com.ankamagames.berilia.types.graphic.GraphicContainer;

class RankComponents
{
    
   
   public var movableContainer:GraphicContainer;
   
   public var hoverTexture:Texture;
   
   public var btnMoveRank:ButtonContainer;
   
   public var btnEditRank:ButtonContainer;
   
   public var btnRemoveRank:ButtonContainer;
   
   function RankComponents()
   {
      super();
   }
}
