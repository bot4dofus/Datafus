package com.ankamagames.dofus.network.messages.game.character.alteration
{
   import com.ankamagames.dofus.network.types.game.character.alteration.AlterationInfo;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AlterationRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 565;
       
      
      private var _isInitialized:Boolean = false;
      
      public var alteration:AlterationInfo;
      
      private var _alterationtree:FuncTree;
      
      public function AlterationRemovedMessage()
      {
         this.alteration = new AlterationInfo();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 565;
      }
      
      public function initAlterationRemovedMessage(alteration:AlterationInfo = null) : AlterationRemovedMessage
      {
         this.alteration = alteration;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.alteration = new AlterationInfo();
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
         this.serializeAs_AlterationRemovedMessage(output);
      }
      
      public function serializeAs_AlterationRemovedMessage(output:ICustomDataOutput) : void
      {
         this.alteration.serializeAs_AlterationInfo(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlterationRemovedMessage(input);
      }
      
      public function deserializeAs_AlterationRemovedMessage(input:ICustomDataInput) : void
      {
         this.alteration = new AlterationInfo();
         this.alteration.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlterationRemovedMessage(tree);
      }
      
      public function deserializeAsyncAs_AlterationRemovedMessage(tree:FuncTree) : void
      {
         this._alterationtree = tree.addChild(this._alterationtreeFunc);
      }
      
      private function _alterationtreeFunc(input:ICustomDataInput) : void
      {
         this.alteration = new AlterationInfo();
         this.alteration.deserializeAsync(this._alterationtree);
      }
   }
}
