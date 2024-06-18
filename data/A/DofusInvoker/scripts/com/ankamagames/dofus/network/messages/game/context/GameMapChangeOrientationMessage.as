package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.dofus.network.types.game.context.ActorOrientation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameMapChangeOrientationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8741;
       
      
      private var _isInitialized:Boolean = false;
      
      public var orientation:ActorOrientation;
      
      private var _orientationtree:FuncTree;
      
      public function GameMapChangeOrientationMessage()
      {
         this.orientation = new ActorOrientation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8741;
      }
      
      public function initGameMapChangeOrientationMessage(orientation:ActorOrientation = null) : GameMapChangeOrientationMessage
      {
         this.orientation = orientation;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.orientation = new ActorOrientation();
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
         this.serializeAs_GameMapChangeOrientationMessage(output);
      }
      
      public function serializeAs_GameMapChangeOrientationMessage(output:ICustomDataOutput) : void
      {
         this.orientation.serializeAs_ActorOrientation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameMapChangeOrientationMessage(input);
      }
      
      public function deserializeAs_GameMapChangeOrientationMessage(input:ICustomDataInput) : void
      {
         this.orientation = new ActorOrientation();
         this.orientation.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameMapChangeOrientationMessage(tree);
      }
      
      public function deserializeAsyncAs_GameMapChangeOrientationMessage(tree:FuncTree) : void
      {
         this._orientationtree = tree.addChild(this._orientationtreeFunc);
      }
      
      private function _orientationtreeFunc(input:ICustomDataInput) : void
      {
         this.orientation = new ActorOrientation();
         this.orientation.deserializeAsync(this._orientationtree);
      }
   }
}
