package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildGetInformationsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 592;
       
      
      private var _isInitialized:Boolean = false;
      
      public var infoType:uint = 0;
      
      public function GuildGetInformationsMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 592;
      }
      
      public function initGuildGetInformationsMessage(infoType:uint = 0) : GuildGetInformationsMessage
      {
         this.infoType = infoType;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.infoType = 0;
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
         this.serializeAs_GuildGetInformationsMessage(output);
      }
      
      public function serializeAs_GuildGetInformationsMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.infoType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildGetInformationsMessage(input);
      }
      
      public function deserializeAs_GuildGetInformationsMessage(input:ICustomDataInput) : void
      {
         this._infoTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildGetInformationsMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildGetInformationsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._infoTypeFunc);
      }
      
      private function _infoTypeFunc(input:ICustomDataInput) : void
      {
         this.infoType = input.readByte();
         if(this.infoType < 0)
         {
            throw new Error("Forbidden value (" + this.infoType + ") on element of GuildGetInformationsMessage.infoType.");
         }
      }
   }
}
