package com.ankamagames.dofus.network.types.web.haapi
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class BufferInformation implements INetworkType
   {
      
      public static const protocolId:uint = 4783;
       
      
      public var id:Number = 0;
      
      public var amount:Number = 0;
      
      public function BufferInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4783;
      }
      
      public function initBufferInformation(id:Number = 0, amount:Number = 0) : BufferInformation
      {
         this.id = id;
         this.amount = amount;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.amount = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_BufferInformation(output);
      }
      
      public function serializeAs_BufferInformation(output:ICustomDataOutput) : void
      {
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarLong(this.id);
         if(this.amount < 0 || this.amount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element amount.");
         }
         output.writeVarLong(this.amount);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BufferInformation(input);
      }
      
      public function deserializeAs_BufferInformation(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._amountFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BufferInformation(tree);
      }
      
      public function deserializeAsyncAs_BufferInformation(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._amountFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhLong();
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of BufferInformation.id.");
         }
      }
      
      private function _amountFunc(input:ICustomDataInput) : void
      {
         this.amount = input.readVarUhLong();
         if(this.amount < 0 || this.amount > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.amount + ") on element of BufferInformation.amount.");
         }
      }
   }
}
