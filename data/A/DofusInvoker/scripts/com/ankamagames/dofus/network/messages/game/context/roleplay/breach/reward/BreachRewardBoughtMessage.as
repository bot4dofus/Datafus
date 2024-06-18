package com.ankamagames.dofus.network.messages.game.context.roleplay.breach.reward
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachRewardBoughtMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 560;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:uint = 0;
      
      public var bought:Boolean = false;
      
      public function BreachRewardBoughtMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 560;
      }
      
      public function initBreachRewardBoughtMessage(id:uint = 0, bought:Boolean = false) : BreachRewardBoughtMessage
      {
         this.id = id;
         this.bought = bought;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.bought = false;
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
         this.serializeAs_BreachRewardBoughtMessage(output);
      }
      
      public function serializeAs_BreachRewardBoughtMessage(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarInt(this.id);
         output.writeBoolean(this.bought);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachRewardBoughtMessage(input);
      }
      
      public function deserializeAs_BreachRewardBoughtMessage(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._boughtFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachRewardBoughtMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachRewardBoughtMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._boughtFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of BreachRewardBoughtMessage.id.");
         }
      }
      
      private function _boughtFunc(input:ICustomDataInput) : void
      {
         this.bought = input.readBoolean();
      }
   }
}
