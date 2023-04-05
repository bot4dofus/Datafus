package com.ankamagames.dofus.logic.game.fight.steps
{
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextual;
   import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextualManager;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import flash.text.TextFormat;
   
   public class FightLossAnimStep extends AbstractSequencable implements IFightStep
   {
       
      
      private var _value:int;
      
      private var _target:IEntity;
      
      private var _color:uint;
      
      public function FightLossAnimStep(pTarget:IEntity, pValue:int, pColor:uint)
      {
         super();
         this._value = pValue;
         this._target = pTarget;
         this._color = pColor;
      }
      
      public function get stepType() : String
      {
         return "lifeLossAnim";
      }
      
      override public function start() : void
      {
         var ccm:CharacteristicContextual = CharacteristicContextualManager.getInstance().addStatContextual(this._value.toString(),this._target,new TextFormat("Verdana",24,this._color,true),OptionManager.getOptionManager("tiphon").getOption("pointsOverhead"),GameContextEnum.FIGHT);
         executeCallbacks();
      }
      
      public function get targets() : Vector.<Number>
      {
         return new <Number>[this._target.id];
      }
   }
}
