package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalGuildPublicInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.dofus.network.types.game.social.GuildFactSheetInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildInAllianceFactsMessage extends GuildFactsMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4511;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceInfos:BasicNamedAllianceInformations;
      
      private var _allianceInfostree:FuncTree;
      
      public function GuildInAllianceFactsMessage()
      {
         this.allianceInfos = new BasicNamedAllianceInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4511;
      }
      
      public function initGuildInAllianceFactsMessage(infos:GuildFactSheetInformations = null, creationDate:uint = 0, nbTaxCollectors:uint = 0, members:Vector.<CharacterMinimalGuildPublicInformations> = null, allianceInfos:BasicNamedAllianceInformations = null) : GuildInAllianceFactsMessage
      {
         super.initGuildFactsMessage(infos,creationDate,nbTaxCollectors,members);
         this.allianceInfos = allianceInfos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.allianceInfos = new BasicNamedAllianceInformations();
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
         this.serializeAs_GuildInAllianceFactsMessage(output);
      }
      
      public function serializeAs_GuildInAllianceFactsMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GuildFactsMessage(output);
         this.allianceInfos.serializeAs_BasicNamedAllianceInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInAllianceFactsMessage(input);
      }
      
      public function deserializeAs_GuildInAllianceFactsMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.allianceInfos = new BasicNamedAllianceInformations();
         this.allianceInfos.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInAllianceFactsMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildInAllianceFactsMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._allianceInfostree = tree.addChild(this._allianceInfostreeFunc);
      }
      
      private function _allianceInfostreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInfos = new BasicNamedAllianceInformations();
         this.allianceInfos.deserializeAsync(this._allianceInfostree);
      }
   }
}
