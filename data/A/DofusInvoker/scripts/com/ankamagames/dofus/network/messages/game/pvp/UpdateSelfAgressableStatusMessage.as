package com.ankamagames.dofus.network.messages.game.pvp
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class UpdateSelfAgressableStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5808;
       
      
      private var _isInitialized:Boolean = false;
      
      public var status:uint = 0;
      
      public var probationTime:Number = 0;
      
      public var roleAvAId:int = 0;
      
      public var pictoScore:int = 0;
      
      public function UpdateSelfAgressableStatusMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5808;
      }
      
      public function initUpdateSelfAgressableStatusMessage(status:uint = 0, probationTime:Number = 0, roleAvAId:int = 0, pictoScore:int = 0) : UpdateSelfAgressableStatusMessage
      {
         this.status = status;
         this.probationTime = probationTime;
         this.roleAvAId = roleAvAId;
         this.pictoScore = pictoScore;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.status = 0;
         this.probationTime = 0;
         this.roleAvAId = 0;
         this.pictoScore = 0;
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
         this.serializeAs_UpdateSelfAgressableStatusMessage(output);
      }
      
      public function serializeAs_UpdateSelfAgressableStatusMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.status);
         if(this.probationTime < 0 || this.probationTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.probationTime + ") on element probationTime.");
         }
         output.writeDouble(this.probationTime);
         output.writeInt(this.roleAvAId);
         output.writeInt(this.pictoScore);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateSelfAgressableStatusMessage(input);
      }
      
      public function deserializeAs_UpdateSelfAgressableStatusMessage(input:ICustomDataInput) : void
      {
         this._statusFunc(input);
         this._probationTimeFunc(input);
         this._roleAvAIdFunc(input);
         this._pictoScoreFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdateSelfAgressableStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_UpdateSelfAgressableStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this._statusFunc);
         tree.addChild(this._probationTimeFunc);
         tree.addChild(this._roleAvAIdFunc);
         tree.addChild(this._pictoScoreFunc);
      }
      
      private function _statusFunc(input:ICustomDataInput) : void
      {
         this.status = input.readByte();
         if(this.status < 0)
         {
            throw new Error("Forbidden value (" + this.status + ") on element of UpdateSelfAgressableStatusMessage.status.");
         }
      }
      
      private function _probationTimeFunc(input:ICustomDataInput) : void
      {
         this.probationTime = input.readDouble();
         if(this.probationTime < 0 || this.probationTime > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.probationTime + ") on element of UpdateSelfAgressableStatusMessage.probationTime.");
         }
      }
      
      private function _roleAvAIdFunc(input:ICustomDataInput) : void
      {
         this.roleAvAId = input.readInt();
      }
      
      private function _pictoScoreFunc(input:ICustomDataInput) : void
      {
         this.pictoScore = input.readInt();
      }
   }
}
