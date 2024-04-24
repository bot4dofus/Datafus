package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AccountCapabilitiesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7022;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accountId:uint = 0;
      
      public var tutorialAvailable:Boolean = false;
      
      public var status:int = -1;
      
      public var canCreateNewCharacter:Boolean = false;
      
      public function AccountCapabilitiesMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7022;
      }
      
      public function initAccountCapabilitiesMessage(accountId:uint = 0, tutorialAvailable:Boolean = false, status:int = -1, canCreateNewCharacter:Boolean = false) : AccountCapabilitiesMessage
      {
         this.accountId = accountId;
         this.tutorialAvailable = tutorialAvailable;
         this.status = status;
         this.canCreateNewCharacter = canCreateNewCharacter;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accountId = 0;
         this.tutorialAvailable = false;
         this.status = -1;
         this.canCreateNewCharacter = false;
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
         this.serializeAs_AccountCapabilitiesMessage(output);
      }
      
      public function serializeAs_AccountCapabilitiesMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.tutorialAvailable);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.canCreateNewCharacter);
         output.writeByte(_box0);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
         output.writeByte(this.status);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AccountCapabilitiesMessage(input);
      }
      
      public function deserializeAs_AccountCapabilitiesMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this._accountIdFunc(input);
         this._statusFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AccountCapabilitiesMessage(tree);
      }
      
      public function deserializeAsyncAs_AccountCapabilitiesMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._accountIdFunc);
         tree.addChild(this._statusFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.tutorialAvailable = BooleanByteWrapper.getFlag(_box0,0);
         this.canCreateNewCharacter = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of AccountCapabilitiesMessage.accountId.");
         }
      }
      
      private function _statusFunc(input:ICustomDataInput) : void
      {
         this.status = input.readByte();
      }
   }
}
