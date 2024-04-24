package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameCautiousMapMovementRequestMessage extends GameMapMovementRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5432;
       
      
      private var _isInitialized:Boolean = false;
      
      public function GameCautiousMapMovementRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5432;
      }
      
      public function initGameCautiousMapMovementRequestMessage(keyMovements:Vector.<uint> = null, mapId:Number = 0) : GameCautiousMapMovementRequestMessage
      {
         super.initGameMapMovementRequestMessage(keyMovements,mapId);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameCautiousMapMovementRequestMessage(output);
      }
      
      public function serializeAs_GameCautiousMapMovementRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameMapMovementRequestMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameCautiousMapMovementRequestMessage(input);
      }
      
      public function deserializeAs_GameCautiousMapMovementRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameCautiousMapMovementRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GameCautiousMapMovementRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
