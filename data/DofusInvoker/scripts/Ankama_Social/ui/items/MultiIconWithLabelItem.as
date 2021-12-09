package Ankama_Social.ui.items
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.MultipleComboBoxGrid;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   
   public class MultiIconWithLabelItem
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var lbl_item:Label;
      
      public var btn_channel:ButtonContainer;
      
      public var tx_check:Texture;
      
      public var tx_item:Texture;
      
      private var _data;
      
      private var _multiGrid:MultipleComboBoxGrid;
      
      private var _parent:DisplayObjectContainer;
      
      public function MultiIconWithLabelItem()
      {
         super();
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function get selected() : Boolean
      {
         return this._multiGrid !== null && this._multiGrid.hasValue(this._data);
      }
      
      public function main(params:Object = null) : void
      {
         this.uiApi.addComponentHook(this.btn_channel,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_channel,ComponentHookList.ON_ROLL_OUT);
         this._data = params.data;
         this.tx_check.visible = false;
         this._parent = params.grid.object.parent;
         if(params.grid.object is MultipleComboBoxGrid)
         {
            this._multiGrid = params.grid.object as MultipleComboBoxGrid;
         }
         else
         {
            this.tx_check.width = 0;
         }
         this.update(this._data,this.selected);
      }
      
      public function unload() : void
      {
      }
      
      public function update(data:*, isSelected:Boolean) : void
      {
         this.btn_channel.width = this._parent.width;
         this._data = data;
         if(this._data === null)
         {
            return;
         }
         var isValueSelected:Boolean = this.selected;
         this.tx_check.visible = isValueSelected;
         this.btn_channel.state = !!isValueSelected ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL;
         this.lbl_item.text = this._data.label;
         if(this._data.hasOwnProperty("icon") && this._data.icon !== null)
         {
            this.tx_item.addEventListener(Event.COMPLETE,this.onTextureReady);
            this.tx_item.uri = this._data.icon;
         }
         else
         {
            this.tx_item.uri = null;
            this.tx_item.visible = false;
            this.setLabel();
         }
      }
      
      public function select(isSelected:Boolean) : void
      {
      }
      
      public function onTextureReady(event:Event) : void
      {
         if(event.target !== this.tx_item)
         {
            return;
         }
         this.tx_item.removeEventListener(Event.COMPLETE,this.onTextureReady);
         this.setLabel();
      }
      
      private function setLabel() : void
      {
         var anchor:GraphicContainer = !!this.tx_item.visible ? this.tx_item : this.tx_check;
         this.lbl_item.x = anchor.x + anchor.width + Number(this.uiApi.me().getConstant("label_margin_left"));
         this.lbl_item.y = this._parent.height / 2 - this.lbl_item.height / 2;
         this.lbl_item.width = this._parent.width - this.lbl_item.x - Number(this.uiApi.me().getConstant("label_margin_right"));
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         if(target !== this.btn_channel)
         {
            return;
         }
         this.btn_channel.state = !!this.selected ? StatesEnum.STATE_SELECTED_OVER : StatesEnum.STATE_OVER;
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.btn_channel.state = !!this.selected ? StatesEnum.STATE_SELECTED : StatesEnum.STATE_NORMAL;
      }
   }
}
