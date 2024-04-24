package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.inventory.UpdatedStorageTabInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildUpdateChestTabRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7784;
       
      
      private var _isInitialized:Boolean = false;
      
      public var tab:UpdatedStorageTabInformation;
      
      private var _tabtree:FuncTree;
      
      public function GuildUpdateChestTabRequestMessage()
      {
         this.tab = new UpdatedStorageTabInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7784;
      }
      
      public function initGuildUpdateChestTabRequestMessage(tab:UpdatedStorageTabInformation = null) : GuildUpdateChestTabRequestMessage
      {
         this.tab = tab;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.tab = new UpdatedStorageTabInformation();
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
         this.serializeAs_GuildUpdateChestTabRequestMessage(output);
      }
      
      public function serializeAs_GuildUpdateChestTabRequestMessage(output:ICustomDataOutput) : void
      {
         this.tab.serializeAs_UpdatedStorageTabInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildUpdateChestTabRequestMessage(input);
      }
      
      public function deserializeAs_GuildUpdateChestTabRequestMessage(input:ICustomDataInput) : void
      {
         this.tab = new UpdatedStorageTabInformation();
         this.tab.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildUpdateChestTabRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildUpdateChestTabRequestMessage(tree:FuncTree) : void
      {
         this._tabtree = tree.addChild(this._tabtreeFunc);
      }
      
      private function _tabtreeFunc(input:ICustomDataInput) : void
      {
         this.tab = new UpdatedStorageTabInformation();
         this.tab.deserializeAsync(this._tabtree);
      }
   }
}
