package com.ankamagames.dofus.network.messages.game.context.roleplay.breach.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachKickRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4588;
       
      
      private var _isInitialized:Boolean = false;
      
      public var target:Number = 0;
      
      public function BreachKickRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4588;
      }
      
      public function initBreachKickRequestMessage(target:Number = 0) : BreachKickRequestMessage
      {
         this.target = target;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.target = 0;
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
         this.serializeAs_BreachKickRequestMessage(output);
      }
      
      public function serializeAs_BreachKickRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.target < 0 || this.target > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.target + ") on element target.");
         }
         output.writeVarLong(this.target);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachKickRequestMessage(input);
      }
      
      public function deserializeAs_BreachKickRequestMessage(input:ICustomDataInput) : void
      {
         this._targetFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachKickRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachKickRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._targetFunc);
      }
      
      private function _targetFunc(input:ICustomDataInput) : void
      {
         this.target = input.readVarUhLong();
         if(this.target < 0 || this.target > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.target + ") on element of BreachKickRequestMessage.target.");
         }
      }
   }
}
