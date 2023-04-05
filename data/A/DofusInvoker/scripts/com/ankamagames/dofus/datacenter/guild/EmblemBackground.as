package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class EmblemBackground implements IDataCenter
   {
      
      public static const MODULE:String = "EmblemBackgrounds";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EmblemBackground));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getEmblemBackgroundById,getEmblemBackgrounds);
       
      
      public var id:int;
      
      public var order:int;
      
      public function EmblemBackground()
      {
         super();
      }
      
      public static function getEmblemBackgroundById(id:int) : EmblemBackground
      {
         return GameData.getObject(MODULE,id) as EmblemBackground;
      }
      
      public static function getEmblemBackgrounds() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
