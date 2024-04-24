package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChatSmileyExtraPackListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8829;
       
      
      private var _isInitialized:Boolean = false;
      
      public var packIds:Vector.<uint>;
      
      private var _packIdstree:FuncTree;
      
      public function ChatSmileyExtraPackListMessage()
      {
         this.packIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8829;
      }
      
      public function initChatSmileyExtraPackListMessage(packIds:Vector.<uint> = null) : ChatSmileyExtraPackListMessage
      {
         this.packIds = packIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.packIds = new Vector.<uint>();
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
         this.serializeAs_ChatSmileyExtraPackListMessage(output);
      }
      
      public function serializeAs_ChatSmileyExtraPackListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.packIds.length);
         for(var _i1:uint = 0; _i1 < this.packIds.length; _i1++)
         {
            if(this.packIds[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.packIds[_i1] + ") on element 1 (starting at 1) of packIds.");
            }
            output.writeByte(this.packIds[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChatSmileyExtraPackListMessage(input);
      }
      
      public function deserializeAs_ChatSmileyExtraPackListMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _packIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _packIdsLen; _i1++)
         {
            _val1 = input.readByte();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of packIds.");
            }
            this.packIds.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChatSmileyExtraPackListMessage(tree);
      }
      
      public function deserializeAsyncAs_ChatSmileyExtraPackListMessage(tree:FuncTree) : void
      {
         this._packIdstree = tree.addChild(this._packIdstreeFunc);
      }
      
      private function _packIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._packIdstree.addChild(this._packIdsFunc);
         }
      }
      
      private function _packIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readByte();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of packIds.");
         }
         this.packIds.push(_val);
      }
   }
}
