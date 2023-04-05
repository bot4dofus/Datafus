package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceChangeGuildRightsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1555;
       
      
      private var _isInitialized:Boolean = false;
      
      public var guildId:uint = 0;
      
      public var rights:uint = 0;
      
      public function AllianceChangeGuildRightsMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1555;
      }
      
      public function initAllianceChangeGuildRightsMessage(guildId:uint = 0, rights:uint = 0) : AllianceChangeGuildRightsMessage
      {
         this.guildId = guildId;
         this.rights = rights;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.guildId = 0;
         this.rights = 0;
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
         this.serializeAs_AllianceChangeGuildRightsMessage(output);
      }
      
      public function serializeAs_AllianceChangeGuildRightsMessage(output:ICustomDataOutput) : void
      {
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element guildId.");
         }
         output.writeVarInt(this.guildId);
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element rights.");
         }
         output.writeByte(this.rights);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceChangeGuildRightsMessage(input);
      }
      
      public function deserializeAs_AllianceChangeGuildRightsMessage(input:ICustomDataInput) : void
      {
         this._guildIdFunc(input);
         this._rightsFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceChangeGuildRightsMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceChangeGuildRightsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._guildIdFunc);
         tree.addChild(this._rightsFunc);
      }
      
      private function _guildIdFunc(input:ICustomDataInput) : void
      {
         this.guildId = input.readVarUhInt();
         if(this.guildId < 0)
         {
            throw new Error("Forbidden value (" + this.guildId + ") on element of AllianceChangeGuildRightsMessage.guildId.");
         }
      }
      
      private function _rightsFunc(input:ICustomDataInput) : void
      {
         this.rights = input.readByte();
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element of AllianceChangeGuildRightsMessage.rights.");
         }
      }
   }
}
