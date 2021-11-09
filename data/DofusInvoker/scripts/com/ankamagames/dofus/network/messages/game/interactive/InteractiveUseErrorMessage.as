package com.ankamagames.dofus.network.messages.game.interactive
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class InteractiveUseErrorMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9420;
       
      
      private var _isInitialized:Boolean = false;
      
      public var elemId:uint = 0;
      
      public var skillInstanceUid:uint = 0;
      
      public function InteractiveUseErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9420;
      }
      
      public function initInteractiveUseErrorMessage(elemId:uint = 0, skillInstanceUid:uint = 0) : InteractiveUseErrorMessage
      {
         this.elemId = elemId;
         this.skillInstanceUid = skillInstanceUid;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.elemId = 0;
         this.skillInstanceUid = 0;
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
         this.serializeAs_InteractiveUseErrorMessage(output);
      }
      
      public function serializeAs_InteractiveUseErrorMessage(output:ICustomDataOutput) : void
      {
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element elemId.");
         }
         output.writeVarInt(this.elemId);
         if(this.skillInstanceUid < 0)
         {
            throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element skillInstanceUid.");
         }
         output.writeVarInt(this.skillInstanceUid);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveUseErrorMessage(input);
      }
      
      public function deserializeAs_InteractiveUseErrorMessage(input:ICustomDataInput) : void
      {
         this._elemIdFunc(input);
         this._skillInstanceUidFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InteractiveUseErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_InteractiveUseErrorMessage(tree:FuncTree) : void
      {
         tree.addChild(this._elemIdFunc);
         tree.addChild(this._skillInstanceUidFunc);
      }
      
      private function _elemIdFunc(input:ICustomDataInput) : void
      {
         this.elemId = input.readVarUhInt();
         if(this.elemId < 0)
         {
            throw new Error("Forbidden value (" + this.elemId + ") on element of InteractiveUseErrorMessage.elemId.");
         }
      }
      
      private function _skillInstanceUidFunc(input:ICustomDataInput) : void
      {
         this.skillInstanceUid = input.readVarUhInt();
         if(this.skillInstanceUid < 0)
         {
            throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element of InteractiveUseErrorMessage.skillInstanceUid.");
         }
      }
   }
}
