package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class EmoteListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6038;
       
      
      private var _isInitialized:Boolean = false;
      
      public var emoteIds:Vector.<uint>;
      
      private var _emoteIdstree:FuncTree;
      
      public function EmoteListMessage()
      {
         this.emoteIds = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6038;
      }
      
      public function initEmoteListMessage(emoteIds:Vector.<uint> = null) : EmoteListMessage
      {
         this.emoteIds = emoteIds;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.emoteIds = new Vector.<uint>();
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
         this.serializeAs_EmoteListMessage(output);
      }
      
      public function serializeAs_EmoteListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.emoteIds.length);
         for(var _i1:uint = 0; _i1 < this.emoteIds.length; _i1++)
         {
            if(this.emoteIds[_i1] < 0 || this.emoteIds[_i1] > 65535)
            {
               throw new Error("Forbidden value (" + this.emoteIds[_i1] + ") on element 1 (starting at 1) of emoteIds.");
            }
            output.writeShort(this.emoteIds[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_EmoteListMessage(input);
      }
      
      public function deserializeAs_EmoteListMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _emoteIdsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _emoteIdsLen; _i1++)
         {
            _val1 = input.readUnsignedShort();
            if(_val1 < 0 || _val1 > 65535)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of emoteIds.");
            }
            this.emoteIds.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_EmoteListMessage(tree);
      }
      
      public function deserializeAsyncAs_EmoteListMessage(tree:FuncTree) : void
      {
         this._emoteIdstree = tree.addChild(this._emoteIdstreeFunc);
      }
      
      private function _emoteIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._emoteIdstree.addChild(this._emoteIdsFunc);
         }
      }
      
      private function _emoteIdsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readUnsignedShort();
         if(_val < 0 || _val > 65535)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of emoteIds.");
         }
         this.emoteIds.push(_val);
      }
   }
}
