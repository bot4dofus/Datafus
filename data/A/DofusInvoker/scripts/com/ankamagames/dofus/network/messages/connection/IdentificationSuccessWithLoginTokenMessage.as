package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IdentificationSuccessWithLoginTokenMessage extends IdentificationSuccessMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5227;
       
      
      private var _isInitialized:Boolean = false;
      
      public var loginToken:String = "";
      
      public function IdentificationSuccessWithLoginTokenMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5227;
      }
      
      public function initIdentificationSuccessWithLoginTokenMessage(login:String = "", accountTag:AccountTagInformation = null, accountId:uint = 0, communityId:uint = 0, hasRights:Boolean = false, hasReportRight:Boolean = false, hasForceRight:Boolean = false, accountCreation:Number = 0, subscriptionEndDate:Number = 0, wasAlreadyConnected:Boolean = false, havenbagAvailableRoom:uint = 0, loginToken:String = "") : IdentificationSuccessWithLoginTokenMessage
      {
         super.initIdentificationSuccessMessage(login,accountTag,accountId,communityId,hasRights,hasReportRight,hasForceRight,accountCreation,subscriptionEndDate,wasAlreadyConnected,havenbagAvailableRoom);
         this.loginToken = loginToken;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.loginToken = "";
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_IdentificationSuccessWithLoginTokenMessage(output);
      }
      
      public function serializeAs_IdentificationSuccessWithLoginTokenMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_IdentificationSuccessMessage(output);
         output.writeUTF(this.loginToken);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdentificationSuccessWithLoginTokenMessage(input);
      }
      
      public function deserializeAs_IdentificationSuccessWithLoginTokenMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._loginTokenFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdentificationSuccessWithLoginTokenMessage(tree);
      }
      
      public function deserializeAsyncAs_IdentificationSuccessWithLoginTokenMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._loginTokenFunc);
      }
      
      private function _loginTokenFunc(input:ICustomDataInput) : void
      {
         this.loginToken = input.readUTF();
      }
   }
}
