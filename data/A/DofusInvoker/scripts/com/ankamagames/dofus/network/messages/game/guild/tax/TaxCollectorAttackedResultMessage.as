package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorBasicInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorAttackedResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1359;
       
      
      private var _isInitialized:Boolean = false;
      
      public var deadOrAlive:Boolean = false;
      
      public var basicInfos:TaxCollectorBasicInformations;
      
      public var guild:BasicGuildInformations;
      
      private var _basicInfostree:FuncTree;
      
      private var _guildtree:FuncTree;
      
      public function TaxCollectorAttackedResultMessage()
      {
         this.basicInfos = new TaxCollectorBasicInformations();
         this.guild = new BasicGuildInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1359;
      }
      
      public function initTaxCollectorAttackedResultMessage(deadOrAlive:Boolean = false, basicInfos:TaxCollectorBasicInformations = null, guild:BasicGuildInformations = null) : TaxCollectorAttackedResultMessage
      {
         this.deadOrAlive = deadOrAlive;
         this.basicInfos = basicInfos;
         this.guild = guild;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.deadOrAlive = false;
         this.basicInfos = new TaxCollectorBasicInformations();
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
         this.serializeAs_TaxCollectorAttackedResultMessage(output);
      }
      
      public function serializeAs_TaxCollectorAttackedResultMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.deadOrAlive);
         this.basicInfos.serializeAs_TaxCollectorBasicInformations(output);
         this.guild.serializeAs_BasicGuildInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorAttackedResultMessage(input);
      }
      
      public function deserializeAs_TaxCollectorAttackedResultMessage(input:ICustomDataInput) : void
      {
         this._deadOrAliveFunc(input);
         this.basicInfos = new TaxCollectorBasicInformations();
         this.basicInfos.deserialize(input);
         this.guild = new BasicGuildInformations();
         this.guild.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorAttackedResultMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorAttackedResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._deadOrAliveFunc);
         this._basicInfostree = tree.addChild(this._basicInfostreeFunc);
         this._guildtree = tree.addChild(this._guildtreeFunc);
      }
      
      private function _deadOrAliveFunc(input:ICustomDataInput) : void
      {
         this.deadOrAlive = input.readBoolean();
      }
      
      private function _basicInfostreeFunc(input:ICustomDataInput) : void
      {
         this.basicInfos = new TaxCollectorBasicInformations();
         this.basicInfos.deserializeAsync(this._basicInfostree);
      }
      
      private function _guildtreeFunc(input:ICustomDataInput) : void
      {
         this.guild = new BasicGuildInformations();
         this.guild.deserializeAsync(this._guildtree);
      }
   }
}
