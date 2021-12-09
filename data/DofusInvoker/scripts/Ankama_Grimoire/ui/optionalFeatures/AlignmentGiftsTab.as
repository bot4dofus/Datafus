package Ankama_Grimoire.ui.optionalFeatures
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Grimoire.enum.EnumTab;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.characteristics.Characteristic;
   import com.ankamagames.dofus.datacenter.characteristics.CharacteristicCategory;
   import com.ankamagames.dofus.internalDatacenter.stats.DetailedStat;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class AlignmentGiftsTab
   {
      
      private static const CTR_CAT_TYPE_CAT:String = "ctr_cat";
      
      private static const CTR_CAT_TYPE_ITEM:String = "ctr_caracAdvancedItem";
      
      private static const CTR_CAT_TYPE_MESS:String = "ctr_message";
       
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var dataApi:DataApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _aGiftsList:Object;
      
      private var _componentList:Dictionary;
      
      private var _dataMatrix:Array;
      
      private var _characteristicsCategoriesData:Object;
      
      private var _textTooltipHelp:String;
      
      private var _textEmptyData:String;
      
      public var alignmentGiftsTab:GraphicContainer;
      
      private var _alignmentTab:GraphicContainer;
      
      public var gd_caracAdvanced:Grid;
      
      public var btn_help:ButtonContainer;
      
      public function AlignmentGiftsTab()
      {
         this._componentList = new Dictionary(true);
         super();
      }
      
      public function main(params:Object) : void
      {
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(BeriliaHookList.WindowResize,this.onWindowResize);
         this.uiApi.removeComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_ROLL_OUT);
         this.btn_help.handCursor = false;
         this.uiApi.addComponentHook(this.alignmentGiftsTab,ComponentHookList.ON_DOUBLE_CLICK);
         this._characteristicsCategoriesData = this.dataApi.getCharacteristicCategories();
         this._dataMatrix = [];
         this._textTooltipHelp = this.uiApi.getText("ui.temporis.alignmentGiftTooltip");
         this._textEmptyData = this.uiApi.getText("ui.temporis.alignmentGiftEmpty");
         this.dataInit();
      }
      
      public function onUiLoaded(pUiName:String) : void
      {
         if(pUiName == this.uiApi.me().name)
         {
            this.btn_help.visible = true;
            this.uiApi.me().setOnTop();
            this.stickToAlignmentTab();
         }
      }
      
      public function onWindowResize(width:uint, height:uint, scale:Number) : void
      {
         this.stickToAlignmentTab();
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         if(target == this.alignmentGiftsTab)
         {
            this.stickToAlignmentTab();
         }
      }
      
      private function stickToAlignmentTab() : void
      {
         var rectangleAlign:Rectangle = null;
         this._alignmentTab = this.uiApi.getUi(EnumTab.ALIGNMENT_TAB);
         if(this._alignmentTab)
         {
            rectangleAlign = this._alignmentTab.getStageRect();
            this.alignmentGiftsTab.x = rectangleAlign.x + rectangleAlign.width - 10;
            this.alignmentGiftsTab.y = rectangleAlign.y + rectangleAlign.height / 2 + 5;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_help:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this._textTooltipHelp),this.btn_help,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function updateCaracLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var total:int = 0;
         if(data)
         {
            this._componentList[componentsRef.lbl_nameCarac.name] = data;
            this._componentList[componentsRef.lbl_valueCarac.name] = data;
            if(data.gfxId != "null")
            {
               componentsRef.tx_pictoCarac.visible = true;
               componentsRef.tx_pictoCarac.uri = this.uiApi.createUri(this.uiApi.me().getConstant("characteristics") + data.gfxId + ".png");
            }
            else
            {
               componentsRef.tx_pictoCarac.uri = null;
            }
            componentsRef.tx_gridSeparator.visible = true;
            componentsRef.lbl_nameCarac.text = data.text;
            total = data.bonus;
            componentsRef.lbl_valueCarac.text = total != 0 ? total : "-";
         }
         else
         {
            componentsRef.lbl_valueCarac.text = "";
            componentsRef.lbl_nameCarac.text = "";
            componentsRef.btn_plus.visible = false;
            componentsRef.tx_pictoCarac.visible = false;
            componentsRef.tx_gridSeparator.visible = false;
         }
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         var bonus:int = 0;
         switch(this.getCatLineType(data,line))
         {
            case CTR_CAT_TYPE_CAT:
               componentsRef.lbl_catName.text = data.name;
               componentsRef.btn_cat.handCursor = false;
               break;
            case CTR_CAT_TYPE_ITEM:
               this._componentList[componentsRef.lbl_name.name] = data;
               this._componentList[componentsRef.lbl_value.name] = data;
               if(data.gfxId && data.gfxId != "null")
               {
                  componentsRef.tx_picto.visible = true;
                  componentsRef.tx_picto.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto") + data.gfxId);
               }
               else
               {
                  componentsRef.tx_picto.uri = null;
               }
               if(data.cat && data.cat == -1 && data.numId && data.numId == -1)
               {
                  componentsRef.lbl_name.visible = false;
                  componentsRef.lbl_value.visible = false;
                  componentsRef.tx_picto.visible = false;
               }
               else
               {
                  componentsRef.lbl_name.visible = true;
                  componentsRef.lbl_value.visible = true;
                  componentsRef.tx_picto.visible = true;
               }
               componentsRef.lbl_name.text = data.text;
               bonus = data.bonus;
               componentsRef.lbl_value.text = bonus && bonus != 0 ? "+" + bonus : "";
               break;
            case CTR_CAT_TYPE_MESS:
               componentsRef.lbl_message.text = data;
         }
      }
      
      public function getCatLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data is String)
         {
            return CTR_CAT_TYPE_MESS;
         }
         if(data.isCat)
         {
            return CTR_CAT_TYPE_CAT;
         }
         return CTR_CAT_TYPE_ITEM;
      }
      
      public function getCatDataLength(data:*, selected:Boolean) : *
      {
         return 10;
      }
      
      private function dataInit() : void
      {
         var showCategory:Boolean = false;
         var baseCharac:Characteristic = null;
         var carac:Stat = null;
         var detailedCarac:DetailedStat = null;
         var cat:CharacteristicCategory = null;
         var cId:int = 0;
         var characterCharacteristics:CharacterCharacteristicsInformations = this.playerApi.characteristics();
         var stats:EntityStats = StatsManager.getInstance().getStats(this.playerApi.id());
         for each(cat in this._characteristicsCategoriesData)
         {
            showCategory = false;
            for each(cId in cat.characteristicIds)
            {
               baseCharac = this.dataApi.getCharacteristic(cId);
               carac = stats.getStat(cId);
               if(carac is DetailedStat)
               {
                  detailedCarac = carac as DetailedStat;
               }
               else
               {
                  detailedCarac = null;
               }
               if(baseCharac && detailedCarac && detailedCarac.alignGiftBonusValue && detailedCarac.alignGiftBonusValue > 0)
               {
                  if(!showCategory)
                  {
                     this._dataMatrix.push({
                        "name":cat.name,
                        "id":cat.id,
                        "isCat":true,
                        "isVisible":true
                     });
                     showCategory = true;
                  }
                  this._dataMatrix.push({
                     "cId":cId,
                     "id":baseCharac.keyword,
                     "text":baseCharac.name,
                     "gfxId":baseCharac.asset,
                     "numId":baseCharac.id,
                     "cat":baseCharac.categoryId,
                     "bonus":detailedCarac.alignGiftBonusValue
                  });
               }
            }
         }
         if(this._dataMatrix.length == 0)
         {
            this._dataMatrix.push(this._textEmptyData);
         }
         this.gd_caracAdvanced.dataProvider = this._dataMatrix;
      }
   }
}
