package com.ankamagames.dofus.logic.common.frames
{
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.network.messages.authorized.AdminQuietCommandMessage;
   import com.ankamagames.dofus.network.messages.authorized.ConsoleMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.jerakine.messages.RegisteringFrame;
   import flash.utils.setTimeout;
   
   public class BenchmarkFrame extends RegisteringFrame
   {
       
      
      private var _subAreaIndex:uint;
      
      public function BenchmarkFrame()
      {
         super();
      }
      
      override protected function registerMessages() : void
      {
         register(MapComplementaryInformationsDataMessage,this.onMapReady);
         register(ConsoleMessage,this.onConsoleMsg);
      }
      
      private function onConsoleMsg(msg:ConsoleMessage) : void
      {
         if(msg.content && msg.content.indexOf("La carte ne doit pas exister, ou n\'est pas accessible ") != -1)
         {
            this.moveToNextMap();
         }
      }
      
      private function onMapReady(msg:MapComplementaryInformationsDataMessage) : void
      {
         setTimeout(this.moveToNextMap,1000);
      }
      
      override public function pushed() : Boolean
      {
         this._subAreaIndex = 0;
         this.moveToNextMap();
         return true;
      }
      
      private function moveToNextMap() : void
      {
         var subareas:Array = SubArea.getAllSubArea();
         var aqcmsg:AdminQuietCommandMessage = new AdminQuietCommandMessage();
         aqcmsg.initAdminQuietCommandMessage("moveto " + SubArea(subareas[this._subAreaIndex++ % subareas.length]).mapIds[0]);
         ConnectionsHandler.getConnection().send(aqcmsg);
      }
   }
}
