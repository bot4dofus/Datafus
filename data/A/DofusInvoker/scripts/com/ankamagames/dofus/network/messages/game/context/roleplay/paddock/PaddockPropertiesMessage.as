package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
   import com.ankamagames.dofus.network.types.game.paddock.PaddockInstancesInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PaddockPropertiesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4650;
       
      
      private var _isInitialized:Boolean = false;
      
      public var properties:PaddockInstancesInformations;
      
      private var _propertiestree:FuncTree;
      
      public function PaddockPropertiesMessage()
      {
         this.properties = new PaddockInstancesInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4650;
      }
      
      public function initPaddockPropertiesMessage(properties:PaddockInstancesInformations = null) : PaddockPropertiesMessage
      {
         this.properties = properties;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.properties = new PaddockInstancesInformations();
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
         this.serializeAs_PaddockPropertiesMessage(output);
      }
      
      public function serializeAs_PaddockPropertiesMessage(output:ICustomDataOutput) : void
      {
         this.properties.serializeAs_PaddockInstancesInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockPropertiesMessage(input);
      }
      
      public function deserializeAs_PaddockPropertiesMessage(input:ICustomDataInput) : void
      {
         this.properties = new PaddockInstancesInformations();
         this.properties.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockPropertiesMessage(tree);
      }
      
      public function deserializeAsyncAs_PaddockPropertiesMessage(tree:FuncTree) : void
      {
         this._propertiestree = tree.addChild(this._propertiestreeFunc);
      }
      
      private function _propertiestreeFunc(input:ICustomDataInput) : void
      {
         this.properties = new PaddockInstancesInformations();
         this.properties.deserializeAsync(this._propertiestree);
      }
   }
}
