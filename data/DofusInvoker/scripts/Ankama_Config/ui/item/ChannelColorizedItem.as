package Ankama_Config.ui.item
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.geom.ColorTransform;
   
   public class ChannelColorizedItem
   {
       
      
      public var output:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      private var _data;
      
      private var _selected:Boolean;
      
      public var tx_color:Texture;
      
      public var lbl_colorChannel:Label;
      
      public function ChannelColorizedItem()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this._data = oParam.data;
         this._selected = oParam.selected;
         this.update(this._data,this._selected);
      }
      
      public function unload() : void
      {
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function update(data:*, selected:Boolean) : void
      {
         var color:uint = 0;
         var t:ColorTransform = null;
         this._data = data;
         if(data)
         {
            color = this.configApi.getConfigProperty("chat","channelColor" + data.id);
            t = new ColorTransform();
            t.color = color;
            this.tx_color.transform.colorTransform = t;
            this.lbl_colorChannel.text = data.name;
         }
      }
      
      public function select(selected:Boolean) : void
      {
      }
   }
}
