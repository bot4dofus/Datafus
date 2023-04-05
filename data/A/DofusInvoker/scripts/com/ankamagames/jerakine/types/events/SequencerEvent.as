package com.ankamagames.jerakine.types.events
{
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.sequencer.ISequencer;
   import flash.events.Event;
   
   public class SequencerEvent extends Event
   {
      
      public static const SEQUENCE_END:String = "onSequenceEnd";
      
      public static const SEQUENCE_STEP_START:String = "SEQUENCE_STEP_START";
      
      public static const SEQUENCE_STEP_FINISH:String = "SEQUENCE_STEP_FINISH";
      
      public static const SEQUENCE_TIMEOUT:String = "onSequenceTimeOut";
       
      
      private var _sequencer:ISequencer;
      
      private var _step:ISequencable;
      
      public function SequencerEvent(type:String, sequencer:ISequencer = null, step:ISequencable = null)
      {
         super(type,false,false);
         this._sequencer = sequencer;
         this._step = step;
      }
      
      public function get sequencer() : ISequencer
      {
         return this._sequencer;
      }
      
      public function get step() : ISequencable
      {
         return this._step;
      }
   }
}
