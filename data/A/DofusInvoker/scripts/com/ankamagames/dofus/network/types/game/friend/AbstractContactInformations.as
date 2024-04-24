package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AbstractContactInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4780;
       
      
      public var accountId:uint = 0;
      
      public var accountTag:AccountTagInformation;
      
      private var _accountTagtree:FuncTree;
      
      public function AbstractContactInformations()
      {
         this.accountTag = new AccountTagInformation();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4780;
      }
      
      public function initAbstractContactInformations(accountId:uint = 0, accountTag:AccountTagInformation = null) : AbstractContactInformations
      {
         this.accountId = accountId;
         this.accountTag = accountTag;
         return this;
      }
      
      public function reset() : void
      {
         this.accountId = 0;
         this.accountTag = new AccountTagInformation();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AbstractContactInformations(output);
      }
      
      public function serializeAs_AbstractContactInformations(output:ICustomDataOutput) : void
      {
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
         this.accountTag.serializeAs_AccountTagInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractContactInformations(input);
      }
      
      public function deserializeAs_AbstractContactInformations(input:ICustomDataInput) : void
      {
         this._accountIdFunc(input);
         this.accountTag = new AccountTagInformation();
         this.accountTag.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AbstractContactInformations(tree);
      }
      
      public function deserializeAsyncAs_AbstractContactInformations(tree:FuncTree) : void
      {
         tree.addChild(this._accountIdFunc);
         this._accountTagtree = tree.addChild(this._accountTagtreeFunc);
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of AbstractContactInformations.accountId.");
         }
      }
      
      private function _accountTagtreeFunc(input:ICustomDataInput) : void
      {
         this.accountTag = new AccountTagInformation();
         this.accountTag.deserializeAsync(this._accountTagtree);
      }
   }
}
