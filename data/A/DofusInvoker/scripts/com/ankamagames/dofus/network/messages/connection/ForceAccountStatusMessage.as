package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ForceAccountStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8363;
       
      
      private var _isInitialized:Boolean = false;
      
      public var force:Boolean = false;
      
      public var forcedAccountId:uint = 0;
      
      public var forcedNickname:String = "";
      
      public var forcedTag:String = "";
      
      public function ForceAccountStatusMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8363;
      }
      
      public function initForceAccountStatusMessage(force:Boolean = false, forcedAccountId:uint = 0, forcedNickname:String = "", forcedTag:String = "") : ForceAccountStatusMessage
      {
         this.force = force;
         this.forcedAccountId = forcedAccountId;
         this.forcedNickname = forcedNickname;
         this.forcedTag = forcedTag;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.force = false;
         this.forcedAccountId = 0;
         this.forcedNickname = "";
         this.forcedTag = "";
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
         this.serializeAs_ForceAccountStatusMessage(output);
      }
      
      public function serializeAs_ForceAccountStatusMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.force);
         if(this.forcedAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.forcedAccountId + ") on element forcedAccountId.");
         }
         output.writeInt(this.forcedAccountId);
         output.writeUTF(this.forcedNickname);
         output.writeUTF(this.forcedTag);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ForceAccountStatusMessage(input);
      }
      
      public function deserializeAs_ForceAccountStatusMessage(input:ICustomDataInput) : void
      {
         this._forceFunc(input);
         this._forcedAccountIdFunc(input);
         this._forcedNicknameFunc(input);
         this._forcedTagFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ForceAccountStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_ForceAccountStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this._forceFunc);
         tree.addChild(this._forcedAccountIdFunc);
         tree.addChild(this._forcedNicknameFunc);
         tree.addChild(this._forcedTagFunc);
      }
      
      private function _forceFunc(input:ICustomDataInput) : void
      {
         this.force = input.readBoolean();
      }
      
      private function _forcedAccountIdFunc(input:ICustomDataInput) : void
      {
         this.forcedAccountId = input.readInt();
         if(this.forcedAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.forcedAccountId + ") on element of ForceAccountStatusMessage.forcedAccountId.");
         }
      }
      
      private function _forcedNicknameFunc(input:ICustomDataInput) : void
      {
         this.forcedNickname = input.readUTF();
      }
      
      private function _forcedTagFunc(input:ICustomDataInput) : void
      {
         this.forcedTag = input.readUTF();
      }
   }
}
