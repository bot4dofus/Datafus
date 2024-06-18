package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MountInformationRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 826;
       
      
      private var _isInitialized:Boolean = false;
      
      public var id:Number = 0;
      
      public var time:Number = 0;
      
      public function MountInformationRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 826;
      }
      
      public function initMountInformationRequestMessage(id:Number = 0, time:Number = 0) : MountInformationRequestMessage
      {
         this.id = id;
         this.time = time;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.time = 0;
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
         this.serializeAs_MountInformationRequestMessage(output);
      }
      
      public function serializeAs_MountInformationRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeDouble(this.id);
         if(this.time < -9007199254740992 || this.time > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.time + ") on element time.");
         }
         output.writeDouble(this.time);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MountInformationRequestMessage(input);
      }
      
      public function deserializeAs_MountInformationRequestMessage(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._timeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MountInformationRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_MountInformationRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._timeFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readDouble();
         if(this.id < -9007199254740992 || this.id > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of MountInformationRequestMessage.id.");
         }
      }
      
      private function _timeFunc(input:ICustomDataInput) : void
      {
         this.time = input.readDouble();
         if(this.time < -9007199254740992 || this.time > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.time + ") on element of MountInformationRequestMessage.time.");
         }
      }
   }
}
