package com.ankamagames.dofus.network.messages.game.atlas.compass
{
   import com.ankamagames.dofus.network.types.game.context.MapCoordinates;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class CompassUpdatePvpSeekMessage extends CompassUpdateMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4778;
       
      
      private var _isInitialized:Boolean = false;
      
      public var memberId:Number = 0;
      
      public var memberName:String = "";
      
      public function CompassUpdatePvpSeekMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4778;
      }
      
      public function initCompassUpdatePvpSeekMessage(type:uint = 0, coords:MapCoordinates = null, memberId:Number = 0, memberName:String = "") : CompassUpdatePvpSeekMessage
      {
         super.initCompassUpdateMessage(type,coords);
         this.memberId = memberId;
         this.memberName = memberName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.memberId = 0;
         this.memberName = "";
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
         this.serializeAs_CompassUpdatePvpSeekMessage(output);
      }
      
      public function serializeAs_CompassUpdatePvpSeekMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_CompassUpdateMessage(output);
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
         }
         output.writeVarLong(this.memberId);
         output.writeUTF(this.memberName);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CompassUpdatePvpSeekMessage(input);
      }
      
      public function deserializeAs_CompassUpdatePvpSeekMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._memberIdFunc(input);
         this._memberNameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CompassUpdatePvpSeekMessage(tree);
      }
      
      public function deserializeAsyncAs_CompassUpdatePvpSeekMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._memberIdFunc);
         tree.addChild(this._memberNameFunc);
      }
      
      private function _memberIdFunc(input:ICustomDataInput) : void
      {
         this.memberId = input.readVarUhLong();
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of CompassUpdatePvpSeekMessage.memberId.");
         }
      }
      
      private function _memberNameFunc(input:ICustomDataInput) : void
      {
         this.memberName = input.readUTF();
      }
   }
}
