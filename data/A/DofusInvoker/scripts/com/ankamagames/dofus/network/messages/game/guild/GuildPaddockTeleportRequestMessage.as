package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildPaddockTeleportRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8533;
       
      
      private var _isInitialized:Boolean = false;
      
      public var paddockId:Number = 0;
      
      public function GuildPaddockTeleportRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8533;
      }
      
      public function initGuildPaddockTeleportRequestMessage(paddockId:Number = 0) : GuildPaddockTeleportRequestMessage
      {
         this.paddockId = paddockId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.paddockId = 0;
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
         this.serializeAs_GuildPaddockTeleportRequestMessage(output);
      }
      
      public function serializeAs_GuildPaddockTeleportRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.paddockId < 0 || this.paddockId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.paddockId + ") on element paddockId.");
         }
         output.writeDouble(this.paddockId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildPaddockTeleportRequestMessage(input);
      }
      
      public function deserializeAs_GuildPaddockTeleportRequestMessage(input:ICustomDataInput) : void
      {
         this._paddockIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildPaddockTeleportRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildPaddockTeleportRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._paddockIdFunc);
      }
      
      private function _paddockIdFunc(input:ICustomDataInput) : void
      {
         this.paddockId = input.readDouble();
         if(this.paddockId < 0 || this.paddockId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.paddockId + ") on element of GuildPaddockTeleportRequestMessage.paddockId.");
         }
      }
   }
}
