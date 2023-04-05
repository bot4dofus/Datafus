package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSmileysAction;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class HyperlinkShowEmoteManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HyperlinkShowOrnamentManager));
       
      
      public function HyperlinkShowEmoteManager()
      {
         super();
      }
      
      public static function showEmote(ornId:uint) : void
      {
         Kernel.getWorker().process(OpenSmileysAction.create(-1));
      }
   }
}
