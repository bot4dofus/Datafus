package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.house.HouseInformationsForGuild;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildHouseUpdateInformationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9569;
       
      
      private var _isInitialized:Boolean = false;
      
      public var housesInformations:HouseInformationsForGuild;
      
      private var _housesInformationstree:FuncTree;
      
      public function GuildHouseUpdateInformationMessage()
      {
         this.housesInformations = new HouseInformationsForGuild();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9569;
      }
      
      public function initGuildHouseUpdateInformationMessage(housesInformations:HouseInformationsForGuild = null) : GuildHouseUpdateInformationMessage
      {
         this.housesInformations = housesInformations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.housesInformations = new HouseInformationsForGuild();
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
         this.serializeAs_GuildHouseUpdateInformationMessage(output);
      }
      
      public function serializeAs_GuildHouseUpdateInformationMessage(output:ICustomDataOutput) : void
      {
         this.housesInformations.serializeAs_HouseInformationsForGuild(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildHouseUpdateInformationMessage(input);
      }
      
      public function deserializeAs_GuildHouseUpdateInformationMessage(input:ICustomDataInput) : void
      {
         this.housesInformations = new HouseInformationsForGuild();
         this.housesInformations.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildHouseUpdateInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildHouseUpdateInformationMessage(tree:FuncTree) : void
      {
         this._housesInformationstree = tree.addChild(this._housesInformationstreeFunc);
      }
      
      private function _housesInformationstreeFunc(input:ICustomDataInput) : void
      {
         this.housesInformations = new HouseInformationsForGuild();
         this.housesInformations.deserializeAsync(this._housesInformationstree);
      }
   }
}
