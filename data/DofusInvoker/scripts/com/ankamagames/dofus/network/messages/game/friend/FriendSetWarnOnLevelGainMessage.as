package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class FriendSetWarnOnLevelGainMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9859;
       
      
      private var _isInitialized:Boolean = false;
      
      public var enable:Boolean = false;
      
      public function FriendSetWarnOnLevelGainMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9859;
      }
      
      public function initFriendSetWarnOnLevelGainMessage(enable:Boolean = false) : FriendSetWarnOnLevelGainMessage
      {
         this.enable = enable;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.enable = false;
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
         this.serializeAs_FriendSetWarnOnLevelGainMessage(output);
      }
      
      public function serializeAs_FriendSetWarnOnLevelGainMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.enable);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FriendSetWarnOnLevelGainMessage(input);
      }
      
      public function deserializeAs_FriendSetWarnOnLevelGainMessage(input:ICustomDataInput) : void
      {
         this._enableFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FriendSetWarnOnLevelGainMessage(tree);
      }
      
      public function deserializeAsyncAs_FriendSetWarnOnLevelGainMessage(tree:FuncTree) : void
      {
         tree.addChild(this._enableFunc);
      }
      
      private function _enableFunc(input:ICustomDataInput) : void
      {
         this.enable = input.readBoolean();
      }
   }
}
