package com.ankamagames.dofus.datacenter.servers
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class ServerPopulation implements IDataCenter
   {
      
      public static const MODULE:String = "ServerPopulations";
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(ServerPopulation));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getServerPopulationById,getServerPopulations);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var weight:int;
      
      private var _name:String;
      
      public function ServerPopulation()
      {
         super();
      }
      
      public static function getServerPopulationById(id:int) : ServerPopulation
      {
         return GameData.getObject(MODULE,id) as ServerPopulation;
      }
      
      public static function getServerPopulations() : Array
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
