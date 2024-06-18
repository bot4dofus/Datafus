package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectEffectMinMax extends ObjectEffect implements INetworkType
   {
      
      public static const protocolId:uint = 843;
       
      
      public var min:uint = 0;
      
      public var max:uint = 0;
      
      public function ObjectEffectMinMax()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 843;
      }
      
      public function initObjectEffectMinMax(actionId:uint = 0, min:uint = 0, max:uint = 0) : ObjectEffectMinMax
      {
         super.initObjectEffect(actionId);
         this.min = min;
         this.max = max;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.min = 0;
         this.max = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffectMinMax(output);
      }
      
      public function serializeAs_ObjectEffectMinMax(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectEffect(output);
         if(this.min < 0)
         {
            throw new Error("Forbidden value (" + this.min + ") on element min.");
         }
         output.writeVarInt(this.min);
         if(this.max < 0)
         {
            throw new Error("Forbidden value (" + this.max + ") on element max.");
         }
         output.writeVarInt(this.max);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffectMinMax(input);
      }
      
      public function deserializeAs_ObjectEffectMinMax(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._minFunc(input);
         this._maxFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectEffectMinMax(tree);
      }
      
      public function deserializeAsyncAs_ObjectEffectMinMax(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._minFunc);
         tree.addChild(this._maxFunc);
      }
      
      private function _minFunc(input:ICustomDataInput) : void
      {
         this.min = input.readVarUhInt();
         if(this.min < 0)
         {
            throw new Error("Forbidden value (" + this.min + ") on element of ObjectEffectMinMax.min.");
         }
      }
      
      private function _maxFunc(input:ICustomDataInput) : void
      {
         this.max = input.readVarUhInt();
         if(this.max < 0)
         {
            throw new Error("Forbidden value (" + this.max + ") on element of ObjectEffectMinMax.max.");
         }
      }
   }
}
