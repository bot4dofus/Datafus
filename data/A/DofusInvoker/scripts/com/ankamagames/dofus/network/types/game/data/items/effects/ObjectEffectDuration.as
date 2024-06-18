package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectEffectDuration extends ObjectEffect implements INetworkType
   {
      
      public static const protocolId:uint = 7031;
       
      
      public var days:uint = 0;
      
      public var hours:uint = 0;
      
      public var minutes:uint = 0;
      
      public function ObjectEffectDuration()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7031;
      }
      
      public function initObjectEffectDuration(actionId:uint = 0, days:uint = 0, hours:uint = 0, minutes:uint = 0) : ObjectEffectDuration
      {
         super.initObjectEffect(actionId);
         this.days = days;
         this.hours = hours;
         this.minutes = minutes;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.days = 0;
         this.hours = 0;
         this.minutes = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffectDuration(output);
      }
      
      public function serializeAs_ObjectEffectDuration(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectEffect(output);
         if(this.days < 0)
         {
            throw new Error("Forbidden value (" + this.days + ") on element days.");
         }
         output.writeVarShort(this.days);
         if(this.hours < 0)
         {
            throw new Error("Forbidden value (" + this.hours + ") on element hours.");
         }
         output.writeByte(this.hours);
         if(this.minutes < 0)
         {
            throw new Error("Forbidden value (" + this.minutes + ") on element minutes.");
         }
         output.writeByte(this.minutes);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffectDuration(input);
      }
      
      public function deserializeAs_ObjectEffectDuration(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._daysFunc(input);
         this._hoursFunc(input);
         this._minutesFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectEffectDuration(tree);
      }
      
      public function deserializeAsyncAs_ObjectEffectDuration(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._daysFunc);
         tree.addChild(this._hoursFunc);
         tree.addChild(this._minutesFunc);
      }
      
      private function _daysFunc(input:ICustomDataInput) : void
      {
         this.days = input.readVarUhShort();
         if(this.days < 0)
         {
            throw new Error("Forbidden value (" + this.days + ") on element of ObjectEffectDuration.days.");
         }
      }
      
      private function _hoursFunc(input:ICustomDataInput) : void
      {
         this.hours = input.readByte();
         if(this.hours < 0)
         {
            throw new Error("Forbidden value (" + this.hours + ") on element of ObjectEffectDuration.hours.");
         }
      }
      
      private function _minutesFunc(input:ICustomDataInput) : void
      {
         this.minutes = input.readByte();
         if(this.minutes < 0)
         {
            throw new Error("Forbidden value (" + this.minutes + ") on element of ObjectEffectDuration.minutes.");
         }
      }
   }
}
