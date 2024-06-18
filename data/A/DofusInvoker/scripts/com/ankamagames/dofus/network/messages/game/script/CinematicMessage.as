package com.ankamagames.dofus.network.messages.game.script
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CinematicMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 991;
       
      
      private var _isInitialized:Boolean = false;
      
      public var cinematicId:uint = 0;
      
      public function CinematicMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 991;
      }
      
      public function initCinematicMessage(cinematicId:uint = 0) : CinematicMessage
      {
         this.cinematicId = cinematicId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.cinematicId = 0;
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
         this.serializeAs_CinematicMessage(output);
      }
      
      public function serializeAs_CinematicMessage(output:ICustomDataOutput) : void
      {
         if(this.cinematicId < 0)
         {
            throw new Error("Forbidden value (" + this.cinematicId + ") on element cinematicId.");
         }
         output.writeVarShort(this.cinematicId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CinematicMessage(input);
      }
      
      public function deserializeAs_CinematicMessage(input:ICustomDataInput) : void
      {
         this._cinematicIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CinematicMessage(tree);
      }
      
      public function deserializeAsyncAs_CinematicMessage(tree:FuncTree) : void
      {
         tree.addChild(this._cinematicIdFunc);
      }
      
      private function _cinematicIdFunc(input:ICustomDataInput) : void
      {
         this.cinematicId = input.readVarUhShort();
         if(this.cinematicId < 0)
         {
            throw new Error("Forbidden value (" + this.cinematicId + ") on element of CinematicMessage.cinematicId.");
         }
      }
   }
}
