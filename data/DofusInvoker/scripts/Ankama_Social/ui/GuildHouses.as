package Ankama_Social.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildHouseWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.game.common.actions.HouseTeleportRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.utils.Dictionary;
   
   public class GuildHouses
   {
      
      private static var _nCurrentTab:int = -1;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _housesList:Array;
      
      private var _skillsList:Array;
      
      private var _rightsList:Array;
      
      private var _selectedHouse:Object;
      
      private var _bHouseDescendingSort:Boolean = false;
      
      private var _bOwnerDescendingSort:Boolean = false;
      
      private var _bCoordDescendingSort:Boolean = false;
      
      private var _interactiveComponentsList:Dictionary;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_infos:GraphicContainer;
      
      public var grid_house:Grid;
      
      public var btn_tabHouse:ButtonContainer;
      
      public var btn_tabOwner:ButtonContainer;
      
      public var btn_tabCoord:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var btn_close:ButtonContainer;
      
      public var btn_rights:ButtonContainer;
      
      public var btn_skills:ButtonContainer;
      
      public var grid_skill:Grid;
      
      public function GuildHouses()
      {
         this._interactiveComponentsList = new Dictionary(true);
         super();
      }
      
      public function main(... params) : void
      {
         var house:GuildHouseWrapper = null;
         this.btn_tabHouse.soundId = SoundEnum.TAB;
         this.btn_tabOwner.soundId = SoundEnum.TAB;
         this.btn_tabCoord.soundId = SoundEnum.TAB;
         this.btn_rights.soundId = SoundEnum.TAB;
         this.btn_skills.soundId = SoundEnum.TAB;
         this.sysApi.addHook(SocialHookList.GuildHousesUpdate,this.onGuildHousesUpdate);
         this.sysApi.addHook(SocialHookList.GuildHouseAdd,this.onGuildHouseAdd);
         this.sysApi.addHook(SocialHookList.GuildHouseRemoved,this.onGuildHouseRemoved);
         this.sysApi.addHook(HookList.CurrentMap,this.onCurrentMap);
         this.uiApi.addComponentHook(this.grid_house,"onSelectItem");
         this.uiApi.addComponentHook(this.btn_rights,"onRelease");
         this.uiApi.addComponentHook(this.btn_skills,"onRelease");
         this.ctr_infos.visible = false;
         this._skillsList = [];
         this._rightsList = [];
         this._housesList = [];
         for each(house in this.socialApi.getGuildHouses())
         {
            this._housesList.push(house);
         }
         if(_nCurrentTab != -1)
         {
            this.refreshGrid();
         }
      }
      
      public function unload() : void
      {
      }
      
      public function updateSkillLine(data:*, components:*, selected:Boolean) : void
      {
         if(data)
         {
            components.lbl_skill.text = data;
         }
         else
         {
            components.lbl_skill.text = "";
         }
      }
      
      public function updateHouseLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var subarea:SubArea = null;
         if(!this._interactiveComponentsList[componentsRef.btn_info.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_info,"onRelease");
         }
         this._interactiveComponentsList[componentsRef.btn_info.name] = data;
         if(!this._interactiveComponentsList[componentsRef.btn_join.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_join,"onRelease");
         }
         this._interactiveComponentsList[componentsRef.btn_join.name] = data;
         if(data)
         {
            componentsRef.btn_house.disabled = false;
            componentsRef.btn_house.selected = selected;
            componentsRef.lbl_house.text = data.houseName;
            componentsRef.lbl_owner.text = data.ownerName;
            subarea = this.dataApi.getSubArea(data.subareaId);
            componentsRef.lbl_coord.text = this.dataApi.getArea(subarea.areaId).name + " ( " + subarea.name + " ) " + data.worldX + "," + data.worldY;
            componentsRef.btn_house.visible = true;
            componentsRef.btn_info.visible = true;
            componentsRef.btn_join.visible = true;
         }
         else
         {
            componentsRef.btn_house.selected = false;
            componentsRef.lbl_house.text = "";
            componentsRef.lbl_owner.text = "";
            componentsRef.lbl_coord.text = "";
            componentsRef.btn_house.visible = false;
            componentsRef.btn_info.visible = false;
            componentsRef.btn_join.visible = false;
         }
      }
      
      private function onGuildHousesUpdate() : void
      {
         var house:GuildHouseWrapper = null;
         this._housesList = [];
         for each(house in this.socialApi.getGuildHouses())
         {
            this._housesList.push(house);
         }
         this.refreshGrid();
      }
      
      private function onGuildHouseAdd(house:GuildHouseWrapper) : void
      {
         this._housesList.push(house);
         this.refreshGrid();
      }
      
      private function onGuildHouseRemoved(houseId:uint) : void
      {
         this.onGuildHousesUpdate();
      }
      
      private function onHouseSelected(house:Object) : void
      {
         var skill:String = null;
         var right:String = null;
         this._selectedHouse = house;
         this._skillsList = [];
         this._rightsList = [];
         for each(skill in house.skillListString)
         {
            this._skillsList.push(skill);
         }
         for each(right in house.guildshareString)
         {
            this._rightsList.push(right);
         }
         this.lbl_title.text = house.houseName;
         this.updateSelectedTab();
      }
      
      private function onCurrentMap(mapId:Number) : void
      {
         this.uiApi.unloadUi("socialBase");
      }
      
      private function updateSelectedTab() : void
      {
         if(_nCurrentTab == 0)
         {
            this.grid_skill.dataProvider = this._rightsList;
         }
         else if(_nCurrentTab == 1)
         {
            this.grid_skill.dataProvider = this._skillsList;
         }
      }
      
      private function refreshGrid() : void
      {
         this.grid_house.dataProvider = this._housesList;
         if(this._housesList.length == 0)
         {
            this.grid_house.selectedIndex = -1;
         }
         else
         {
            this.grid_house.selectedIndex = 0;
         }
         this.btn_rights.selected = true;
         _nCurrentTab = 0;
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         switch(target)
         {
            case this.btn_close:
               this.ctr_infos.visible = false;
               break;
            case this.btn_tabHouse:
               if(this._housesList.length == 0)
               {
                  return;
               }
               this._bOwnerDescendingSort = false;
               this._bCoordDescendingSort = false;
               if(this._bHouseDescendingSort)
               {
                  this.grid_house.sortOn("houseName",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               else
               {
                  this.grid_house.sortOn("houseName",Array.CASEINSENSITIVE);
               }
               this._bHouseDescendingSort = !this._bHouseDescendingSort;
               break;
            case this.btn_tabOwner:
               if(this._housesList.length == 0)
               {
                  return;
               }
               this._bHouseDescendingSort = false;
               this._bCoordDescendingSort = false;
               if(this._bOwnerDescendingSort)
               {
                  this.grid_house.sortOn("ownerName",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               else
               {
                  this.grid_house.sortOn("ownerName",Array.CASEINSENSITIVE);
               }
               this._bOwnerDescendingSort = !this._bOwnerDescendingSort;
               break;
            case this.btn_tabCoord:
               if(this._housesList.length == 0)
               {
                  return;
               }
               this._bHouseDescendingSort = false;
               this._bOwnerDescendingSort = false;
               if(this._bCoordDescendingSort)
               {
                  this.grid_house.sortOn("worldX",Array.NUMERIC | Array.DESCENDING);
               }
               else
               {
                  this.grid_house.sortOn("worldX",Array.NUMERIC);
               }
               this._bCoordDescendingSort = !this._bCoordDescendingSort;
               break;
            case this.btn_rights:
               _nCurrentTab = 0;
               this.updateSelectedTab();
               break;
            case this.btn_skills:
               _nCurrentTab = 1;
               this.updateSelectedTab();
               break;
            default:
               if(target.name.indexOf("btn_info") != -1)
               {
                  data = this._interactiveComponentsList[target.name];
                  if(data)
                  {
                     this.onHouseSelected(data);
                     this.ctr_infos.visible = true;
                  }
               }
               else if(target.name.indexOf("btn_join") != -1)
               {
                  data = this._interactiveComponentsList[target.name];
                  if(data)
                  {
                     this.sysApi.sendAction(new HouseTeleportRequestAction([data.houseId,data.houseInstanceId]));
                  }
               }
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.grid_house && (target as Grid).selectedIndex > -1)
         {
            this.onHouseSelected(this.grid_house.dataProvider[(target as Grid).selectedIndex]);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}
