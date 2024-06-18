package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameContextCreateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1595;
       
      
      private var _isInitialized:Boolean = false;
      
      public var context:uint = 1;
      
      public function GameContextCreateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1595;
      }
      
      public function initGameContextCreateMessage(context:uint = 1) : GameContextCreateMessage
      {
         this.context = context;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.context = 1;
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
         this.serializeAs_GameContextCreateMessage(output);
      }
      
      public function serializeAs_GameContextCreateMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.context);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextCreateMessage(input);
      }
      
      public function deserializeAs_GameContextCreateMessage(input:ICustomDataInput) : void
      {
         this._contextFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameContextCreateMessage(tree);
      }
      
      public function deserializeAsyncAs_GameContextCreateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._contextFunc);
      }
      
      private function _contextFunc(input:ICustomDataInput) : void
      {
         this.context = input.readByte();
         if(this.context < 0)
         {
            throw new Error("Forbidden value (" + this.context + ") on element of GameContextCreateMessage.context.");
         }
      }
   }
}
