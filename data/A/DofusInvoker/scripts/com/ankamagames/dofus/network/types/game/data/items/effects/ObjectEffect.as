package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectEffect implements INetworkType
   {
      
      public static const protocolId:uint = 8853;
       
      
      public var actionId:uint = 0;
      
      public function ObjectEffect()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 8853;
      }
      
      public function initObjectEffect(actionId:uint = 0) : ObjectEffect
      {
         this.actionId = actionId;
         return this;
      }
      
      public function reset() : void
      {
         this.actionId = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffect(output);
      }
      
      public function serializeAs_ObjectEffect(output:ICustomDataOutput) : void
      {
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
         }
         output.writeVarShort(this.actionId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffect(input);
      }
      
      public function deserializeAs_ObjectEffect(input:ICustomDataInput) : void
      {
         this._actionIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectEffect(tree);
      }
      
      public function deserializeAsyncAs_ObjectEffect(tree:FuncTree) : void
      {
         tree.addChild(this._actionIdFunc);
      }
      
      private function _actionIdFunc(input:ICustomDataInput) : void
      {
         this.actionId = input.readVarUhShort();
         if(this.actionId < 0)
         {
            throw new Error("Forbidden value (" + this.actionId + ") on element of ObjectEffect.actionId.");
         }
      }
   }
}
