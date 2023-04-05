package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class EmblemSymbol implements IDataCenter
   {
      
      public static const MODULE:String = "EmblemSymbols";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemSymbol));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getEmblemSymbolById,getEmblemSymbols);
       
      
      public var id:int;
      
      public var iconId:int;
      
      public var skinId:int;
      
      public var order:int;
      
      public var categoryId:int;
      
      public var colorizable:Boolean;
      
      public function EmblemSymbol()
      {
         super();
      }
      
      public static function getEmblemSymbolById(id:int) : EmblemSymbol
      {
         return GameData.getObject(MODULE,id) as EmblemSymbol;
      }
      
      public static function getEmblemSymbols() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
