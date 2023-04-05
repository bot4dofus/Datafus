package com.ankamagames.dofus.datacenter.misc
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class Subhint implements IDataCenter
   {
      
      public static const MODULE:String = "Subhints";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Subhint));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSubhintById,getSubhints);
       
      
      public var hint_id:int;
      
      public var hint_parent_uid:String;
      
      public var hint_anchored_element:String;
      
      public var hint_anchor:int;
      
      public var hint_position_x:int;
      
      public var hint_position_y:int;
      
      public var hint_width:int;
      
      public var hint_height:int;
      
      public var hint_highlighted_element:String;
      
      public var hint_order:int;
      
      public var hint_tooltip_text:uint;
      
      public var hint_tooltip_position_enum:int;
      
      public var hint_tooltip_url:String;
      
      public var hint_tooltip_offset_x:int;
      
      public var hint_tooltip_offset_y:int;
      
      public var hint_tooltip_width:int;
      
      public var hint_creation_date:Number;
      
      private var _text:String;
      
      public function Subhint()
      {
         super();
      }
      
      public static function getSubhintById(id:int) : Subhint
      {
         return GameData.getObject(MODULE,id) as Subhint;
      }
      
      public static function getSubhints() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get text() : String
      {
         if(!this._text)
         {
            this._text = I18n.getText(this.hint_tooltip_text);
         }
         return this._text;
      }
   }
}
