package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class GameDebugManager
   {
      
      private static var _self:GameDebugManager;
       
      
      public var buffsDebugActivated:Boolean;
      
      public var haxeGenerateTestFromNextSpellCast:Boolean;
      
      public var haxeGenerateTestFromNextSpellCast_stats:Boolean;
      
      public var haxeGenerateTestFromNextSpellCast_infos:Boolean;
      
      public var detailedFightLog_unGroupEffects:Boolean;
      
      public var detailedFightLog_showIds:Boolean;
      
      public var detailedFightLog_showEverything:Boolean;
      
      public var detailedFightLog_showBuffsInUi:Boolean;
      
      public function GameDebugManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("GameDebugManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : GameDebugManager
      {
         if(_self == null)
         {
            _self = new GameDebugManager();
         }
         return _self;
      }
      
      public static function destroy() : void
      {
         _self = null;
      }
   }
}
