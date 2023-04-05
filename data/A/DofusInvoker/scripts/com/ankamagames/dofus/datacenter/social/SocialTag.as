package com.ankamagames.dofus.datacenter.social
{
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class SocialTag implements IDataCenter
   {
       
      
      public var id:int;
      
      public var typeId:int;
      
      public var nameId:uint;
      
      public var order:int;
      
      protected var _name:String;
      
      public function SocialTag()
      {
         super();
      }
      
      public static function getSocialTagById(module:String, id:int) : SocialTag
      {
         return GameData.getObject(module,id) as SocialTag;
      }
      
      public static function getSocialTags(module:String) : Array
      {
         return GameData.getObjects(module);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
