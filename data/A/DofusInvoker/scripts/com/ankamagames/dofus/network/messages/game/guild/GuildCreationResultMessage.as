package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildCreationResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4018;
       
      
      private var _isInitialized:Boolean = false;
      
      public var result:uint = 0;
      
      public function GuildCreationResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4018;
      }
      
      public function initGuildCreationResultMessage(result:uint = 0) : GuildCreationResultMessage
      {
         this.result = result;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.result = 0;
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
         this.serializeAs_GuildCreationResultMessage(output);
      }
      
      public function serializeAs_GuildCreationResultMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.result);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildCreationResultMessage(input);
      }
      
      public function deserializeAs_GuildCreationResultMessage(input:ICustomDataInput) : void
      {
         this._resultFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildCreationResultMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildCreationResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._resultFunc);
      }
      
      private function _resultFunc(input:ICustomDataInput) : void
      {
         this.result = input.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of GuildCreationResultMessage.result.");
         }
      }
   }
}
