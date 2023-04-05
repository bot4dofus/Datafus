package com.ankamagames.dofus.logic.game.fight.steps.abstract
{
   import com.ankamagames.berilia.types.event.BeriliaEvent;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextual;
   import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextualManager;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import flash.events.Event;
   import flash.text.TextFormat;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractStatContextualStep extends AbstractSequencable
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AbstractStatContextualStep));
       
      
      protected var _color:uint;
      
      protected var _value:String;
      
      protected var _targetId:Number;
      
      protected var _blocking:Boolean;
      
      protected var _virtual:Boolean;
      
      private var _ccm:CharacteristicContextual;
      
      private var _gameContext:uint;
      
      public function AbstractStatContextualStep(color:uint, value:String, targetId:Number, gameContext:uint, blocking:Boolean = true)
      {
         super();
         this._color = color;
         this._value = value;
         this._targetId = targetId;
         this._gameContext = gameContext;
         this._blocking = blocking;
      }
      
      override public function start() : void
      {
         if(!this._virtual && this._value != "0" && OptionManager.getOptionManager("tiphon").getOption("pointsOverhead") != 0)
         {
            this._ccm = CharacteristicContextualManager.getInstance().addStatContextual(this._value,DofusEntities.getEntity(this._targetId),new TextFormat("Verdana",24,this._color,true),OptionManager.getOptionManager("tiphon").getOption("pointsOverhead"),this._gameContext);
         }
         if(!this._ccm)
         {
            executeCallbacks();
            return;
         }
         if(!this._blocking)
         {
            executeCallbacks();
         }
         else
         {
            this._ccm.addEventListener(BeriliaEvent.REMOVE_COMPONENT,this.remove);
         }
      }
      
      public function get target() : IEntity
      {
         return DofusEntities.getEntity(this._targetId);
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._targetId];
      }
      
      private function remove(e:Event) : void
      {
         this._ccm.removeEventListener(BeriliaEvent.REMOVE_COMPONENT,this.remove);
         executeCallbacks();
      }
   }
}
