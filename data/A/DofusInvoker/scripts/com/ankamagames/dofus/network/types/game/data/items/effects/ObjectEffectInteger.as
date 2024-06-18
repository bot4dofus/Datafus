package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectEffectInteger extends ObjectEffect implements INetworkType
   {
      
      public static const protocolId:uint = 3930;
       
      
      public var value:uint = 0;
      
      public function ObjectEffectInteger()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3930;
      }
      
      public function initObjectEffectInteger(actionId:uint = 0, value:uint = 0) : ObjectEffectInteger
      {
         super.initObjectEffect(actionId);
         this.value = value;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffectInteger(output);
      }
      
      public function serializeAs_ObjectEffectInteger(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectEffect(output);
         if(this.value < 0)
         {
            throw new Error("Forbidden value (" + this.value + ") on element value.");
         }
         output.writeVarInt(this.value);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffectInteger(input);
      }
      
      public function deserializeAs_ObjectEffectInteger(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._valueFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectEffectInteger(tree);
      }
      
      public function deserializeAsyncAs_ObjectEffectInteger(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._valueFunc);
      }
      
      private function _valueFunc(input:ICustomDataInput) : void
      {
         this.value = input.readVarUhInt();
         if(this.value < 0)
         {
            throw new Error("Forbidden value (" + this.value + ") on element of ObjectEffectInteger.value.");
         }
      }
   }
}
