package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class InteractiveUseEndedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 467;
       
      
      private var _isInitialized:Boolean = false;
      
      public var elemId:uint = 0;
      
      public var skillId:uint = 0;
      
      public function InteractiveUseEndedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 467;
      }
      
      public function initInteractiveUseEndedMessage(elemId:uint = 0, skillId:uint = 0) : InteractiveUseEndedMessage
      {
         this.elemId = elemId;
         this.skillId = skillId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.elemId = 0;
         this.skillId = 0;
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
         this.serializeAs_InteractiveUseEndedMessage(output);
      }
      
      public function serializeAs_InteractiveUseEndedMessage(output:ICustomDataOutput) : void
      {
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element elemId.");
         }
         output.writeVarInt(this.elemId);
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
         }
         output.writeVarShort(this.skillId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveUseEndedMessage(input);
      }
      
      public function deserializeAs_InteractiveUseEndedMessage(input:ICustomDataInput) : void
      {
         this._elemIdFunc(input);
         this._skillIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InteractiveUseEndedMessage(tree);
      }
      
      public function deserializeAsyncAs_InteractiveUseEndedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._elemIdFunc);
         tree.addChild(this._skillIdFunc);
      }
      
      private function _elemIdFunc(input:ICustomDataInput) : void
      {
         this.elemId = input.readVarUhInt();
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element of InteractiveUseEndedMessage.elemId.");
         }
      }
      
      private function _skillIdFunc(input:ICustomDataInput) : void
      {
         this.skillId = input.readVarUhShort();
         if(this.skillId < 0)
         {
            throw new Error("Forbidden value (" + this.skillId + ") on element of InteractiveUseEndedMessage.skillId.");
         }
      }
   }
}
