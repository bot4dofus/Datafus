package com.ankamagames.dofus.network.messages.game.context.roleplay.objects
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ObjectGroundRemovedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3376;
       
      
      private var _isInitialized:Boolean = false;
      
      public var cell:uint = 0;
      
      public function ObjectGroundRemovedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3376;
      }
      
      public function initObjectGroundRemovedMessage(cell:uint = 0) : ObjectGroundRemovedMessage
      {
         this.cell = cell;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.cell = 0;
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
         this.serializeAs_ObjectGroundRemovedMessage(output);
      }
      
      public function serializeAs_ObjectGroundRemovedMessage(output:ICustomDataOutput) : void
      {
         if(this.cell < 0 || this.cell > 559)
         {
            throw new Error("Forbidden value (" + this.cell + ") on element cell.");
         }
         output.writeVarShort(this.cell);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectGroundRemovedMessage(input);
      }
      
      public function deserializeAs_ObjectGroundRemovedMessage(input:ICustomDataInput) : void
      {
         this._cellFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectGroundRemovedMessage(tree);
      }
      
      public function deserializeAsyncAs_ObjectGroundRemovedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._cellFunc);
      }
      
      private function _cellFunc(input:ICustomDataInput) : void
      {
         this.cell = input.readVarUhShort();
         if(this.cell < 0 || this.cell > 559)
         {
            throw new Error("Forbidden value (" + this.cell + ") on element of ObjectGroundRemovedMessage.cell.");
         }
      }
   }
}
