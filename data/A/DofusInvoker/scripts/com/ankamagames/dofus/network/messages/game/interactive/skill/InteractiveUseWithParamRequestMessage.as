package com.ankamagames.dofus.network.messages.game.interactive.skill
{
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseRequestMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class InteractiveUseWithParamRequestMessage extends InteractiveUseRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8437;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:int = 0;
      
      public function InteractiveUseWithParamRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8437;
      }
      
      public function initInteractiveUseWithParamRequestMessage(elemId:uint = 0, skillInstanceUid:uint = 0, id:int = 0) : InteractiveUseWithParamRequestMessage
      {
         super.initInteractiveUseRequestMessage(elemId,skillInstanceUid);
         this.id = id;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.id = 0;
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
         this.serializeAs_InteractiveUseWithParamRequestMessage(output);
      }
      
      public function serializeAs_InteractiveUseWithParamRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_InteractiveUseRequestMessage(output);
         output.writeInt(this.id);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_InteractiveUseWithParamRequestMessage(input);
      }
      
      public function deserializeAs_InteractiveUseWithParamRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._idFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_InteractiveUseWithParamRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_InteractiveUseWithParamRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._idFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readInt();
      }
   }
}
