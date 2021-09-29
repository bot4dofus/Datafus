package Ankama_TradeCenter.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellFilterAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellListRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellFilterAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellListRequestAction;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.utils.Dictionary;
   
   public class EstateAgency
   {
       
      
      public var output:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      private var _currentPage:uint;
      
      private var _maxPage:uint;
      
      private var _estates:Array;
      
      private var _estateType:uint = 2;
      
      private var _housesAreas:Array;
      
      private var _paddocksAreas:Array;
      
      private var _skills:Array;
      
      private var _houseFilters:Array;
      
      private var _paddockFilters:Array;
      
      private var _aAtLeastNbRoom:Array;
      
      private var _aAtLeastNbChest:Array;
      
      private var _aSkillRequested:Array;
      
      private var _aAtLeastNbMount:Array;
      
      private var _aAtLeastNbMachine:Array;
      
      private var _aHousesAreaRequested:Array;
      
      private var _aPaddocksAreaRequested:Array;
      
      public var windowCtr:GraphicContainer;
      
      public var listCtr:Object;
      
      public var filterCtr:Object;
      
      public var typeCtr:GraphicContainer;
      
      public var gd_estates:Object;
      
      public var cb_estateType:ComboBox;
      
      public var cb_filterRoomMount:ComboBox;
      
      public var cb_filterChestMachine:ComboBox;
      
      public var cb_filterSubarea:ComboBox;
      
      public var cb_filterSkill:ComboBox;
      
      public var btn_tabCost:ButtonContainer;
      
      public var btn_prevPage:ButtonContainer;
      
      public var btn_nextPage:ButtonContainer;
      
      public var btn_filter:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var lbl_page:Label;
      
      public var lbl_type:Label;
      
      public var inp_filterMaxPrice:Input;
      
      public var bgcb_estateType:TextureBitmap;
      
      public var bgcb_filterSkill:TextureBitmap;
      
      private var tx_kamasList:Dictionary;
      
      public function EstateAgency()
      {
         this._housesAreas = new Array();
         this._paddocksAreas = new Array();
         this._skills = new Array();
         this._houseFilters = new Array();
         this._paddockFilters = new Array();
         this.tx_kamasList = new Dictionary();
         super();
      }
      
      public function main(args:Object) : void
      {
         this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
         this.sysApi.addHook(RoleplayHookList.EstateToSellList,this.onEstateToSellList);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.uiApi.addComponentHook(this.cb_estateType,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_filterRoomMount,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_filterChestMachine,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_filterSubarea,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_filterSkill,ComponentHookList.ON_SELECT_ITEM);
         this._estateType = args.type;
         this.alignTypeCtr();
         this.inp_filterMaxPrice.restrict = "0-9";
         this.inp_filterMaxPrice.numberMax = ProtocolConstantsEnum.MAX_KAMA;
         var labelsEstate:Array = [this.uiApi.getText("ui.common.housesWord"),this.uiApi.getText("ui.common.mountPark")];
         this.cb_estateType.dataProvider = labelsEstate;
         this.cb_estateType.selectedIndex = this._estateType;
         this.initFilters();
         this.onEstateToSellList(args.list,args.index,args.total,this._estateType);
      }
      
      public function unload() : void
      {
         this.uiApi.unloadUi("estateForm");
         this.sysApi.sendAction(new LeaveDialogRequestAction([]));
         this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_CLOSE);
      }
      
      public function updateEstateLine(data:*, components:*, selected:Boolean) : void
      {
         var tx_kamas:Texture = null;
         if(data)
         {
            components.lbl_name.text = "{estate," + data.index + "::" + data.name + "}";
            components.lbl_loc.text = data.area;
            components.lbl_cost.text = this.utilApi.kamasToString(data.price,"");
            tx_kamas = this.tx_kamasList[components.lbl_cost];
            if(!tx_kamas)
            {
               tx_kamas = this.uiApi.createComponent("Texture") as Texture;
               tx_kamas.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_kama.png");
               tx_kamas.finalize();
               this.tx_kamasList[components.lbl_cost] = tx_kamas;
            }
            tx_kamas.x = components.lbl_cost.x + components.lbl_cost.textWidth + 10;
            tx_kamas.y = components.lbl_cost.y + 4;
            components.estateCtr.addContent(tx_kamas);
         }
         else
         {
            components.lbl_name.text = "";
            components.lbl_loc.text = "";
            components.lbl_cost.text = "";
            if(this.tx_kamasList[components.lbl_cost])
            {
               this.tx_kamasList[components.lbl_cost].removeFromParent();
            }
         }
      }
      
      private function initFilters() : void
      {
         var skill:* = undefined;
         var skillName:* = undefined;
         var area:* = undefined;
         var areaName:* = undefined;
         var areap:* = undefined;
         var areaNamep:* = undefined;
         this._aAtLeastNbRoom = [this.uiApi.getText("ui.estate.filter.atLeastNbRoom"),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom","2"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom","3"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom","4"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbRoom","5"),"m",false)];
         this._aAtLeastNbChest = [this.uiApi.getText("ui.estate.filter.atLeastNbChest"),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest","2"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest","3"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest","4"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbChest","5"),"m",false)];
         this._aSkillRequested = [this.uiApi.getText("ui.estate.filter.skillRequested")];
         for each(skill in this.dataApi.getHouseSkills())
         {
            this._skills.push(skill);
         }
         this._skills.sortOn("name");
         for each(skillName in this._skills)
         {
            this._aSkillRequested.push(skillName.name);
         }
         this._aAtLeastNbMount = [this.uiApi.getText("ui.estate.filter.atLeastNbMount"),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount","5"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount","10"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount","15"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMount","20"),"m",false)];
         this._aAtLeastNbMachine = [this.uiApi.getText("ui.estate.filter.atLeastNbMachine"),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine","5"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine","10"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine","15"),"m",false),this.uiApi.processText(this.uiApi.getText("ui.estate.filter.nbMachine","20"),"m",false)];
         this._aHousesAreaRequested = new Array(this.uiApi.getText("ui.estate.filter.areaRequested"));
         for each(area in this.dataApi.getAllArea(true))
         {
            this._housesAreas.push(area);
         }
         this._housesAreas.sortOn("name");
         for each(areaName in this._housesAreas)
         {
            this._aHousesAreaRequested.push(areaName.name);
         }
         this._aPaddocksAreaRequested = new Array(this.uiApi.getText("ui.estate.filter.areaRequested"));
         for each(areap in this.dataApi.getAllArea(false,true))
         {
            this._paddocksAreas.push(areap);
         }
         this._paddocksAreas.sortOn("name");
         for each(areaNamep in this._paddocksAreas)
         {
            this._aPaddocksAreaRequested.push(areaNamep.name);
         }
         this._houseFilters = [0,0,0,0,0,0];
         this._paddockFilters = [0,0,0,0,0,0];
         this.updateFilters();
      }
      
      private function updateFilters() : void
      {
         if(this._estateType == 0)
         {
            this.cb_filterSubarea.dataProvider = this._aHousesAreaRequested;
            this.cb_filterRoomMount.dataProvider = this._aAtLeastNbRoom;
            this.cb_filterChestMachine.dataProvider = this._aAtLeastNbChest;
            this.cb_filterSkill.dataProvider = this._aSkillRequested;
            this.cb_filterSkill.visible = this.bgcb_filterSkill.visible = true;
            this.cb_filterChestMachine.selectedIndex = this._houseFilters[0];
            this.cb_filterRoomMount.selectedIndex = this._houseFilters[1];
            this.cb_filterSkill.selectedIndex = this._houseFilters[2];
            this.cb_filterSubarea.selectedIndex = this._houseFilters[3];
            this.inp_filterMaxPrice.text = this._houseFilters[4] == 0 ? "" : this._houseFilters[4];
         }
         else if(this._estateType == 1)
         {
            this.cb_filterSubarea.dataProvider = this._aPaddocksAreaRequested;
            this.cb_filterRoomMount.dataProvider = this._aAtLeastNbMount;
            this.cb_filterChestMachine.dataProvider = this._aAtLeastNbMachine;
            this.cb_filterSkill.visible = this.bgcb_filterSkill.visible = false;
            this.cb_filterChestMachine.selectedIndex = this._paddockFilters[0];
            this.cb_filterRoomMount.selectedIndex = this._paddockFilters[1];
            this.cb_filterSubarea.selectedIndex = this._paddockFilters[3];
            this.inp_filterMaxPrice.text = this._paddockFilters[4] == 0 ? "" : this._paddockFilters[4];
         }
      }
      
      private function alignTypeCtr() : void
      {
         this.lbl_type.fullWidthAndHeight();
         this.bgcb_estateType.x = this.lbl_type.x + this.lbl_type.width;
         this.typeCtr.x = this.windowCtr.width / 2 - (this.lbl_type.width + this.bgcb_estateType.width) / 2 - 20;
      }
      
      public function onEstateToSellList(list:Object, pageIndex:uint, totalPage:uint, type:uint = 0) : void
      {
         var estates:Array = new Array();
         for(var i:int = 0; i < list.length; i++)
         {
            estates.push({
               "index":i,
               "name":list[i].name,
               "area":list[i].area,
               "price":list[i].price
            });
         }
         this.gd_estates.dataProvider = estates;
         this._currentPage = pageIndex;
         this._maxPage = Math.max(totalPage,1);
         this.lbl_page.text = pageIndex + "/" + this._maxPage;
         this.btn_prevPage.visible = pageIndex != 1;
         this.btn_nextPage.visible = pageIndex != this._maxPage;
         if(type != this._estateType)
         {
            this._estateType = type;
            this.updateFilters();
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var filter:Array = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_filter:
               this.requestData(1);
               break;
            case this.btn_nextPage:
               if(this._currentPage + 1 <= this._maxPage)
               {
                  if(!this._estateType)
                  {
                     this.sysApi.sendAction(new HouseToSellListRequestAction([++this._currentPage]));
                  }
                  else
                  {
                     this.sysApi.sendAction(new PaddockToSellListRequestAction([++this._currentPage]));
                  }
               }
               break;
            case this.btn_prevPage:
               if(this._currentPage - 1 >= 0)
               {
                  if(!this._estateType)
                  {
                     this.sysApi.sendAction(new HouseToSellListRequestAction([--this._currentPage]));
                  }
                  else
                  {
                     this.sysApi.sendAction(new PaddockToSellListRequestAction([--this._currentPage]));
                  }
               }
               break;
            case this.btn_tabCost:
               filter = !!this._estateType ? this._paddockFilters : this._houseFilters;
               filter[5] = filter[5] == 0 ? 1 : 0;
               this.requestData(this._currentPage);
         }
      }
      
      private function requestData(page:uint) : void
      {
         var area:Object = null;
         var skillId:int = 0;
         var skill:* = undefined;
         var areaId:int = -1;
         if(!this._estateType)
         {
            for each(area in this._housesAreas)
            {
               if(area.name == this.cb_filterSubarea.value)
               {
                  areaId = area.id;
               }
            }
            skillId = 0;
            for each(skill in this._skills)
            {
               if(skill.name == this.cb_filterSkill.value)
               {
                  skillId = skill.id;
               }
            }
            this._houseFilters[0] = this.cb_filterChestMachine.selectedIndex;
            this._houseFilters[1] = this.cb_filterRoomMount.selectedIndex;
            this._houseFilters[2] = this.cb_filterSkill.selectedIndex;
            this._houseFilters[3] = this.cb_filterSubarea.selectedIndex;
            this._houseFilters[4] = 0;
            if(this.inp_filterMaxPrice.text != "")
            {
               this._houseFilters[4] = this.utilApi.stringToKamas(this.inp_filterMaxPrice.text);
            }
            this.sysApi.sendAction(new HouseToSellFilterAction([areaId,this._houseFilters[1] + 1,this._houseFilters[0] + 1,skillId,this._houseFilters[4],this._houseFilters[5]]));
            this.sysApi.sendAction(new HouseToSellListRequestAction([page]));
         }
         else
         {
            for each(area in this._paddocksAreas)
            {
               if(area.name == this.cb_filterSubarea.value)
               {
                  areaId = area.id;
               }
            }
            this._paddockFilters[0] = this.cb_filterChestMachine.selectedIndex;
            this._paddockFilters[1] = this.cb_filterRoomMount.selectedIndex;
            this._paddockFilters[3] = this.cb_filterSubarea.selectedIndex;
            this._paddockFilters[4] = 0;
            if(this.inp_filterMaxPrice.text != "")
            {
               this._paddockFilters[4] = this.utilApi.stringToKamas(this.inp_filterMaxPrice.text);
            }
            this.sysApi.sendAction(new PaddockToSellFilterAction([areaId,this._paddockFilters[1] * 5,this._paddockFilters[0] * 5,this._paddockFilters[4],this._paddockFilters[5]]));
            this.sysApi.sendAction(new PaddockToSellListRequestAction([page]));
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
      }
      
      private function onShortCut(s:String) : Boolean
      {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
      
      public function onSelectItem(target:ComboBox, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod != 7)
         {
            switch(target)
            {
               case this.cb_estateType:
                  if(!this.cb_estateType.selectedIndex)
                  {
                     this.sysApi.sendAction(new HouseToSellListRequestAction([1]));
                  }
                  else
                  {
                     this.sysApi.sendAction(new PaddockToSellListRequestAction([1]));
                  }
                  break;
               case this.cb_filterRoomMount:
                  break;
               case this.cb_filterChestMachine:
                  break;
               case this.cb_filterSubarea:
                  break;
               case this.cb_filterSkill:
            }
         }
      }
   }
}
