package com.ankamagames.dofus.logic.game.fight.frames.Preview
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   import tools.LoggerInterface;
   
   public class HaxeLoggerTranslator implements LoggerInterface
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HaxeLoggerTranslator));
       
      
      public function HaxeLoggerTranslator()
      {
         super();
      }
      
      public function logError(message:String) : void
      {
         _log.trace(message);
      }
   }
}
