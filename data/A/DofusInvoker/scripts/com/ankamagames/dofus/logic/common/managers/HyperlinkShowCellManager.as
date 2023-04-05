package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.dofus.types.sequences.AddGfxEntityStep;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   
   public class HyperlinkShowCellManager
   {
       
      
      public function HyperlinkShowCellManager()
      {
         super();
      }
      
      public static function showCell(... args) : void
      {
         var sq:SerialSequencer = null;
         try
         {
            sq = new SerialSequencer();
            sq.addStep(new AddGfxEntityStep(645,args[int(Math.random() * args.length)]));
            sq.start();
         }
         catch(e:Error)
         {
         }
      }
   }
}
