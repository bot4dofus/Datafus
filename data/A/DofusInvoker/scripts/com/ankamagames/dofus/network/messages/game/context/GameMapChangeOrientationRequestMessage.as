package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameMapChangeOrientationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1190;
       
      
      private var _isInitialized:Boolean = false;
      
      public var direction:uint = 1;
      
      public function GameMapChangeOrientationRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1190;
      }
      
      public function initGameMapChangeOrientationRequestMessage(direction:uint = 1) : GameMapChangeOrientationRequestMessage
      {
         this.direction = direction;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.direction = 1;
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
         this.serializeAs_GameMapChangeOrientationRequestMessage(output);
      }
      
      public function serializeAs_GameMapChangeOrientationRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.direction);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameMapChangeOrientationRequestMessage(input);
      }
      
      public function deserializeAs_GameMapChangeOrientationRequestMessage(input:ICustomDataInput) : void
      {
         this._directionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameMapChangeOrientationRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GameMapChangeOrientationRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._directionFunc);
      }
      
      private function _directionFunc(input:ICustomDataInput) : void
      {
         this.direction = input.readByte();
         if(this.direction < 0)
         {
            throw new Error("Forbidden value (" + this.direction + ") on element of GameMapChangeOrientationRequestMessage.direction.");
         }
      }
   }
}
