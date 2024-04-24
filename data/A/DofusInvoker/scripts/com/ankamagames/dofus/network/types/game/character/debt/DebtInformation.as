package com.ankamagames.dofus.network.types.game.character.debt
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class DebtInformation implements INetworkType
   {
      
      public static const protocolId:uint = 2748;
       
      
      public var id:Number = 0;
      
      public var timestamp:Number = 0;
      
      public function DebtInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2748;
      }
      
      public function initDebtInformation(id:Number = 0, timestamp:Number = 0) : DebtInformation
      {
         this.id = id;
         this.timestamp = timestamp;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.timestamp = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_DebtInformation(output);
      }
      
      public function serializeAs_DebtInformation(output:ICustomDataOutput) : void
      {
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeDouble(this.id);
         if(this.timestamp < 0 || this.timestamp > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element timestamp.");
         }
         output.writeDouble(this.timestamp);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DebtInformation(input);
      }
      
      public function deserializeAs_DebtInformation(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._timestampFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DebtInformation(tree);
      }
      
      public function deserializeAsyncAs_DebtInformation(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._timestampFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readDouble();
         if(this.id < 0 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of DebtInformation.id.");
         }
      }
      
      private function _timestampFunc(input:ICustomDataInput) : void
      {
         this.timestamp = input.readDouble();
         if(this.timestamp < 0 || this.timestamp > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element of DebtInformation.timestamp.");
         }
      }
   }
}
