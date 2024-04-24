package com.ankamagames.dofus.network.messages.game.chat.community
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatCommunityChannelCommunityMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8760;
       
      
      private var _isInitialized:Boolean = false;
      
      public var communityId:int = 0;
      
      public function ChatCommunityChannelCommunityMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8760;
      }
      
      public function initChatCommunityChannelCommunityMessage(communityId:int = 0) : ChatCommunityChannelCommunityMessage
      {
         this.communityId = communityId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.communityId = 0;
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
         this.serializeAs_ChatCommunityChannelCommunityMessage(output);
      }
      
      public function serializeAs_ChatCommunityChannelCommunityMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.communityId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatCommunityChannelCommunityMessage(input);
      }
      
      public function deserializeAs_ChatCommunityChannelCommunityMessage(input:ICustomDataInput) : void
      {
         this._communityIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatCommunityChannelCommunityMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatCommunityChannelCommunityMessage(tree:FuncTree) : void
      {
         tree.addChild(this._communityIdFunc);
      }
      
      private function _communityIdFunc(input:ICustomDataInput) : void
      {
         this.communityId = input.readShort();
      }
   }
}
