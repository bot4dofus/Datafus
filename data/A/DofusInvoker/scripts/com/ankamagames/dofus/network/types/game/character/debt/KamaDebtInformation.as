package com.ankamagames.dofus.network.types.game.character.debt
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class KamaDebtInformation extends DebtInformation implements INetworkType
   {
      
      public static const protocolId:uint = 2104;
       
      
      public var kamas:Number = 0;
      
      public function KamaDebtInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2104;
      }
      
      public function initKamaDebtInformation(id:Number = 0, timestamp:Number = 0, kamas:Number = 0) : KamaDebtInformation
      {
         super.initDebtInformation(id,timestamp);
         this.kamas = kamas;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.kamas = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_KamaDebtInformation(output);
      }
      
      public function serializeAs_KamaDebtInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_DebtInformation(output);
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
         }
         output.writeVarLong(this.kamas);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_KamaDebtInformation(input);
      }
      
      public function deserializeAs_KamaDebtInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._kamasFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_KamaDebtInformation(tree);
      }
      
      public function deserializeAsyncAs_KamaDebtInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._kamasFunc);
      }
      
      private function _kamasFunc(input:ICustomDataInput) : void
      {
         this.kamas = input.readVarUhLong();
         if(this.kamas < 0 || this.kamas > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kamas + ") on element of KamaDebtInformation.kamas.");
         }
      }
   }
}
