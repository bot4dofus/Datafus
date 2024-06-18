package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.dofus.network.types.game.paddock.PaddockItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameDataPaddockObjectAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 652;
       
      
      private var _isInitialized:Boolean = false;
      
      public var paddockItemDescription:PaddockItem;
      
      private var _paddockItemDescriptiontree:FuncTree;
      
      public function GameDataPaddockObjectAddMessage()
      {
         this.paddockItemDescription = new PaddockItem();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 652;
      }
      
      public function initGameDataPaddockObjectAddMessage(paddockItemDescription:PaddockItem = null) : GameDataPaddockObjectAddMessage
      {
         this.paddockItemDescription = paddockItemDescription;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.paddockItemDescription = new PaddockItem();
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
         this.serializeAs_GameDataPaddockObjectAddMessage(output);
      }
      
      public function serializeAs_GameDataPaddockObjectAddMessage(output:ICustomDataOutput) : void
      {
         this.paddockItemDescription.serializeAs_PaddockItem(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameDataPaddockObjectAddMessage(input);
      }
      
      public function deserializeAs_GameDataPaddockObjectAddMessage(input:ICustomDataInput) : void
      {
         this.paddockItemDescription = new PaddockItem();
         this.paddockItemDescription.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameDataPaddockObjectAddMessage(tree);
      }
      
      public function deserializeAsyncAs_GameDataPaddockObjectAddMessage(tree:FuncTree) : void
      {
         this._paddockItemDescriptiontree = tree.addChild(this._paddockItemDescriptiontreeFunc);
      }
      
      private function _paddockItemDescriptiontreeFunc(input:ICustomDataInput) : void
      {
         this.paddockItemDescription = new PaddockItem();
         this.paddockItemDescription.deserializeAsync(this._paddockItemDescriptiontree);
      }
   }
}
