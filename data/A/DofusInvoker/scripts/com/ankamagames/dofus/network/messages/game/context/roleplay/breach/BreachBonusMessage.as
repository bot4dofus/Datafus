package com.ankamagames.dofus.network.messages.game.context.roleplay.breach
{
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachBonusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 427;
       
      
      private var _isInitialized:Boolean = false;
      
      public var bonus:ObjectEffectInteger;
      
      private var _bonustree:FuncTree;
      
      public function BreachBonusMessage()
      {
         this.bonus = new ObjectEffectInteger();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 427;
      }
      
      public function initBreachBonusMessage(bonus:ObjectEffectInteger = null) : BreachBonusMessage
      {
         this.bonus = bonus;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.bonus = new ObjectEffectInteger();
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
         this.serializeAs_BreachBonusMessage(output);
      }
      
      public function serializeAs_BreachBonusMessage(output:ICustomDataOutput) : void
      {
         this.bonus.serializeAs_ObjectEffectInteger(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachBonusMessage(input);
      }
      
      public function deserializeAs_BreachBonusMessage(input:ICustomDataInput) : void
      {
         this.bonus = new ObjectEffectInteger();
         this.bonus.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachBonusMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachBonusMessage(tree:FuncTree) : void
      {
         this._bonustree = tree.addChild(this._bonustreeFunc);
      }
      
      private function _bonustreeFunc(input:ICustomDataInput) : void
      {
         this.bonus = new ObjectEffectInteger();
         this.bonus.deserializeAsync(this._bonustree);
      }
   }
}
