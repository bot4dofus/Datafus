package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class EmotePlayAbstractMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8532;
       
      
      private var _isInitialized:Boolean = false;
      
      public var emoteId:uint = 0;
      
      public var emoteStartTime:Number = 0;
      
      public function EmotePlayAbstractMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8532;
      }
      
      public function initEmotePlayAbstractMessage(emoteId:uint = 0, emoteStartTime:Number = 0) : EmotePlayAbstractMessage
      {
         this.emoteId = emoteId;
         this.emoteStartTime = emoteStartTime;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.emoteId = 0;
         this.emoteStartTime = 0;
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
         this.serializeAs_EmotePlayAbstractMessage(output);
      }
      
      public function serializeAs_EmotePlayAbstractMessage(output:ICustomDataOutput) : void
      {
         if(this.emoteId < 0 || this.emoteId > 65535)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element emoteId.");
         }
         output.writeShort(this.emoteId);
         if(this.emoteStartTime < -9007199254740992 || this.emoteStartTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.emoteStartTime + ") on element emoteStartTime.");
         }
         output.writeDouble(this.emoteStartTime);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_EmotePlayAbstractMessage(input);
      }
      
      public function deserializeAs_EmotePlayAbstractMessage(input:ICustomDataInput) : void
      {
         this._emoteIdFunc(input);
         this._emoteStartTimeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_EmotePlayAbstractMessage(tree);
      }
      
      public function deserializeAsyncAs_EmotePlayAbstractMessage(tree:FuncTree) : void
      {
         tree.addChild(this._emoteIdFunc);
         tree.addChild(this._emoteStartTimeFunc);
      }
      
      private function _emoteIdFunc(input:ICustomDataInput) : void
      {
         this.emoteId = input.readUnsignedShort();
         if(this.emoteId < 0 || this.emoteId > 65535)
         {
            throw new Error("Forbidden value (" + this.emoteId + ") on element of EmotePlayAbstractMessage.emoteId.");
         }
      }
      
      private function _emoteStartTimeFunc(input:ICustomDataInput) : void
      {
         this.emoteStartTime = input.readDouble();
         if(this.emoteStartTime < -9007199254740992 || this.emoteStartTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.emoteStartTime + ") on element of EmotePlayAbstractMessage.emoteStartTime.");
         }
      }
   }
}
