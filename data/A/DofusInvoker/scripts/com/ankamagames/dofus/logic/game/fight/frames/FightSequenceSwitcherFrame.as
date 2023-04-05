package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   
   public class FightSequenceSwitcherFrame implements Frame
   {
       
      
      private var _currentFrame:Frame;
      
      public function FightSequenceSwitcherFrame()
      {
         super();
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      public function set currentFrame(f:Frame) : void
      {
         this._currentFrame = f;
      }
      
      public function process(msg:Message) : Boolean
      {
         if(this._currentFrame)
         {
            return this._currentFrame.process(msg);
         }
         return false;
      }
   }
}
