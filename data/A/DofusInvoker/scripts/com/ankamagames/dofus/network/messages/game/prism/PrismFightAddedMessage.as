package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.dofus.network.types.game.prism.PrismFightersInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismFightAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4874;
       
      
      private var _isInitialized:Boolean = false;
      
      public var fight:PrismFightersInformation;
      
      private var _fighttree:FuncTree;
      
      public function PrismFightAddedMessage()
      {
         this.fight = new PrismFightersInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4874;
      }
      
      public function initPrismFightAddedMessage(fight:PrismFightersInformation = null) : PrismFightAddedMessage
      {
         this.fight = fight;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.fight = new PrismFightersInformation();
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
         this.serializeAs_PrismFightAddedMessage(output);
      }
      
      public function serializeAs_PrismFightAddedMessage(output:ICustomDataOutput) : void
      {
         this.fight.serializeAs_PrismFightersInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismFightAddedMessage(input);
      }
      
      public function deserializeAs_PrismFightAddedMessage(input:ICustomDataInput) : void
      {
         this.fight = new PrismFightersInformation();
         this.fight.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismFightAddedMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismFightAddedMessage(tree:FuncTree) : void
      {
         this._fighttree = tree.addChild(this._fighttreeFunc);
      }
      
      private function _fighttreeFunc(input:ICustomDataInput) : void
      {
         this.fight = new PrismFightersInformation();
         this.fight.deserializeAsync(this._fighttree);
      }
   }
}
