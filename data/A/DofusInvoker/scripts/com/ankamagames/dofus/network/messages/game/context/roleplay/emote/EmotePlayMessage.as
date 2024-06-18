package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class EmotePlayMessage extends EmotePlayAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3198;
       
      
      private var _isInitialized:Boolean = false;
      
      public var actorId:Number = 0;
      
      public var accountId:uint = 0;
      
      public function EmotePlayMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3198;
      }
      
      public function initEmotePlayMessage(emoteId:uint = 0, emoteStartTime:Number = 0, actorId:Number = 0, accountId:uint = 0) : EmotePlayMessage
      {
         super.initEmotePlayAbstractMessage(emoteId,emoteStartTime);
         this.actorId = actorId;
         this.accountId = accountId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.actorId = 0;
         this.accountId = 0;
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
         this.serializeAs_EmotePlayMessage(output);
      }
      
      public function serializeAs_EmotePlayMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_EmotePlayAbstractMessage(output);
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element actorId.");
         }
         output.writeDouble(this.actorId);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_EmotePlayMessage(input);
      }
      
      public function deserializeAs_EmotePlayMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._actorIdFunc(input);
         this._accountIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_EmotePlayMessage(tree);
      }
      
      public function deserializeAsyncAs_EmotePlayMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._actorIdFunc);
         tree.addChild(this._accountIdFunc);
      }
      
      private function _actorIdFunc(input:ICustomDataInput) : void
      {
         this.actorId = input.readDouble();
         if(this.actorId < -9007199254740992 || this.actorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.actorId + ") on element of EmotePlayMessage.actorId.");
         }
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of EmotePlayMessage.accountId.");
         }
      }
   }
}
