package Ankama_Taxi.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.Waypoint;
   import com.ankamagames.dofus.internalDatacenter.taxi.TeleportDestinationWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.TeleportRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ZaapRespawnSaveRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.enums.TeleporterTypeEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   
   public class ZaapSelection
   {
      
      protected static const SORT_SPAWN:String = "spawn";
      
      protected static const SORT_AREA_NAME:String = "areaName";
      
      protected static const SORT_SUB_AREA_NAME:String = "subAreaName";
      
      protected static const SORT_COORD:String = "coord";
      
      protected static const SORT_COST:String = "cost";
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="RoleplayApi")]
      public var rpApi:RoleplayApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      private var INPUT_SEARCH_DEFAULT_TEXT:String;
      
      private var _params:Array;
      
      private var _teleportType:uint;
      
      private var _bDescendingSort:Boolean = false;
      
      protected var _componentsList:Dictionary;
      
      protected var _favoriteZaap:Array;
      
      protected var _fullZaapList:Array;
      
      protected var _tab1List:Array;
      
      protected var _tab2List:Array;
      
      protected var _tab3List:Array;
      
      protected var _currentdataProvider:Array;
      
      protected var _currentSortCriteria:String = "areaName";
      
      protected var _cacheSortCriteriaName:String;
      
      protected var _cacheDescendingSortName:String;
      
      protected var _currentZaap:TeleportDestinationWrapper;
      
      protected var _currentSpawnZaap:TeleportDestinationWrapper;
      
      protected var _uriEmptyStar:Uri;
      
      protected var _uriYellowStar:Uri;
      
      protected var _uriAnomaly:Uri;
      
      private var _currentTabName:String;
      
      private var _lastFavZaap:TeleportDestinationWrapper;
      
      private var _lastKnownZaap:TeleportDestinationWrapper;
      
      protected var _usingZaapi:Boolean = false;
      
      public var lbl_title:Label;
      
      public var lbl_availableKamasNb:Label;
      
      public var tx_availableKamas:Texture;
      
      public var lbl_noDestination:Label;
      
      public var tx_currentRespawn:Texture;
      
      public var gd_zaap:Grid;
      
      public var btn_validate:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_tabSpawn:ButtonContainer;
      
      public var btn_tabSubAreaName:ButtonContainer;
      
      public var btn_tabAreaName:ButtonContainer;
      
      public var btn_tabCoord:ButtonContainer;
      
      public var btn_tabCost:ButtonContainer;
      
      public var btn_resetSearch:ButtonContainer;
      
      public var tx_sortSubAreaDown:Texture;
      
      public var tx_sortSubAreaUp:Texture;
      
      public var tx_sortAreaUp:Texture;
      
      public var tx_sortAreaDown:Texture;
      
      public var tx_sortCoordUp:Texture;
      
      public var tx_sortCoordDown:Texture;
      
      public var tx_sortCostUp:Texture;
      
      public var tx_sortCostDown:Texture;
      
      public var btn_tab1:ButtonContainer;
      
      public var btn_tab2:ButtonContainer;
      
      public var btn_tab3:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var tx_fav:Texture;
      
      public var btn_showUnknowZaap:ButtonContainer;
      
      public var btn_label_btn_showUnknowZaap:Label;
      
      public var lbl_btn_tab1:Label;
      
      public var lbl_btn_tab2:Label;
      
      public var lbl_btn_tab3:Label;
      
      public var lbl_tabSubAreaName:Label;
      
      public var lbl_tabAreaName:Label;
      
      public var lbl_tabCoord:Label;
      
      public var lbl_tabCost:Label;
      
      public var ctr_saveZaap:GraphicContainer;
      
      public var lbl_currentZaapSaved:Label;
      
      public var lbl_changeSavedZaap:Label;
      
      public var btn_save:ButtonContainer;
      
      public var inp_search:Input;
      
      public function ZaapSelection()
      {
         this._componentsList = new Dictionary(false);
         super();
      }
      
      private static function sortArrayByCoord(a:TeleportDestinationWrapper, b:TeleportDestinationWrapper) : Number
      {
         var aCoordY:int = 0;
         var bCoordY:int = 0;
         var aCoordArray:Array = a.coord.split(",");
         var bCoordArray:Array = b.coord.split(",");
         var aCoordX:int = parseInt(aCoordArray[0]);
         var bCoordX:int = parseInt(bCoordArray[0]);
         if(aCoordX > bCoordX)
         {
            return 1;
         }
         if(aCoordX < bCoordX)
         {
            return -1;
         }
         aCoordY = parseInt(aCoordArray[1]);
         bCoordY = parseInt(bCoordArray[1]);
         if(aCoordY > bCoordY)
         {
            return 1;
         }
         if(aCoordY < bCoordY)
         {
            return -1;
         }
         return 0;
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentTabName(value:String) : void
      {
         this._currentTabName = value;
      }
      
      public function main(params:Array) : void
      {
         this._params = params;
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.btn_validate.soundId = UISoundEnum.OK_BUTTON;
         this.btn_close.soundId = UISoundEnum.CANCEL_BUTTON;
         this.btn_tab1.soundId = UISoundEnum.TAB;
         this.btn_tab2.soundId = UISoundEnum.TAB;
         this.btn_tab3.soundId = UISoundEnum.TAB;
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(RoleplayHookList.TeleportDestinationList,this.onTeleportDestinationList);
         this.sysApi.addHook(HookList.LeaveDialog,this.onLeaveDialog);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.sysApi.addHook(HookList.SaveCurrentZaap,this.onSaveCurrentZaap);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addComponentHook(this.gd_zaap,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.tx_fav,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_fav,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_fav,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_save,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_save,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_currentRespawn,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_currentRespawn,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this._cacheSortCriteriaName = this.uiApi.me().name + "_sortCriteria";
         this._cacheDescendingSortName = this.uiApi.me().name + "_descendingSort";
         this._currentSortCriteria = this.sysApi.getSetData(this._cacheSortCriteriaName,SORT_AREA_NAME,DataStoreEnum.BIND_ACCOUNT);
         this._bDescendingSort = this.sysApi.getSetData(this._cacheDescendingSortName,false,DataStoreEnum.BIND_ACCOUNT);
         this._teleportType = params[1];
         if(this._teleportType != TeleporterTypeEnum.TELEPORTER_SUBWAY)
         {
            this.lbl_btn_tab1.text = this.uiApi.getText("ui.zaap.zaap");
            this.lbl_btn_tab2.text = this.uiApi.getText("ui.zaap.prism");
            this.lbl_btn_tab3.text = this.uiApi.getText("ui.zaap.anomaly");
            if(this.btn_tab1.selected)
            {
               this.currentTabName = "zaap";
            }
            else if(this.btn_tab2.selected)
            {
               this.currentTabName = "prism";
            }
            else
            {
               this.currentTabName = "anomaly";
            }
         }
         this.btn_showUnknowZaap.visible = true;
         this.tx_fav.handCursor = true;
         this.btn_showUnknowZaap.selected = this.sysApi.getData("showUnknowZaap");
         this.lbl_availableKamasNb.text = this.utilApi.kamasToString(this.playerApi.characteristics().kamas,"");
         this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.zaap.searchDestination");
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.inp_search.focus();
         this._uriEmptyStar = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "zaap/" + "icon_star_normal.png");
         this._uriYellowStar = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "zaap/" + "icon_star_selected.png");
         this._uriAnomaly = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "zaap/" + "icon_anomaly_grey.png");
         this._favoriteZaap = this.sysApi.getData("favoriteZap");
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      public function updateZaapLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            if(!this._componentsList[componentsRef.btn_zaapCoord.name])
            {
               this.uiApi.addComponentHook(componentsRef.btn_zaapCoord,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(componentsRef.lbl_zaapCoord,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.lbl_zaapCoord,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentsList[componentsRef.btn_zaapCoord.name] = data;
            componentsRef.lbl_zaapSubArea.text = !!this._usingZaapi ? data.areaName : data.subAreaName;
            componentsRef.lbl_zaapArea.text = !!this._usingZaapi ? data.subAreaName : data.areaName;
            componentsRef.lbl_zaapCoord.text = "(" + data.coord + ")";
            componentsRef.btn_savedZaap.visible = false;
            componentsRef.tx_lineSeparator.visible = false;
            if(this.btn_tab3.selected && this._teleportType != TeleporterTypeEnum.TELEPORTER_SUBWAY)
            {
               componentsRef.lbl_zaapCost.text = data.level;
               this.updateAnomalyZaapLine(componentsRef,data.mapId);
            }
            else
            {
               componentsRef.lbl_zaapCost.text = this.utilApi.kamasToString(data.cost,"");
               this.updateZaapZaapLine(componentsRef,data);
            }
            componentsRef.btn_zaapSubArea.disabled = false;
            componentsRef.btn_zaapCoord.disabled = false;
            componentsRef.btn_zaapSubArea.selected = selected;
            componentsRef.btn_zaapCoord.selected = selected;
            componentsRef.btn_favoritZap.selected = selected;
            componentsRef.btn_zaapSubArea.state = !!selected ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL;
            componentsRef.tx_favoritZap.visible = true;
         }
         else
         {
            componentsRef.lbl_zaapSubArea.text = "";
            componentsRef.lbl_zaapArea.text = "";
            componentsRef.lbl_zaapCost.text = "";
            componentsRef.lbl_zaapCoord.text = "";
            componentsRef.btn_zaapSubArea.selected = false;
            componentsRef.btn_zaapSubArea.disabled = true;
            componentsRef.btn_zaapCoord.disabled = true;
            componentsRef.btn_favoritZap.disabled = true;
            componentsRef.tx_favoritZap.visible = false;
            componentsRef.tx_zaapCost.visible = false;
            componentsRef.btn_savedZaap.visible = false;
            componentsRef.tx_lineSeparator.visible = false;
            componentsRef.btn_savedZaap.visible = false;
         }
      }
      
      private function updateZaapZaapLine(componentsRef:*, data:*) : void
      {
         if(!this._componentsList[componentsRef.btn_favoritZap.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_favoritZap,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(componentsRef.btn_favoritZap,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.btn_favoritZap,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.btn_favoritZap.name] = data;
         if(!this._componentsList[componentsRef.btn_savedZaap.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_savedZaap,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.btn_savedZaap,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.btn_savedZaap.name] = data;
         if(this._favoriteZaap && this._favoriteZaap.indexOf(data.mapId) != -1)
         {
            componentsRef.tx_favoritZap.uri = this._uriYellowStar;
         }
         else
         {
            componentsRef.tx_favoritZap.uri = this._uriEmptyStar;
         }
         componentsRef.tx_favoritZap.alpha = 1;
         componentsRef.tx_zaapCost.visible = data.known && data.mapId != this.playerApi.currentMap().mapId;
         componentsRef.btn_favoritZap.visible = data.known;
         componentsRef.btn_favoritZap.disabled = !data.known;
         if(data.known)
         {
            if(data == this._lastFavZaap || data == this._lastKnownZaap && this.btn_showUnknowZaap.selected)
            {
               componentsRef.tx_lineSeparator.visible = true;
            }
            if(data.spawn)
            {
               componentsRef.lbl_zaapSubArea.cssClass = "green";
               componentsRef.lbl_zaapArea.cssClass = "italic";
               if(this.playerApi.characteristics().kamas < data.cost)
               {
                  componentsRef.lbl_zaapCost.cssClass = "redright";
               }
               else
               {
                  componentsRef.lbl_zaapCost.cssClass = "right";
               }
               if(data.mapId == this.playerApi.currentMap().mapId)
               {
                  componentsRef.lbl_zaapCost.text = "";
               }
               componentsRef.btn_savedZaap.visible = true;
               componentsRef.btn_savedZaap.x = componentsRef.lbl_zaapSubArea.x + Math.min(this.uiApi.me().getConstant("lbl_subArea_width"),componentsRef.lbl_zaapSubArea.textWidth) + 10;
               componentsRef.btn_savedZaap.y = 10;
            }
            else if(data.mapId == this.playerApi.currentMap().mapId)
            {
               componentsRef.lbl_zaapSubArea.cssClass = "orangeleft";
               componentsRef.lbl_zaapArea.cssClass = "italic";
               componentsRef.lbl_zaapCoord.cssClass = "greencenter";
               componentsRef.lbl_zaapCost.cssClass = "right";
               componentsRef.lbl_zaapCost.text = "";
            }
            else if(this.playerApi.characteristics().kamas < data.cost)
            {
               componentsRef.lbl_zaapSubArea.cssClass = "disabled";
               componentsRef.lbl_zaapArea.cssClass = "disabled";
               componentsRef.lbl_zaapCoord.cssClass = "disabledcenter";
               componentsRef.lbl_zaapCost.cssClass = "redright";
            }
            else
            {
               componentsRef.lbl_zaapSubArea.cssClass = "bold";
               componentsRef.lbl_zaapArea.cssClass = "italic";
               componentsRef.lbl_zaapCoord.cssClass = "greencenter";
               componentsRef.lbl_zaapCost.cssClass = "right";
            }
         }
         else
         {
            componentsRef.lbl_zaapSubArea.cssClass = "disabled";
            componentsRef.lbl_zaapArea.cssClass = "disabled";
            componentsRef.lbl_zaapCoord.cssClass = "disabledcenter";
            componentsRef.lbl_zaapCost.cssClass = "disabledright";
            componentsRef.lbl_zaapCost.text = "--";
         }
      }
      
      private function updateAnomalyZaapLine(componentsRef:*, mapId:Number) : void
      {
         if(this._componentsList[componentsRef.btn_favoritZap.name])
         {
            this.uiApi.removeComponentHook(componentsRef.btn_favoritZap,ComponentHookList.ON_RELEASE);
            this.uiApi.removeComponentHook(componentsRef.btn_favoritZap,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(componentsRef.btn_favoritZap,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.btn_favoritZap.name] = null;
         componentsRef.tx_favoritZap.uri = this._uriAnomaly;
         componentsRef.tx_zaapCost.visible = false;
         componentsRef.btn_favoritZap.visible = true;
         componentsRef.btn_favoritZap.disabled = false;
         if(mapId == this.playerApi.currentMap().mapId)
         {
            componentsRef.lbl_zaapSubArea.cssClass = "p";
            componentsRef.lbl_zaapArea.cssClass = "p";
            componentsRef.lbl_zaapCoord.cssClass = "greencenter";
            componentsRef.lbl_zaapCost.cssClass = "right";
            componentsRef.tx_favoritZap.alpha = 1;
         }
         else
         {
            componentsRef.lbl_zaapSubArea.cssClass = "disabled";
            componentsRef.lbl_zaapArea.cssClass = "disabled";
            componentsRef.lbl_zaapCoord.cssClass = "disabledcenter";
            componentsRef.lbl_zaapCost.cssClass = "disabledright";
            componentsRef.tx_favoritZap.alpha = 0.5;
         }
      }
      
      private function validateZaapChoice() : void
      {
         var selectedZaap:TeleportDestinationWrapper = this.gd_zaap.selectedItem;
         if(!selectedZaap)
         {
            return;
         }
         if(selectedZaap.destinationType == TeleporterTypeEnum.TELEPORTER_ANOMALY)
         {
            if(selectedZaap.mapId == this.playerApi.currentMap().mapId)
            {
               this.sysApi.sendAction(new TeleportRequestAction([this._teleportType,selectedZaap.destinationType,selectedZaap.subArea.id,selectedZaap.cost]));
            }
            else
            {
               this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.error.inaccessibleAnomaly"),666,this.timeApi.getTimestamp());
            }
         }
         else
         {
            this.sysApi.sendAction(new TeleportRequestAction([this._teleportType,selectedZaap.destinationType,selectedZaap.mapId,selectedZaap.cost]));
         }
      }
      
      private function displaySortArrows() : void
      {
         if(this._usingZaapi)
         {
            this.tx_sortSubAreaDown.visible = this._currentSortCriteria == SORT_AREA_NAME && !this._bDescendingSort;
            this.tx_sortSubAreaUp.visible = this._currentSortCriteria == SORT_AREA_NAME && this._bDescendingSort;
            this.tx_sortAreaDown.visible = this._currentSortCriteria == SORT_SUB_AREA_NAME && !this._bDescendingSort;
            this.tx_sortAreaUp.visible = this._currentSortCriteria == SORT_SUB_AREA_NAME && this._bDescendingSort;
         }
         else
         {
            this.tx_sortSubAreaDown.visible = this._currentSortCriteria == SORT_SUB_AREA_NAME && !this._bDescendingSort;
            this.tx_sortSubAreaUp.visible = this._currentSortCriteria == SORT_SUB_AREA_NAME && this._bDescendingSort;
            this.tx_sortAreaDown.visible = this._currentSortCriteria == SORT_AREA_NAME && !this._bDescendingSort;
            this.tx_sortAreaUp.visible = this._currentSortCriteria == SORT_AREA_NAME && this._bDescendingSort;
         }
         this.tx_sortSubAreaDown.x = this.tx_sortSubAreaUp.x = this.lbl_tabSubAreaName.anchorX + this.uiApi.getTextSize(this.lbl_tabSubAreaName.text,this.lbl_tabSubAreaName.css,this.lbl_tabSubAreaName.cssClass).width + 10;
         this.tx_sortAreaDown.x = this.tx_sortAreaUp.x = this.lbl_tabAreaName.anchorX + this.uiApi.getTextSize(this.lbl_tabAreaName.text,this.lbl_tabAreaName.css,this.lbl_tabAreaName.cssClass).width + 10;
         this.tx_sortCoordDown.visible = this._currentSortCriteria == SORT_COORD && !this._bDescendingSort;
         this.tx_sortCoordUp.visible = this._currentSortCriteria == SORT_COORD && this._bDescendingSort;
         this.tx_sortCoordDown.x = this.tx_sortCoordUp.x = this.lbl_tabCoord.anchorX + this.uiApi.getTextSize(this.lbl_tabCoord.text,this.lbl_tabCoord.css,this.lbl_tabCoord.cssClass).width + 10;
         this.tx_sortCostDown.visible = this._currentSortCriteria == SORT_COST && !this._bDescendingSort;
         this.tx_sortCostUp.visible = this._currentSortCriteria == SORT_COST && this._bDescendingSort;
         this.tx_sortCostDown.x = this.tx_sortCostUp.x = this.lbl_tabCost.anchorX + this.uiApi.getTextSize(this.lbl_tabCost.text,this.lbl_tabCost.css,this.lbl_tabCost.cssClass).width + 10;
      }
      
      private function sortZaapiByAreaNameWithoutAccent(a:TeleportDestinationWrapper, b:TeleportDestinationWrapper) : Number
      {
         var aName:String = this.utilApi.noAccent(a.areaName);
         var bName:String = this.utilApi.noAccent(b.areaName);
         if(aName > bName)
         {
            return 1;
         }
         if(aName < bName)
         {
            return -1;
         }
         return this.sortZaapiBySubAreaNameWithoutAccent(a,b);
      }
      
      private function sortZaapiBySubAreaNameWithoutAccent(a:TeleportDestinationWrapper, b:TeleportDestinationWrapper) : Number
      {
         var aName:String = this.utilApi.noAccent(a.subAreaName);
         var bName:String = this.utilApi.noAccent(b.subAreaName);
         if(aName > bName)
         {
            return 1;
         }
         if(aName < bName)
         {
            return -1;
         }
         return this.sortZaapiByAreaNameWithoutAccent(a,b);
      }
      
      protected function sortZaap(zaapList:*, sortField:String) : Array
      {
         var zaap:TeleportDestinationWrapper = null;
         this._currentSortCriteria = sortField;
         this.sysApi.setData(this._cacheSortCriteriaName,this._currentSortCriteria,DataStoreEnum.BIND_ACCOUNT);
         if(!this._favoriteZaap)
         {
            this._favoriteZaap = [];
         }
         var favArray:Array = [];
         var noFavArray:Array = [];
         var unknowZaapArray:Array = [];
         for each(zaap in zaapList)
         {
            if(zaap.known && (zaapList != this._tab3List || this._teleportType != TeleporterTypeEnum.TELEPORTER_ZAAP) || zaapList == this._tab3List && this._teleportType == TeleporterTypeEnum.TELEPORTER_ZAAP && zaap.mapId == this.playerApi.currentMap().mapId)
            {
               if(this._favoriteZaap.indexOf(zaap.mapId) != -1 && zaap.known)
               {
                  favArray.push(zaap);
               }
               else
               {
                  noFavArray.push(zaap);
               }
            }
            else
            {
               unknowZaapArray.push(zaap);
            }
         }
         if(sortField == SORT_SUB_AREA_NAME)
         {
            if(this._bDescendingSort)
            {
               favArray.sort(this.sortZaapiBySubAreaNameWithoutAccent,Array.DESCENDING);
               noFavArray.sort(this.sortZaapiBySubAreaNameWithoutAccent,Array.DESCENDING);
               if(this.btn_showUnknowZaap.selected)
               {
                  unknowZaapArray.sort(this.sortZaapiBySubAreaNameWithoutAccent,Array.DESCENDING);
               }
            }
            else
            {
               favArray.sort(this.sortZaapiBySubAreaNameWithoutAccent);
               noFavArray.sort(this.sortZaapiBySubAreaNameWithoutAccent);
               if(this.btn_showUnknowZaap.selected)
               {
                  unknowZaapArray.sort(this.sortZaapiBySubAreaNameWithoutAccent);
               }
            }
         }
         else if(sortField == SORT_AREA_NAME)
         {
            if(this._bDescendingSort)
            {
               favArray.sort(this.sortZaapiByAreaNameWithoutAccent,Array.DESCENDING);
               noFavArray.sort(this.sortZaapiByAreaNameWithoutAccent,Array.DESCENDING);
               if(this.btn_showUnknowZaap.selected)
               {
                  unknowZaapArray.sort(this.sortZaapiByAreaNameWithoutAccent,Array.DESCENDING);
               }
            }
            else
            {
               favArray.sort(this.sortZaapiByAreaNameWithoutAccent);
               noFavArray.sort(this.sortZaapiByAreaNameWithoutAccent);
               if(this.btn_showUnknowZaap.selected)
               {
                  unknowZaapArray.sort(this.sortZaapiByAreaNameWithoutAccent);
               }
            }
         }
         else if(sortField == SORT_COORD)
         {
            if(this._bDescendingSort)
            {
               favArray.sort(sortArrayByCoord,Array.DESCENDING);
               noFavArray.sort(sortArrayByCoord,Array.DESCENDING);
               if(this.btn_showUnknowZaap.selected)
               {
                  unknowZaapArray.sort(sortArrayByCoord,Array.DESCENDING);
               }
            }
            else
            {
               favArray.sort(sortArrayByCoord);
               noFavArray.sort(sortArrayByCoord);
               if(this.btn_showUnknowZaap.selected)
               {
                  unknowZaapArray.sort(sortArrayByCoord);
               }
            }
         }
         else if(this._bDescendingSort)
         {
            favArray.sortOn(sortField,Array.NUMERIC | Array.DESCENDING);
            noFavArray.sortOn(sortField,Array.NUMERIC | Array.DESCENDING);
            if(this.btn_showUnknowZaap.selected)
            {
               unknowZaapArray.sortOn(sortField,Array.NUMERIC | Array.DESCENDING);
            }
         }
         else
         {
            favArray.sortOn(sortField,Array.NUMERIC);
            noFavArray.sortOn(sortField,Array.NUMERIC);
            if(this.btn_showUnknowZaap.selected)
            {
               unknowZaapArray.sortOn(sortField,Array.NUMERIC);
            }
         }
         this._lastFavZaap = favArray[favArray.length - 1];
         this._lastKnownZaap = noFavArray[noFavArray.length - 1];
         if(this.btn_showUnknowZaap.selected)
         {
            noFavArray = noFavArray.concat(unknowZaapArray);
         }
         return favArray.concat(noFavArray);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var p:MapPosition = null;
         var flagText:String = null;
         var currentZaap:* = undefined;
         if(target.name.indexOf("btn_zaapCoord") != -1)
         {
            p = this.dataApi.getMapInfo(this._componentsList[target.name].mapId);
            if(this._teleportType == TeleporterTypeEnum.TELEPORTER_ZAAP)
            {
               flagText = this.uiApi.getText("ui.zaap.zaap");
            }
            else if(this._teleportType == TeleporterTypeEnum.TELEPORTER_PRISM)
            {
               flagText = this.uiApi.getText("ui.zaap.prism");
            }
            else if(this._teleportType == TeleporterTypeEnum.TELEPORTER_SUBWAY)
            {
               flagText = this.uiApi.getText("ui.zaap.zaapi");
            }
            flagText += " - " + this._componentsList[target.name].areaName + "(" + this._componentsList[target.name].subAreaName + ")" + " (" + this._componentsList[target.name].coord + ")";
            this.sysApi.dispatchHook(HookList.AddMapFlag,"flag_teleportPoint_" + p.posX + "_" + p.posY,flagText,p.worldMap,p.posX,p.posY,8969710,true);
         }
         else if(target.name.indexOf("btn_favoritZap") != -1)
         {
            this.addRemoveFavoritZaap(this._componentsList[target.name]);
         }
         else
         {
            switch(target)
            {
               case this.btn_tab1:
               case this.btn_tab2:
               case this.btn_tab3:
                  this.changeZaapTab(target as ButtonContainer);
                  break;
               case this.tx_fav:
                  for each(currentZaap in this._fullZaapList)
                  {
                     if(currentZaap.mapId == this._currentZaap.mapId)
                     {
                        this.addRemoveFavoritZaap(currentZaap);
                        break;
                     }
                  }
                  break;
               case this.btn_save:
                  this.sysApi.sendAction(new ZaapRespawnSaveRequestAction([]));
                  break;
               case this.btn_validate:
                  this.validateZaapChoice();
                  break;
               case this.btn_close:
                  this.sysApi.sendAction(new LeaveDialogRequestAction([]));
                  break;
               case this.btn_tabSpawn:
                  if(this._currentSortCriteria == SORT_SPAWN)
                  {
                     this._bDescendingSort = !this._bDescendingSort;
                     this.sysApi.setData(this._cacheDescendingSortName,this._bDescendingSort,DataStoreEnum.BIND_ACCOUNT);
                  }
                  this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,SORT_SPAWN);
                  break;
               case this.btn_tabSubAreaName:
                  if(this._usingZaapi)
                  {
                     if(this._currentSortCriteria == SORT_AREA_NAME)
                     {
                        this._bDescendingSort = !this._bDescendingSort;
                        this.sysApi.setData(this._cacheDescendingSortName,this._bDescendingSort,DataStoreEnum.BIND_ACCOUNT);
                     }
                     this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,SORT_AREA_NAME);
                  }
                  else
                  {
                     if(this._currentSortCriteria == SORT_SUB_AREA_NAME)
                     {
                        this._bDescendingSort = !this._bDescendingSort;
                        this.sysApi.setData(this._cacheDescendingSortName,this._bDescendingSort,DataStoreEnum.BIND_ACCOUNT);
                     }
                     this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,SORT_SUB_AREA_NAME);
                  }
                  this.displaySortArrows();
                  break;
               case this.btn_tabAreaName:
                  if(this._usingZaapi)
                  {
                     if(this._currentSortCriteria == SORT_SUB_AREA_NAME)
                     {
                        this._bDescendingSort = !this._bDescendingSort;
                        this.sysApi.setData(this._cacheDescendingSortName,this._bDescendingSort,DataStoreEnum.BIND_ACCOUNT);
                     }
                     this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,SORT_SUB_AREA_NAME);
                  }
                  else
                  {
                     if(this._currentSortCriteria == SORT_AREA_NAME)
                     {
                        this._bDescendingSort = !this._bDescendingSort;
                        this.sysApi.setData(this._cacheDescendingSortName,this._bDescendingSort,DataStoreEnum.BIND_ACCOUNT);
                     }
                     this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,SORT_AREA_NAME);
                  }
                  this.displaySortArrows();
                  break;
               case this.btn_tabCoord:
                  if(this._currentSortCriteria == SORT_COORD)
                  {
                     this._bDescendingSort = !this._bDescendingSort;
                     this.sysApi.setData(this._cacheDescendingSortName,this._bDescendingSort,DataStoreEnum.BIND_ACCOUNT);
                  }
                  this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,SORT_COORD);
                  this.displaySortArrows();
                  break;
               case this.btn_tabCost:
                  if(this._currentSortCriteria == SORT_COST)
                  {
                     this._bDescendingSort = !this._bDescendingSort;
                     this.sysApi.setData(this._cacheDescendingSortName,this._bDescendingSort,DataStoreEnum.BIND_ACCOUNT);
                  }
                  this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,SORT_COST);
                  this.displaySortArrows();
                  break;
               case this.btn_showUnknowZaap:
                  this.sysApi.setData("showUnknowZaap",this.btn_showUnknowZaap.selected);
                  this.gd_zaap.dataProvider = this.sortZaap(this._currentdataProvider,this._currentSortCriteria);
                  break;
               case this.btn_resetSearch:
                  if(this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
                  {
                     this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
                     this.gd_zaap.dataProvider = this.sortZaap(this._currentdataProvider,this._currentSortCriteria);
                  }
                  break;
               case this.btn_help:
                  this.hintsApi.showSubHints(this.currentTabName);
            }
         }
      }
      
      protected function changeZaapTab(target:ButtonContainer) : void
      {
         var tabList:Array = null;
         if(target == this.btn_tab3)
         {
            this.currentTabName = "anomaly";
            tabList = this._tab3List;
            this.lbl_tabSubAreaName.text = this.uiApi.getText("ui.common.subarea");
            this.lbl_tabAreaName.text = this.uiApi.getText("ui.common.area");
            this.lbl_tabCoord.text = this.uiApi.getText("ui.zaap.associatedZaap");
            this.lbl_tabCost.text = this.uiApi.getText("ui.common.level");
            this.btn_label_btn_showUnknowZaap.text = this.uiApi.getText("ui.zaap.showAllAnomaly");
         }
         else
         {
            if(target == this.btn_tab1)
            {
               this.currentTabName = "zaap";
               tabList = this._tab1List;
            }
            else if(target == this.btn_tab2)
            {
               this.currentTabName = "prism";
               tabList = this._tab2List;
            }
            this.lbl_tabSubAreaName.text = this.uiApi.getText("ui.common.subarea");
            this.lbl_tabAreaName.text = this.uiApi.getText("ui.common.area");
            this.lbl_tabCoord.text = this.uiApi.getText("ui.common.coordinatesSmall");
            this.lbl_tabCost.text = this.uiApi.getText("ui.common.cost");
            this.btn_label_btn_showUnknowZaap.text = this.uiApi.getText("ui.zaap.showUnknowZaap");
         }
         if(this._currentSpawnZaap)
         {
            this.btn_save.visible = false;
            this.ctr_saveZaap.visible = target == this.btn_tab1 && this._teleportType == TeleporterTypeEnum.TELEPORTER_ZAAP;
         }
         else
         {
            this.ctr_saveZaap.visible = false;
            this.btn_save.visible = target == this.btn_tab1 && this._teleportType == TeleporterTypeEnum.TELEPORTER_ZAAP;
         }
         this.tx_currentRespawn.visible = target == this.btn_tab1 && this._teleportType == TeleporterTypeEnum.TELEPORTER_ZAAP;
         this.lbl_availableKamasNb.visible = target != this.btn_tab3;
         this.tx_availableKamas.visible = target != this.btn_tab3;
         this.hintsApi.uiTutoTabLaunch();
         this.gd_zaap.dataProvider = this.sortZaap(tabList,this._currentSortCriteria);
         this._currentdataProvider = tabList;
      }
      
      protected function addRemoveFavoritZaap(favZaap:Object) : void
      {
         var zaap:* = undefined;
         if(!this._favoriteZaap)
         {
            this._favoriteZaap = [];
         }
         if(this._favoriteZaap.indexOf(favZaap.mapId) == -1)
         {
            for each(zaap in this._fullZaapList)
            {
               if(zaap.coord == favZaap.coord && this._favoriteZaap.indexOf(zaap.mapId) == -1)
               {
                  this._favoriteZaap.push(zaap.mapId);
               }
            }
         }
         else
         {
            for each(zaap in this._fullZaapList)
            {
               if(zaap.coord == favZaap.coord)
               {
                  this._favoriteZaap.splice(this._favoriteZaap.indexOf(zaap.mapId),1);
               }
            }
         }
         this.sysApi.setData("favoriteZap",this._favoriteZaap.concat());
         if(this._currentZaap && this._favoriteZaap.indexOf(this._currentZaap.mapId) != -1)
         {
            this.tx_fav.uri = this._uriYellowStar;
         }
         else
         {
            this.tx_fav.uri = this._uriEmptyStar;
         }
         this.gd_zaap.dataProvider = this.sortZaap(this.gd_zaap.dataProvider,this._currentSortCriteria);
      }
      
      public function onUiLoaded(pUiName:String) : void
      {
         if(pUiName == this.uiApi.me().name)
         {
            this.onZaapList(this._params[0]);
            this.displaySortArrows();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var point:int = 7;
         var relativePoint:int = 1;
         var offset:int = 3;
         if(target.name.indexOf("lbl_zaapCoord") != -1)
         {
            text = this.uiApi.getText("ui.tooltip.questMarker");
         }
         else if(target.name.indexOf("btn_favoritZap") != -1)
         {
            if(this._favoriteZaap && this._favoriteZaap.indexOf(this._componentsList[target.name].mapId) != -1)
            {
               text = this.uiApi.getText("ui.zaap.deleteFavoritTooltip");
            }
            else
            {
               text = this.uiApi.getText("ui.zaap.addFavoritTooltip");
            }
         }
         else if(target == this.tx_fav)
         {
            if(this._favoriteZaap && this._currentZaap && this._favoriteZaap.indexOf(this._currentZaap.mapId) != -1)
            {
               text = this.uiApi.getText("ui.zaap.deleteFavoritTooltip");
            }
            else
            {
               text = this.uiApi.getText("ui.zaap.addFavoritTooltip");
            }
         }
         else if(target == this.tx_currentRespawn || target.name.indexOf("btn_savedZaap") != -1)
         {
            text = this.uiApi.getText("ui.zaap.respawn");
         }
         else if(target == this.btn_save)
         {
            if(this._teleportType == TeleporterTypeEnum.TELEPORTER_HAVENBAG || this.playerApi.isInHavenbag())
            {
               text = this.uiApi.getText("ui.zaap.saveInHavenbag");
            }
            else
            {
               text = this.uiApi.getText("ui.zaap.saveAsRespawn");
            }
         }
         else if(target == this.lbl_availableKamasNb)
         {
            text = this.uiApi.getText("ui.storage.ownedKamas");
            point = LocationEnum.POINT_BOTTOMRIGHT;
            relativePoint = LocationEnum.POINT_TOPRIGHT;
            offset = 0;
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",point,relativePoint,offset,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         var filteredDataProvider:Array = null;
         var searchCriteria:String = null;
         var tdv:TeleportDestinationWrapper = null;
         if(this.inp_search.haveFocus && this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
         {
            filteredDataProvider = [];
            searchCriteria = this.utilApi.noAccent(this.inp_search.text).toLowerCase();
            for each(tdv in this._currentdataProvider)
            {
               if(this.utilApi.noAccent(tdv.subAreaName).toLowerCase().indexOf(searchCriteria) != -1 || this.utilApi.noAccent(tdv.areaName).toLowerCase().indexOf(searchCriteria) != -1)
               {
                  filteredDataProvider.push(tdv);
               }
            }
            this.gd_zaap.dataProvider = this.sortZaap(filteredDataProvider,this._currentSortCriteria);
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               this.validateZaapChoice();
               return true;
            case "closeUi":
               this.sysApi.sendAction(new LeaveDialogRequestAction([]));
               return true;
            default:
               return false;
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod == SelectMethodEnum.DOUBLE_CLICK)
         {
            this.validateZaapChoice();
         }
      }
      
      public function onTeleportDestinationList(teleportList:Object, tpType:uint) : void
      {
         var i:* = null;
         var tdp:TeleportDestinationWrapper = null;
         var onCurrentMap:* = false;
         this._tab1List = [];
         this._tab2List = [];
         this._tab3List = [];
         this.tx_currentRespawn.visible = false;
         this.btn_save.softDisabled = false;
         if(teleportList.length != 0)
         {
            for(i in teleportList)
            {
               if(teleportList[i].destinationType == TeleporterTypeEnum.TELEPORTER_ZAAP)
               {
                  this._tab1List.push(teleportList[i]);
               }
               else if(teleportList[i].destinationType == TeleporterTypeEnum.TELEPORTER_PRISM)
               {
                  this._tab2List.push(teleportList[i]);
               }
               else if(teleportList[i].destinationType == TeleporterTypeEnum.TELEPORTER_ANOMALY)
               {
                  this._tab3List.push(teleportList[i]);
               }
               if(teleportList[i].mapId == this.playerApi.currentMap().mapId)
               {
                  this._teleportType = teleportList[i].destinationType;
               }
               if(teleportList[i].spawn)
               {
                  this._currentSpawnZaap = teleportList[i];
               }
            }
            if(this._currentSpawnZaap)
            {
               this.btn_save.visible = false;
               this.ctr_saveZaap.visible = true;
               this.lbl_currentZaapSaved.text = this._currentSpawnZaap.subAreaName;
               if(this._currentZaap)
               {
                  this.lbl_changeSavedZaap.text = " (" + this.uiApi.getText("ui.zaap.changeBy") + " " + this._currentZaap.subAreaName + ")";
                  this.lbl_changeSavedZaap.x = this.lbl_currentZaapSaved.x + this.uiApi.getTextSize(this.lbl_currentZaapSaved.text,this.lbl_currentZaapSaved.css,this.lbl_currentZaapSaved.cssClass).width + 3;
                  this.lbl_changeSavedZaap.width = 380 - this.lbl_changeSavedZaap.x;
               }
               onCurrentMap = this._currentSpawnZaap.mapId != this.playerApi.currentMap().mapId;
               if(onCurrentMap)
               {
                  this.lbl_currentZaapSaved.width = this.uiApi.me().getConstant("lbl_currentZaapSaved_minWidth");
               }
               else
               {
                  this.lbl_currentZaapSaved.width = this.uiApi.me().getConstant("lbl_currentZaapSaved_maxWidth");
               }
               this.lbl_changeSavedZaap.visible = onCurrentMap;
            }
            else
            {
               this.btn_save.visible = true;
               this.ctr_saveZaap.visible = false;
            }
            for each(tdp in this.dataApi.getUnknowZaaps(this._tab1List))
            {
               if(tdp.mapId != this.playerApi.currentMap().mapId)
               {
                  this._tab1List.push(tdp);
               }
            }
            if(this.btn_tab1.selected)
            {
               this.tx_currentRespawn.visible = this._teleportType == TeleporterTypeEnum.TELEPORTER_ZAAP;
               this.gd_zaap.dataProvider = this.sortZaap(this._tab1List,this._currentSortCriteria);
               this._currentdataProvider = this._tab1List;
            }
            else if(this.btn_tab2.selected)
            {
               this.gd_zaap.dataProvider = this.sortZaap(this._tab2List,this._currentSortCriteria);
               this._currentdataProvider = this._tab2List;
            }
            else if(this.btn_tab3.selected)
            {
               this.gd_zaap.dataProvider = this.sortZaap(this._tab3List,this._currentSortCriteria);
               this._currentdataProvider = this._tab3List;
            }
            this.gd_zaap.visible = true;
            this.lbl_noDestination.visible = false;
         }
         else
         {
            this.gd_zaap.visible = false;
            this.lbl_noDestination.visible = true;
            if(this.btn_tab1.selected)
            {
               this.tx_currentRespawn.visible = this._teleportType == TeleporterTypeEnum.TELEPORTER_ZAAP;
               this.btn_save.softDisabled = this.rpApi.getSpawnMap() == this.playerApi.currentMap().mapId;
            }
         }
         if(this._teleportType == TeleporterTypeEnum.TELEPORTER_HAVENBAG || this.playerApi.isInHavenbag())
         {
            this.btn_save.softDisabled = true;
            this.tx_fav.visible = false;
         }
      }
      
      public function onZaapList(zaapList:Object) : void
      {
         var i:* = null;
         var isVestige:Boolean = false;
         var waypoint:Waypoint = null;
         var tdp:TeleportDestinationWrapper = null;
         this._tab1List = [];
         this._tab2List = [];
         this._tab3List = [];
         this._fullZaapList = [];
         this._currentSortCriteria = this.sysApi.getSetData(this._cacheSortCriteriaName,SORT_AREA_NAME,DataStoreEnum.BIND_ACCOUNT);
         this.tx_currentRespawn.visible = false;
         this.btn_save.softDisabled = false;
         this.btn_save.visible = false;
         if(zaapList.length != 0)
         {
            for(i in zaapList)
            {
               this._fullZaapList.push(zaapList[i]);
               if(zaapList[i].destinationType == TeleporterTypeEnum.TELEPORTER_ZAAP)
               {
                  this._tab1List.push(zaapList[i]);
               }
               else if(zaapList[i].destinationType == TeleporterTypeEnum.TELEPORTER_PRISM)
               {
                  this._tab2List.push(zaapList[i]);
               }
               else if(zaapList[i].destinationType == TeleporterTypeEnum.TELEPORTER_ANOMALY)
               {
                  this._tab3List.push(zaapList[i]);
               }
               if(zaapList[i].mapId == this.playerApi.currentMap().mapId && zaapList[i].destinationType != TeleporterTypeEnum.TELEPORTER_ANOMALY)
               {
                  this._teleportType = zaapList[i].destinationType;
                  this._currentZaap = zaapList[i];
               }
               if(zaapList[i].spawn)
               {
                  this._currentSpawnZaap = zaapList[i];
               }
            }
            if(this._currentSpawnZaap)
            {
               this.btn_save.visible = false;
               this.ctr_saveZaap.visible = true;
               this.lbl_currentZaapSaved.text = this._currentSpawnZaap.subAreaName;
               if(this._currentZaap)
               {
                  this.lbl_changeSavedZaap.text = " (" + this.uiApi.getText("ui.zaap.changeBy") + " " + this._currentZaap.subAreaName + ")";
                  this.lbl_changeSavedZaap.x = this.lbl_currentZaapSaved.x + this.uiApi.getTextSize(this.lbl_currentZaapSaved.text,this.lbl_currentZaapSaved.css,this.lbl_currentZaapSaved.cssClass).width + 3;
                  this.lbl_changeSavedZaap.width = 380 - this.lbl_changeSavedZaap.x;
               }
               this.lbl_changeSavedZaap.visible = this._currentSpawnZaap.mapId != this.playerApi.currentMap().mapId;
            }
            else
            {
               this.btn_save.visible = true;
               this.ctr_saveZaap.visible = false;
            }
            isVestige = false;
            for each(waypoint in this.dataApi.getAllWaypoints())
            {
               if(waypoint.activated == false && this.playerApi.currentMap().mapId == waypoint.mapId)
               {
                  this.lbl_title.text = this.uiApi.getText("ui.zaap.zaap") + " - " + this.playerApi.currentSubArea().name;
                  this.tx_fav.visible = false;
                  this.btn_tab1.visible = false;
                  this.btn_tab2.visible = false;
                  this.btn_tab3.disabled = false;
                  this.btn_tab3.x = this.btn_tab1.x;
                  this.uiApi.me().render();
                  isVestige = true;
                  break;
               }
            }
            if(!isVestige)
            {
               if(this._favoriteZaap && this._currentZaap && this._favoriteZaap.indexOf(this._currentZaap.mapId) != -1)
               {
                  this.tx_fav.uri = this._uriYellowStar;
               }
               else
               {
                  this.tx_fav.uri = this._uriEmptyStar;
               }
               for each(tdp in this.dataApi.getUnknowZaaps(this._tab1List))
               {
                  if(tdp.mapId != this.playerApi.currentMap().mapId)
                  {
                     this._tab1List.push(tdp);
                  }
               }
               this.btn_tab1.disabled = false;
               this.btn_tab2.disabled = this._tab2List.length == 0;
               this.btn_tab3.disabled = this._tab3List.length == 0;
               if(this._teleportType == TeleporterTypeEnum.TELEPORTER_ZAAP)
               {
                  this.lbl_title.text = this.uiApi.getText("ui.zaap.zaap") + " - " + this.playerApi.currentSubArea().name;
                  this.ctr_saveZaap.visible = this._currentSpawnZaap != null;
                  this.btn_save.visible = this._currentSpawnZaap == null;
               }
               else if(this._teleportType == TeleporterTypeEnum.TELEPORTER_PRISM)
               {
                  this.lbl_title.text = this.uiApi.getText("ui.zaap.prism") + " - " + this.playerApi.currentSubArea().name;
                  this.ctr_saveZaap.visible = this._currentSpawnZaap != null;
                  this.btn_save.visible = this._currentSpawnZaap == null;
               }
            }
            if(!this.btn_tab1.disabled && this.btn_tab1.visible && (this._teleportType != TeleporterTypeEnum.TELEPORTER_PRISM || this.btn_tab2.disabled))
            {
               this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_tab1,this.uiApi.me());
               this.btn_tab1.selected = true;
               this.changeZaapTab(this.btn_tab1);
            }
            else if(!this.btn_tab2.disabled && this.btn_tab2.visible)
            {
               this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_tab2,this.uiApi.me());
               this.btn_tab2.selected = true;
               this.changeZaapTab(this.btn_tab2);
            }
            else if(!this.btn_tab3.disabled && this.btn_tab3.visible)
            {
               this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_tab3,this.uiApi.me());
               this.btn_tab3.selected = true;
               this.changeZaapTab(this.btn_tab3);
            }
            this.gd_zaap.visible = true;
            this.lbl_noDestination.visible = false;
         }
         else
         {
            this.gd_zaap.visible = false;
            this.lbl_noDestination.visible = true;
            if(this.btn_tab1.selected)
            {
               this.tx_currentRespawn.visible = this._teleportType == TeleporterTypeEnum.TELEPORTER_ZAAP;
               this.btn_save.softDisabled = this.rpApi.getSpawnMap() == this.playerApi.currentMap().mapId;
            }
         }
         if(this._teleportType == TeleporterTypeEnum.TELEPORTER_HAVENBAG || this.playerApi.isInHavenbag())
         {
            this.btn_save.softDisabled = true;
            this.ctr_saveZaap.visible = false;
            this.tx_fav.visible = false;
            this.btn_tab3.visible = false;
         }
      }
      
      public function onSaveCurrentZaap() : void
      {
         this.sysApi.sendAction(new ZaapRespawnSaveRequestAction([]));
      }
      
      public function onLeaveDialog() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
