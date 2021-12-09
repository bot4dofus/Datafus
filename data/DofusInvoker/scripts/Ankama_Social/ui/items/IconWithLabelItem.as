package Ankama_Social.ui.items
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import flash.display.DisplayObjectContainer;
   
   public class IconWithLabelItem
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var lbl_item:Label;
      
      public var btn_channel:ButtonContainer;
      
      public var tx_item:Texture;
      
      private var _data;
      
      private var _isSelected:Boolean;
      
      private var _parent:DisplayObjectContainer;
      
      public function IconWithLabelItem()
      {
         super();
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function get selected() : Boolean
      {
         return this._isSelected;
      }
      
      public function main(params:Object = null) : void
      {
         this._data = params.data;
         this._isSelected = params.selected;
         this._parent = params.grid.object.parent;
         this.update(this._data,this._isSelected);
      }
      
      public function unload() : void
      {
      }
      
      public function update(data:*, isSelected:Boolean) : void
      {
         this._data = data;
         this._isSelected = isSelected;
         this.btn_channel.width = this._parent.width;
         this.lbl_item.width = this._parent.width - this.lbl_item.x - Number(this.uiApi.me().getConstant("label_margin_right"));
         if(this._data === null)
         {
            return;
         }
         this.tx_item.uri = this._data.icon;
         this.lbl_item.text = this._data.label;
      }
   }
}
