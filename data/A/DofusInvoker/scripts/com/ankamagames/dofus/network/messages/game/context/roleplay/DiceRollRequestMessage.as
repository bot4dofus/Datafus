package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class DiceRollRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8901;
       
      
      private var _isInitialized:Boolean = false;
      
      public var dice:uint = 0;
      
      public var faces:uint = 0;
      
      public var channel:uint = 0;
      
      public function DiceRollRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8901;
      }
      
      public function initDiceRollRequestMessage(dice:uint = 0, faces:uint = 0, channel:uint = 0) : DiceRollRequestMessage
      {
         this.dice = dice;
         this.faces = faces;
         this.channel = channel;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.dice = 0;
         this.faces = 0;
         this.channel = 0;
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
         this.serializeAs_DiceRollRequestMessage(output);
      }
      
      public function serializeAs_DiceRollRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.dice < 0)
         {
            throw new Error("Forbidden value (" + this.dice + ") on element dice.");
         }
         output.writeVarInt(this.dice);
         if(this.faces < 0)
         {
            throw new Error("Forbidden value (" + this.faces + ") on element faces.");
         }
         output.writeVarInt(this.faces);
         output.writeByte(this.channel);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_DiceRollRequestMessage(input);
      }
      
      public function deserializeAs_DiceRollRequestMessage(input:ICustomDataInput) : void
      {
         this._diceFunc(input);
         this._facesFunc(input);
         this._channelFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_DiceRollRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_DiceRollRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._diceFunc);
         tree.addChild(this._facesFunc);
         tree.addChild(this._channelFunc);
      }
      
      private function _diceFunc(input:ICustomDataInput) : void
      {
         this.dice = input.readVarUhInt();
         if(this.dice < 0)
         {
            throw new Error("Forbidden value (" + this.dice + ") on element of DiceRollRequestMessage.dice.");
         }
      }
      
      private function _facesFunc(input:ICustomDataInput) : void
      {
         this.faces = input.readVarUhInt();
         if(this.faces < 0)
         {
            throw new Error("Forbidden value (" + this.faces + ") on element of DiceRollRequestMessage.faces.");
         }
      }
      
      private function _channelFunc(input:ICustomDataInput) : void
      {
         this.channel = input.readByte();
         if(this.channel < 0)
         {
            throw new Error("Forbidden value (" + this.channel + ") on element of DiceRollRequestMessage.channel.");
         }
      }
   }
}
