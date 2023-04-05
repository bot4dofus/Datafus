package com.ankamagames.dofus.datacenter.communication
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class SmileyPack implements IDataCenter
   {
      
      public static const MODULE:String = "SmileyPacks";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SmileyPack));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSmileyPackById,getSmileyPacks);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var order:uint;
      
      public var smileys:Vector.<uint>;
      
      private var _name:String;
      
      public function SmileyPack()
      {
         super();
      }
      
      public static function getSmileyPackById(id:int) : SmileyPack
      {
         return GameData.getObject(MODULE,id) as SmileyPack;
      }
      
      public static function getSmileyPacks() : Array
      {
         return GameData.getObjects(MODULE);
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
