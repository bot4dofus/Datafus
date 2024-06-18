package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IdentificationSuccessMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6104;
       
      
      private var _isInitialized:Boolean = false;
      
      [Transient]
      public var login:String = "";
      
      public var accountTag:AccountTagInformation;
      
      public var accountId:uint = 0;
      
      public var communityId:uint = 0;
      
      public var hasRights:Boolean = false;
      
      public var hasReportRight:Boolean = false;
      
      public var hasForceRight:Boolean = false;
      
      public var accountCreation:Number = 0;
      
      public var subscriptionEndDate:Number = 0;
      
      public var wasAlreadyConnected:Boolean = false;
      
      public var havenbagAvailableRoom:uint = 0;
      
      private var _accountTagtree:FuncTree;
      
      public function IdentificationSuccessMessage()
      {
         this.accountTag = new AccountTagInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6104;
      }
      
      public function initIdentificationSuccessMessage(login:String = "", accountTag:AccountTagInformation = null, accountId:uint = 0, communityId:uint = 0, hasRights:Boolean = false, hasReportRight:Boolean = false, hasForceRight:Boolean = false, accountCreation:Number = 0, subscriptionEndDate:Number = 0, wasAlreadyConnected:Boolean = false, havenbagAvailableRoom:uint = 0) : IdentificationSuccessMessage
      {
         this.login = login;
         this.accountTag = accountTag;
         this.accountId = accountId;
         this.communityId = communityId;
         this.hasRights = hasRights;
         this.hasReportRight = hasReportRight;
         this.hasForceRight = hasForceRight;
         this.accountCreation = accountCreation;
         this.subscriptionEndDate = subscriptionEndDate;
         this.wasAlreadyConnected = wasAlreadyConnected;
         this.havenbagAvailableRoom = havenbagAvailableRoom;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.login = "";
         this.accountTag = new AccountTagInformation();
         this.communityId = 0;
         this.hasRights = false;
         this.hasReportRight = false;
         this.hasForceRight = false;
         this.accountCreation = 0;
         this.subscriptionEndDate = 0;
         this.wasAlreadyConnected = false;
         this.havenbagAvailableRoom = 0;
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
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_IdentificationSuccessMessage(output);
      }
      
      public function serializeAs_IdentificationSuccessMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.hasRights);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.hasReportRight);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.hasForceRight);
         _box0 = BooleanByteWrapper.setFlag(_box0,3,this.wasAlreadyConnected);
         output.writeByte(_box0);
         output.writeUTF(this.login);
         this.accountTag.serializeAs_AccountTagInformation(output);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
         if(this.communityId < 0)
         {
            throw new Error("Forbidden value (" + this.communityId + ") on element communityId.");
         }
         output.writeByte(this.communityId);
         if(this.accountCreation < 0 || this.accountCreation > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.accountCreation + ") on element accountCreation.");
         }
         output.writeDouble(this.accountCreation);
         if(this.subscriptionEndDate < 0 || this.subscriptionEndDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.subscriptionEndDate + ") on element subscriptionEndDate.");
         }
         output.writeDouble(this.subscriptionEndDate);
         if(this.havenbagAvailableRoom < 0 || this.havenbagAvailableRoom > 255)
         {
            throw new Error("Forbidden value (" + this.havenbagAvailableRoom + ") on element havenbagAvailableRoom.");
         }
         output.writeByte(this.havenbagAvailableRoom);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdentificationSuccessMessage(input);
      }
      
      public function deserializeAs_IdentificationSuccessMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this._loginFunc(input);
         this.accountTag = new AccountTagInformation();
         this.accountTag.deserialize(input);
         this._accountIdFunc(input);
         this._communityIdFunc(input);
         this._accountCreationFunc(input);
         this._subscriptionEndDateFunc(input);
         this._havenbagAvailableRoomFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdentificationSuccessMessage(tree);
      }
      
      public function deserializeAsyncAs_IdentificationSuccessMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._loginFunc);
         this._accountTagtree = tree.addChild(this._accountTagtreeFunc);
         tree.addChild(this._accountIdFunc);
         tree.addChild(this._communityIdFunc);
         tree.addChild(this._accountCreationFunc);
         tree.addChild(this._subscriptionEndDateFunc);
         tree.addChild(this._havenbagAvailableRoomFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.hasRights = BooleanByteWrapper.getFlag(_box0,0);
         this.hasReportRight = BooleanByteWrapper.getFlag(_box0,1);
         this.hasForceRight = BooleanByteWrapper.getFlag(_box0,2);
         this.wasAlreadyConnected = BooleanByteWrapper.getFlag(_box0,3);
      }
      
      private function _loginFunc(input:ICustomDataInput) : void
      {
         this.login = input.readUTF();
      }
      
      private function _accountTagtreeFunc(input:ICustomDataInput) : void
      {
         this.accountTag = new AccountTagInformation();
         this.accountTag.deserializeAsync(this._accountTagtree);
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of IdentificationSuccessMessage.accountId.");
         }
      }
      
      private function _communityIdFunc(input:ICustomDataInput) : void
      {
         this.communityId = input.readByte();
         if(this.communityId < 0)
         {
            throw new Error("Forbidden value (" + this.communityId + ") on element of IdentificationSuccessMessage.communityId.");
         }
      }
      
      private function _accountCreationFunc(input:ICustomDataInput) : void
      {
         this.accountCreation = input.readDouble();
         if(this.accountCreation < 0 || this.accountCreation > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.accountCreation + ") on element of IdentificationSuccessMessage.accountCreation.");
         }
      }
      
      private function _subscriptionEndDateFunc(input:ICustomDataInput) : void
      {
         this.subscriptionEndDate = input.readDouble();
         if(this.subscriptionEndDate < 0 || this.subscriptionEndDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.subscriptionEndDate + ") on element of IdentificationSuccessMessage.subscriptionEndDate.");
         }
      }
      
      private function _havenbagAvailableRoomFunc(input:ICustomDataInput) : void
      {
         this.havenbagAvailableRoom = input.readUnsignedByte();
         if(this.havenbagAvailableRoom < 0 || this.havenbagAvailableRoom > 255)
         {
            throw new Error("Forbidden value (" + this.havenbagAvailableRoom + ") on element of IdentificationSuccessMessage.havenbagAvailableRoom.");
         }
      }
   }
}
