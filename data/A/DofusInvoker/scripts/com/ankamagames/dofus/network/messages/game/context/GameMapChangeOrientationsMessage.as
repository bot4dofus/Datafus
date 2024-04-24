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
   
   public class GameMapChangeOrientationsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3010;
       
      
      private var _isInitialized:Boolean = false;
      
      public var orientations:Vector.<ActorOrientation>;
      
      private var _orientationstree:FuncTree;
      
      public function GameMapChangeOrientationsMessage()
      {
         this.orientations = new Vector.<ActorOrientation>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3010;
      }
      
      public function initGameMapChangeOrientationsMessage(orientations:Vector.<ActorOrientation> = null) : GameMapChangeOrientationsMessage
      {
         this.orientations = orientations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.orientations = new Vector.<ActorOrientation>();
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
         this.serializeAs_GameMapChangeOrientationsMessage(output);
      }
      
      public function serializeAs_GameMapChangeOrientationsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.orientations.length);
         for(var _i1:uint = 0; _i1 < this.orientations.length; _i1++)
         {
            (this.orientations[_i1] as ActorOrientation).serializeAs_ActorOrientation(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameMapChangeOrientationsMessage(input);
      }
      
      public function deserializeAs_GameMapChangeOrientationsMessage(input:ICustomDataInput) : void
      {
         var _item1:ActorOrientation = null;
         var _orientationsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _orientationsLen; _i1++)
         {
            _item1 = new ActorOrientation();
            _item1.deserialize(input);
            this.orientations.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameMapChangeOrientationsMessage(tree);
      }
      
      public function deserializeAsyncAs_GameMapChangeOrientationsMessage(tree:FuncTree) : void
      {
         this._orientationstree = tree.addChild(this._orientationstreeFunc);
      }
      
      private function _orientationstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._orientationstree.addChild(this._orientationsFunc);
         }
      }
      
      private function _orientationsFunc(input:ICustomDataInput) : void
      {
         var _item:ActorOrientation = new ActorOrientation();
         _item.deserialize(input);
         this.orientations.push(_item);
      }
   }
}
