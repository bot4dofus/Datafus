package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildFightTakePlaceRequestMessage extends GuildFightJoinRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6277;
       
      
      private var _isInitialized:Boolean = false;
      
      public var replacedCharacterId:Number = 0;
      
      public function GuildFightTakePlaceRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6277;
      }
      
      public function initGuildFightTakePlaceRequestMessage(taxCollectorId:Number = 0, replacedCharacterId:Number = 0) : GuildFightTakePlaceRequestMessage
      {
         super.initGuildFightJoinRequestMessage(taxCollectorId);
         this.replacedCharacterId = replacedCharacterId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.replacedCharacterId = 0;
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
         this.serializeAs_GuildFightTakePlaceRequestMessage(output);
      }
      
      public function serializeAs_GuildFightTakePlaceRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildFightJoinRequestMessage(output);
         if(this.replacedCharacterId < 0 || this.replacedCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.replacedCharacterId + ") on element replacedCharacterId.");
         }
         output.writeVarLong(this.replacedCharacterId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildFightTakePlaceRequestMessage(input);
      }
      
      public function deserializeAs_GuildFightTakePlaceRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._replacedCharacterIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildFightTakePlaceRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildFightTakePlaceRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._replacedCharacterIdFunc);
      }
      
      private function _replacedCharacterIdFunc(input:ICustomDataInput) : void
      {
         this.replacedCharacterId = input.readVarUhLong();
         if(this.replacedCharacterId < 0 || this.replacedCharacterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.replacedCharacterId + ") on element of GuildFightTakePlaceRequestMessage.replacedCharacterId.");
         }
      }
   }
}
