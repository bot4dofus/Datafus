package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildFightJoinRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1426;
       
      
      private var _isInitialized:Boolean = false;
      
      public var taxCollectorId:Number = 0;
      
      public function GuildFightJoinRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1426;
      }
      
      public function initGuildFightJoinRequestMessage(taxCollectorId:Number = 0) : GuildFightJoinRequestMessage
      {
         this.taxCollectorId = taxCollectorId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.taxCollectorId = 0;
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
         this.serializeAs_GuildFightJoinRequestMessage(output);
      }
      
      public function serializeAs_GuildFightJoinRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element taxCollectorId.");
         }
         output.writeDouble(this.taxCollectorId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFightJoinRequestMessage(input);
      }
      
      public function deserializeAs_GuildFightJoinRequestMessage(input:ICustomDataInput) : void
      {
         this._taxCollectorIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildFightJoinRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildFightJoinRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._taxCollectorIdFunc);
      }
      
      private function _taxCollectorIdFunc(input:ICustomDataInput) : void
      {
         this.taxCollectorId = input.readDouble();
         if(this.taxCollectorId < 0 || this.taxCollectorId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.taxCollectorId + ") on element of GuildFightJoinRequestMessage.taxCollectorId.");
         }
      }
   }
}
