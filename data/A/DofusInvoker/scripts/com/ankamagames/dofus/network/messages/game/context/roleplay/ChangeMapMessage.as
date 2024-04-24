package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChangeMapMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 70;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mapId:Number = 0;
      
      public var autopilot:Boolean = false;
      
      public function ChangeMapMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 70;
      }
      
      public function initChangeMapMessage(mapId:Number = 0, autopilot:Boolean = false) : ChangeMapMessage
      {
         this.mapId = mapId;
         this.autopilot = autopilot;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mapId = 0;
         this.autopilot = false;
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
         this.serializeAs_ChangeMapMessage(output);
      }
      
      public function serializeAs_ChangeMapMessage(output:ICustomDataOutput) : void
      {
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         output.writeBoolean(this.autopilot);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChangeMapMessage(input);
      }
      
      public function deserializeAs_ChangeMapMessage(input:ICustomDataInput) : void
      {
         this._mapIdFunc(input);
         this._autopilotFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChangeMapMessage(tree);
      }
      
      public function deserializeAsyncAs_ChangeMapMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._autopilotFunc);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of ChangeMapMessage.mapId.");
         }
      }
      
      private function _autopilotFunc(input:ICustomDataInput) : void
      {
         this.autopilot = input.readBoolean();
      }
   }
}
