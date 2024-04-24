package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyFollowStatusUpdateMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1218;
       
      
      private var _isInitialized:Boolean = false;
      
      public var success:Boolean = false;
      
      public var isFollowed:Boolean = false;
      
      public var followedId:Number = 0;
      
      public function PartyFollowStatusUpdateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1218;
      }
      
      public function initPartyFollowStatusUpdateMessage(partyId:uint = 0, success:Boolean = false, isFollowed:Boolean = false, followedId:Number = 0) : PartyFollowStatusUpdateMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.success = success;
         this.isFollowed = isFollowed;
         this.followedId = followedId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.success = false;
         this.isFollowed = false;
         this.followedId = 0;
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
         this.serializeAs_PartyFollowStatusUpdateMessage(output);
      }
      
      public function serializeAs_PartyFollowStatusUpdateMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.success);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.isFollowed);
         output.writeByte(_box0);
         if(this.followedId < 0 || this.followedId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.followedId + ") on element followedId.");
         }
         output.writeVarLong(this.followedId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyFollowStatusUpdateMessage(input);
      }
      
      public function deserializeAs_PartyFollowStatusUpdateMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.deserializeByteBoxes(input);
         this._followedIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyFollowStatusUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyFollowStatusUpdateMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._followedIdFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.success = BooleanByteWrapper.getFlag(_box0,0);
         this.isFollowed = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _followedIdFunc(input:ICustomDataInput) : void
      {
         this.followedId = input.readVarUhLong();
         if(this.followedId < 0 || this.followedId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.followedId + ") on element of PartyFollowStatusUpdateMessage.followedId.");
         }
      }
   }
}
