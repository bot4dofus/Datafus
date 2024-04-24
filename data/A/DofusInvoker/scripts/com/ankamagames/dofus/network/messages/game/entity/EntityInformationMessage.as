package com.ankamagames.dofus.network.messages.game.entity
{
   import com.ankamagames.dofus.network.types.game.entity.EntityInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class EntityInformationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9079;
       
      
      private var _isInitialized:Boolean = false;
      
      public var entity:EntityInformation;
      
      private var _entitytree:FuncTree;
      
      public function EntityInformationMessage()
      {
         this.entity = new EntityInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9079;
      }
      
      public function initEntityInformationMessage(entity:EntityInformation = null) : EntityInformationMessage
      {
         this.entity = entity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.entity = new EntityInformation();
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
         this.serializeAs_EntityInformationMessage(output);
      }
      
      public function serializeAs_EntityInformationMessage(output:ICustomDataOutput) : void
      {
         this.entity.serializeAs_EntityInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_EntityInformationMessage(input);
      }
      
      public function deserializeAs_EntityInformationMessage(input:ICustomDataInput) : void
      {
         this.entity = new EntityInformation();
         this.entity.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_EntityInformationMessage(tree);
      }
      
      public function deserializeAsyncAs_EntityInformationMessage(tree:FuncTree) : void
      {
         this._entitytree = tree.addChild(this._entitytreeFunc);
      }
      
      private function _entitytreeFunc(input:ICustomDataInput) : void
      {
         this.entity = new EntityInformation();
         this.entity.deserializeAsync(this._entitytree);
      }
   }
}
