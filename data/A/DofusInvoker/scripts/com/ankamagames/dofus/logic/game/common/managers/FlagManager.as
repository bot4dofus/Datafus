package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.dofus.datacenter.world.Phoenix;
   
   public class FlagManager
   {
      
      private static var _self:FlagManager;
       
      
      private var _phoenixs:Array;
      
      public function FlagManager()
      {
         super();
      }
      
      public static function getInstance() : FlagManager
      {
         var phoenixes:Array = null;
         var phoenix:Phoenix = null;
         if(!_self)
         {
            _self = new FlagManager();
            phoenixes = Phoenix.getAllPhoenixes();
            _self.phoenixs = new Array();
            for each(phoenix in phoenixes)
            {
               _self.phoenixs.push(phoenix.mapId);
            }
         }
         return _self;
      }
      
      public function get phoenixs() : Array
      {
         return this._phoenixs;
      }
      
      public function set phoenixs(value:Array) : void
      {
         this._phoenixs = value;
      }
   }
}
