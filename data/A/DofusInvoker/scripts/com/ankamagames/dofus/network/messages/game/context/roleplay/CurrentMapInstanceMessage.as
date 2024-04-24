package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CurrentMapInstanceMessage extends CurrentMapMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4338;
       
      
      private var _isInitialized:Boolean = false;
      
      public var instantiatedMapId:Number = 0;
      
      public function CurrentMapInstanceMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4338;
      }
      
      public function initCurrentMapInstanceMessage(mapId:Number = 0, instantiatedMapId:Number = 0) : CurrentMapInstanceMessage
      {
         super.initCurrentMapMessage(mapId);
         this.instantiatedMapId = instantiatedMapId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.instantiatedMapId = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CurrentMapInstanceMessage(output);
      }
      
      public function serializeAs_CurrentMapInstanceMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_CurrentMapMessage(output);
         if(this.instantiatedMapId < 0 || this.instantiatedMapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.instantiatedMapId + ") on element instantiatedMapId.");
         }
         output.writeDouble(this.instantiatedMapId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CurrentMapInstanceMessage(input);
      }
      
      public function deserializeAs_CurrentMapInstanceMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._instantiatedMapIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CurrentMapInstanceMessage(tree);
      }
      
      public function deserializeAsyncAs_CurrentMapInstanceMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._instantiatedMapIdFunc);
      }
      
      private function _instantiatedMapIdFunc(input:ICustomDataInput) : void
      {
         this.instantiatedMapId = input.readDouble();
         if(this.instantiatedMapId < 0 || this.instantiatedMapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.instantiatedMapId + ") on element of CurrentMapInstanceMessage.instantiatedMapId.");
         }
      }
   }
}
