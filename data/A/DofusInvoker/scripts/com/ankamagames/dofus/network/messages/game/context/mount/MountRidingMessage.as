package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MountRidingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3880;
       
      
      private var _isInitialized:Boolean = false;
      
      public var isRiding:Boolean = false;
      
      public var isAutopilot:Boolean = false;
      
      public function MountRidingMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3880;
      }
      
      public function initMountRidingMessage(isRiding:Boolean = false, isAutopilot:Boolean = false) : MountRidingMessage
      {
         this.isRiding = isRiding;
         this.isAutopilot = isAutopilot;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.isRiding = false;
         this.isAutopilot = false;
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
         this.serializeAs_MountRidingMessage(output);
      }
      
      public function serializeAs_MountRidingMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.isRiding);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.isAutopilot);
         output.writeByte(_box0);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountRidingMessage(input);
      }
      
      public function deserializeAs_MountRidingMessage(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountRidingMessage(tree);
      }
      
      public function deserializeAsyncAs_MountRidingMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.isRiding = BooleanByteWrapper.getFlag(_box0,0);
         this.isAutopilot = BooleanByteWrapper.getFlag(_box0,1);
      }
   }
}
