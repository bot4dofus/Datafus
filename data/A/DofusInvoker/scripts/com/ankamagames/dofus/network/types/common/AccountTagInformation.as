package com.ankamagames.dofus.network.types.common
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AccountTagInformation implements INetworkType
   {
      
      public static const protocolId:uint = 9531;
       
      
      public var nickname:String = "";
      
      public var tagNumber:String = "";
      
      public function AccountTagInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9531;
      }
      
      public function initAccountTagInformation(nickname:String = "", tagNumber:String = "") : AccountTagInformation
      {
         this.nickname = nickname;
         this.tagNumber = tagNumber;
         return this;
      }
      
      public function reset() : void
      {
         this.nickname = "";
         this.tagNumber = "";
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AccountTagInformation(output);
      }
      
      public function serializeAs_AccountTagInformation(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.nickname);
         output.writeUTF(this.tagNumber);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AccountTagInformation(input);
      }
      
      public function deserializeAs_AccountTagInformation(input:ICustomDataInput) : void
      {
         this._nicknameFunc(input);
         this._tagNumberFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AccountTagInformation(tree);
      }
      
      public function deserializeAsyncAs_AccountTagInformation(tree:FuncTree) : void
      {
         tree.addChild(this._nicknameFunc);
         tree.addChild(this._tagNumberFunc);
      }
      
      private function _nicknameFunc(input:ICustomDataInput) : void
      {
         this.nickname = input.readUTF();
      }
      
      private function _tagNumberFunc(input:ICustomDataInput) : void
      {
         this.tagNumber = input.readUTF();
      }
   }
}
