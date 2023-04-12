package com.ankamagames.jerakine.sequencer
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.events.SequencerEvent;
   import flash.utils.getQualifiedClassName;
   
   public class ParallelStartSequenceStep extends AbstractSequencable implements ISubSequenceSequencable
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(ParallelStartSequenceStep));
       
      
      private var _aSequence:Array;
      
      private var _waitAllSequenceEnd:Boolean;
      
      private var _waitFirstEndSequence:Boolean;
      
      private var _sequenceEndCount:uint = 0;
      
      public function ParallelStartSequenceStep(aSequence:Array, waitAllSequenceEnd:Boolean = true, waitFirstEndSequence:Boolean = false)
      {
         super();
         this._aSequence = aSequence;
         this._waitAllSequenceEnd = waitAllSequenceEnd;
         this._waitFirstEndSequence = waitFirstEndSequence;
      }
      
      override public function start() : void
      {
         for(var i:uint = 0; i < this._aSequence.length; i++)
         {
            ISequencer(this._aSequence[i]).addEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
            ISequencer(this._aSequence[i]).start();
         }
         if(!this._waitAllSequenceEnd && !this._waitFirstEndSequence)
         {
            _log.debug("first executeCallbacks");
            executeCallbacks();
         }
      }
      
      public function get sequenceEndCount() : uint
      {
         return this._sequenceEndCount;
      }
      
      private function onSequenceEnd(e:SequencerEvent) : void
      {
         e.sequencer.removeEventListener(SequencerEvent.SEQUENCE_END,this.onSequenceEnd);
         ++this._sequenceEndCount;
         _log.debug("onSequenceEnd");
         if(this._sequenceEndCount == this._aSequence.length)
         {
            _log.debug("onSequenceEnd executeCallbacks");
            executeCallbacks();
            dispatchEvent(new SequencerEvent(SequencerEvent.SEQUENCE_END));
         }
         else if(!this._waitAllSequenceEnd)
         {
            if(this._sequenceEndCount == 1)
            {
               executeCallbacks();
            }
         }
      }
   }
}
