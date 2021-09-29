package Ankama_House.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class HavenbagFurnituresTypes
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      public var gd_categories:Grid;
      
      public function HavenbagFurnituresTypes()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         var categories:Array = [];
         categories.push({
            "text":this.uiApi.getText("ui.havenbag.layer.floors"),
            "uri":this.uiApi.me().getConstant("illus") + "havenbag_floor.png"
         });
         categories.push({
            "text":this.uiApi.getText("ui.havenbag.layer.supports"),
            "uri":this.uiApi.me().getConstant("illus") + "havenbag_furnitur.png"
         });
         categories.push({
            "text":this.uiApi.getText("ui.havenbag.layer.objects"),
            "uri":this.uiApi.me().getConstant("illus") + "havenbag_item.png"
         });
         this.gd_categories.dataProvider = categories;
      }
      
      public function updateCategory(data:*, componentsRef:*, selected:Boolean) : void
      {
         this.uiApi.addComponentHook(componentsRef.tx_category,ComponentHookList.ON_TEXTURE_READY);
         componentsRef.tx_category.dispatchMessages = true;
         componentsRef.tx_category.uri = this.uiApi.createUri(data.uri);
         if(componentsRef.btn_slot.state == StatesEnum.STATE_NORMAL && selected)
         {
            componentsRef.btn_slot.selected = true;
         }
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         var maxWidth:int = parseInt(this.uiApi.me().getConstant("categoryIconWidth"));
         if(target.width > maxWidth)
         {
            target.height = maxWidth / (target.width / target.height);
            target.width = maxWidth;
         }
         target.x = target.width + (this.gd_categories.slotWidth / 2 - target.width / 2);
         target.y = this.gd_categories.slotHeight / 2 - target.height / 2;
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         this.uiApi.getUi("havenbagManager").uiClass.selectFurnitureType(this.gd_categories.selectedIndex);
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(item.data.text),item.container,false,"standard",LocationEnum.POINT_LEFT,LocationEnum.POINT_RIGHT);
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}
