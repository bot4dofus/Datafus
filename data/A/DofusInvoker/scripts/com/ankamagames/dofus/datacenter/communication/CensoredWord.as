package com.ankamagames.dofus.datacenter.communication
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class CensoredWord implements IDataCenter
   {
      
      public static const MODULE:String = "CensoredWords";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CensoredWord));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getCensoredWordById,getCensoredWords);
       
      
      public var id:uint;
      
      public var listId:uint;
      
      public var language:String;
      
      public var word:String;
      
      public var deepLooking:Boolean;
      
      public function CensoredWord()
      {
         super();
      }
      
      public static function getCensoredWordById(id:int) : CensoredWord
      {
         return GameData.getObject(MODULE,id) as CensoredWord;
      }
      
      public static function getCensoredWords() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
