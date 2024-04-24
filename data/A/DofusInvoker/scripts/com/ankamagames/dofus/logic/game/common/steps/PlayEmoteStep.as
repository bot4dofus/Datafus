package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.messages.GameRolePlaySetAnimationMessage;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.tiphon.events.TiphonEvent;
   
   public class PlayEmoteStep extends AbstractSequencable
   {
       
      
      private var _entity:AnimatedCharacter;
      
      private var _emoteId:int;
      
      private var _waitForEnd:Boolean;
      
      public function PlayEmoteStep(pEntity:AnimatedCharacter, pEmoteId:int, pWaitForEnd:Boolean)
      {
         super();
         this._entity = pEntity;
         this._emoteId = pEmoteId;
         this._waitForEnd = pWaitForEnd;
         timeout = 10000;
      }
      
      override public function start() : void
      {
         var anim:String = null;
         var rpef:RoleplayEntitiesFrame = null;
         var emote:Emoticon = Emoticon.getEmoticonById(this._emoteId);
         if(emote)
         {
            if(this._waitForEnd)
            {
               this._entity.addEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
            }
            anim = emote.getAnimName();
            rpef = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            rpef.currentEmoticon = this._emoteId;
            rpef.process(new GameRolePlaySetAnimationMessage(rpef.getEntityInfos(this._entity.id),anim,emote.spellLevelId,0,!emote.persistancy,emote.eight_directions));
         }
         if(!emote || !this._waitForEnd)
         {
            executeCallbacks();
         }
      }
      
      private function onAnimationEnd(pEvent:TiphonEvent) : void
      {
         pEvent.currentTarget.removeEventListener(TiphonEvent.ANIMATION_END,this.onAnimationEnd);
         executeCallbacks();
      }
   }
}
