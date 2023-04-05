package com.ankamagames.dofus.internalDatacenter.tutorial
{
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SubhintWrapper implements IDataCenter
   {
       
      
      private var _hint_id:int = -1;
      
      private var _hint_parent_uid:String = "";
      
      private var _hint_creation_date:Number = -1;
      
      private var _hint_order:uint = 1;
      
      private var _hint_anchored_element:String = "";
      
      private var _hint_anchor:uint = 0;
      
      private var _hint_position_x:int = 0;
      
      private var _hint_position_y:int = 0;
      
      private var _hint_highlighted_element:String = "";
      
      private var _hint_width:uint = 20;
      
      private var _hint_height:uint = 20;
      
      private var _hint_tooltip_guided:Boolean = true;
      
      private var _hint_tooltip_width:uint = 300;
      
      private var _hint_tooltip_position_enum:uint = 0;
      
      private var _hint_tooltip_offset_x:int = 0;
      
      private var _hint_tooltip_offset_y:int = 0;
      
      private var _hint_tooltip_text:String = "";
      
      private var _hint_tooltip_url:String = "";
      
      public function SubhintWrapper()
      {
         super();
      }
      
      public static function create(data:Object) : SubhintWrapper
      {
         var subhintWrapper:SubhintWrapper = new SubhintWrapper();
         subhintWrapper._hint_id = data.hint_id;
         subhintWrapper._hint_parent_uid = data.hint_parent_uid;
         subhintWrapper._hint_creation_date = data.hint_creation_date;
         subhintWrapper._hint_order = data.hint_order;
         subhintWrapper._hint_anchored_element = data.hint_anchored_element;
         subhintWrapper._hint_anchor = data.hint_anchor;
         subhintWrapper._hint_position_x = data.hint_position_x;
         subhintWrapper._hint_position_y = data.hint_position_y;
         subhintWrapper._hint_highlighted_element = data.hint_highlighted_element;
         subhintWrapper._hint_width = data.hint_width;
         subhintWrapper._hint_height = data.hint_height;
         subhintWrapper._hint_tooltip_guided = true;
         subhintWrapper._hint_tooltip_width = data.hint_tooltip_width;
         subhintWrapper._hint_tooltip_position_enum = data.hint_tooltip_position_enum;
         subhintWrapper._hint_tooltip_offset_x = data.hint_tooltip_offset_x;
         subhintWrapper._hint_tooltip_offset_y = data.hint_tooltip_offset_y;
         if(BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
         {
            subhintWrapper._hint_tooltip_text = data.text;
         }
         else
         {
            subhintWrapper._hint_tooltip_text = data.hint_tooltip_text;
         }
         if(data.hint_tooltip_url && data.hint_tooltip_url != "no_url")
         {
            subhintWrapper._hint_tooltip_url = data.hint_tooltip_url;
         }
         return subhintWrapper;
      }
      
      public function get hint_id() : int
      {
         return this._hint_id;
      }
      
      public function get hint_parent_uid() : String
      {
         return this._hint_parent_uid;
      }
      
      public function get hint_creation_date() : Number
      {
         return this._hint_creation_date;
      }
      
      public function get hint_order() : uint
      {
         return this._hint_order;
      }
      
      public function get hint_anchored_element() : String
      {
         return this._hint_anchored_element;
      }
      
      public function get hint_anchor() : uint
      {
         return this._hint_anchor;
      }
      
      public function get hint_position_x() : int
      {
         return this._hint_position_x;
      }
      
      public function get hint_position_y() : int
      {
         return this._hint_position_y;
      }
      
      public function get hint_highlighted_element() : String
      {
         return this._hint_highlighted_element;
      }
      
      public function get hint_width() : uint
      {
         return this._hint_width;
      }
      
      public function get hint_height() : uint
      {
         return this._hint_height;
      }
      
      public function get hint_tooltip_guided() : Boolean
      {
         return this._hint_tooltip_guided;
      }
      
      public function get hint_tooltip_width() : uint
      {
         return this._hint_tooltip_width;
      }
      
      public function get hint_tooltip_position_enum() : uint
      {
         return this._hint_tooltip_position_enum;
      }
      
      public function get hint_tooltip_offset_x() : int
      {
         return this._hint_tooltip_offset_x;
      }
      
      public function get hint_tooltip_offset_y() : int
      {
         return this._hint_tooltip_offset_y;
      }
      
      public function get hint_tooltip_text() : String
      {
         return this._hint_tooltip_text;
      }
      
      public function get hint_tooltip_url() : String
      {
         return this._hint_tooltip_url;
      }
      
      public function set hint_order(value:uint) : void
      {
         this._hint_order = value;
      }
      
      public function set hint_tooltip_guided(value:Boolean) : void
      {
         this._hint_tooltip_guided = value;
      }
      
      public function clone() : SubhintWrapper
      {
         var wrapper:SubhintWrapper = new SubhintWrapper();
         wrapper._hint_id = this.hint_id;
         wrapper._hint_parent_uid = this.hint_parent_uid;
         wrapper._hint_creation_date = this.hint_creation_date;
         wrapper._hint_order = this.hint_order;
         wrapper._hint_anchored_element = this.hint_anchored_element;
         wrapper._hint_anchor = this.hint_anchor;
         wrapper._hint_position_x = this.hint_position_x;
         wrapper._hint_position_y = this.hint_position_y;
         wrapper._hint_highlighted_element = this.hint_highlighted_element;
         wrapper._hint_width = this.hint_width;
         wrapper._hint_height = this.hint_height;
         wrapper._hint_tooltip_guided = this.hint_tooltip_guided;
         wrapper._hint_tooltip_width = this.hint_tooltip_width;
         wrapper._hint_tooltip_position_enum = this.hint_tooltip_position_enum;
         wrapper._hint_tooltip_offset_x = this.hint_tooltip_offset_x;
         wrapper._hint_tooltip_offset_y = this.hint_tooltip_offset_y;
         wrapper._hint_tooltip_text = this.hint_tooltip_text;
         wrapper._hint_tooltip_url = this.hint_tooltip_url;
         return wrapper;
      }
      
      public function update(data:Object) : void
      {
         this._hint_id = data.hint_id;
         this._hint_parent_uid = data.hint_parent_uid;
         this._hint_creation_date = data.hint_creation_date;
         this._hint_order = data.hint_order;
         this._hint_anchored_element = data.hint_anchored_element;
         this._hint_anchor = data.hint_anchor;
         this._hint_position_x = data.hint_position_x;
         this._hint_position_y = data.hint_position_y;
         this._hint_highlighted_element = data.hint_highlighted_element;
         this._hint_width = data.hint_width;
         this._hint_height = data.hint_height;
         this._hint_tooltip_guided = data.hint_tooltip_guided;
         this._hint_tooltip_width = data.hint_tooltip_width;
         this._hint_tooltip_position_enum = data.hint_tooltip_position_enum;
         this._hint_tooltip_offset_x = data.hint_tooltip_offset_x;
         this._hint_tooltip_offset_y = data.hint_tooltip_offset_y;
         if(BuildInfos.BUILD_TYPE < BuildTypeEnum.INTERNAL)
         {
            this._hint_tooltip_text = I18n.getText(data.hint_tooltip_text);
         }
         else
         {
            this._hint_tooltip_text = data.hint_tooltip_text;
         }
         this._hint_tooltip_url = data.hint_tooltip_url;
      }
      
      public function toObject() : Object
      {
         var obj:Object = new Object();
         obj.hint_id = this._hint_id;
         obj.hint_parent_uid = this._hint_parent_uid;
         obj.hint_creation_date = this._hint_creation_date;
         obj.hint_order = this._hint_order;
         obj.hint_anchored_element = this._hint_anchored_element;
         obj.hint_anchor = this._hint_anchor;
         obj.hint_position_x = this._hint_position_x;
         obj.hint_position_y = this._hint_position_y;
         obj.hint_highlighted_element = this._hint_highlighted_element;
         obj.hint_width = this._hint_width;
         obj.hint_height = this._hint_height;
         obj.hint_tooltip_guided = this._hint_tooltip_guided;
         obj.hint_tooltip_width = this._hint_tooltip_width;
         obj.hint_tooltip_position_enum = this._hint_tooltip_position_enum;
         obj.hint_tooltip_offset_x = this._hint_tooltip_offset_x;
         obj.hint_tooltip_offset_y = this._hint_tooltip_offset_y;
         obj.hint_tooltip_text = this._hint_tooltip_text;
         obj.hint_tooltip_url = this._hint_tooltip_url;
         return obj;
      }
   }
}
