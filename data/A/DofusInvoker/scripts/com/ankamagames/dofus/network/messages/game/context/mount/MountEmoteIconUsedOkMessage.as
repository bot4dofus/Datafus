package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MountEmoteIconUsedOkMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4913;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mountId:int = 0;
      
      public var reactionType:uint = 0;
      
      public function MountEmoteIconUsedOkMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4913;
      }
      
      public function initMountEmoteIconUsedOkMessage(mountId:int = 0, reactionType:uint = 0) : MountEmoteIconUsedOkMessage
      {
         this.mountId = mountId;
         this.reactionType = reactionType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mountId = 0;
         this.reactionType = 0;
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
         this.serializeAs_MountEmoteIconUsedOkMessage(output);
      }
      
      public function serializeAs_MountEmoteIconUsedOkMessage(output:ICustomDataOutput) : void
      {
         output.writeVarInt(this.mountId);
         if(this.reactionType < 0)
         {
            throw new Error("Forbidden value (" + this.reactionType + ") on element reactionType.");
         }
         output.writeByte(this.reactionType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountEmoteIconUsedOkMessage(input);
      }
      
      public function deserializeAs_MountEmoteIconUsedOkMessage(input:ICustomDataInput) : void
      {
         this._mountIdFunc(input);
         this._reactionTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountEmoteIconUsedOkMessage(tree);
      }
      
      public function deserializeAsyncAs_MountEmoteIconUsedOkMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mountIdFunc);
         tree.addChild(this._reactionTypeFunc);
      }
      
      private function _mountIdFunc(input:ICustomDataInput) : void
      {
         this.mountId = input.readVarInt();
      }
      
      private function _reactionTypeFunc(input:ICustomDataInput) : void
      {
         this.reactionType = input.readByte();
         if(this.reactionType < 0)
         {
            throw new Error("Forbidden value (" + this.reactionType + ") on element of MountEmoteIconUsedOkMessage.reactionType.");
         }
      }
   }
}
