package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MountHarnessColorsUpdateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5226;
       
      
      private var _isInitialized:Boolean = false;
      
      public var useHarnessColors:Boolean = false;
      
      public function MountHarnessColorsUpdateRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5226;
      }
      
      public function initMountHarnessColorsUpdateRequestMessage(useHarnessColors:Boolean = false) : MountHarnessColorsUpdateRequestMessage
      {
         this.useHarnessColors = useHarnessColors;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.useHarnessColors = false;
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
         this.serializeAs_MountHarnessColorsUpdateRequestMessage(output);
      }
      
      public function serializeAs_MountHarnessColorsUpdateRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.useHarnessColors);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountHarnessColorsUpdateRequestMessage(input);
      }
      
      public function deserializeAs_MountHarnessColorsUpdateRequestMessage(input:ICustomDataInput) : void
      {
         this._useHarnessColorsFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountHarnessColorsUpdateRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_MountHarnessColorsUpdateRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._useHarnessColorsFunc);
      }
      
      private function _useHarnessColorsFunc(input:ICustomDataInput) : void
      {
         this.useHarnessColors = input.readBoolean();
      }
   }
}
