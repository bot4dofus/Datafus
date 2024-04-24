package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BasicLatencyStatsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2788;
       
      
      private var _isInitialized:Boolean = false;
      
      public var latency:uint = 0;
      
      public var sampleCount:uint = 0;
      
      public var max:uint = 0;
      
      public function BasicLatencyStatsMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2788;
      }
      
      public function initBasicLatencyStatsMessage(latency:uint = 0, sampleCount:uint = 0, max:uint = 0) : BasicLatencyStatsMessage
      {
         this.latency = latency;
         this.sampleCount = sampleCount;
         this.max = max;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.latency = 0;
         this.sampleCount = 0;
         this.max = 0;
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
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_BasicLatencyStatsMessage(output);
      }
      
      public function serializeAs_BasicLatencyStatsMessage(output:ICustomDataOutput) : void
      {
         if(this.latency < 0 || this.latency > 65535)
         {
            throw new Error("Forbidden value (" + this.latency + ") on element latency.");
         }
         output.writeShort(this.latency);
         if(this.sampleCount < 0)
         {
            throw new Error("Forbidden value (" + this.sampleCount + ") on element sampleCount.");
         }
         output.writeVarShort(this.sampleCount);
         if(this.max < 0)
         {
            throw new Error("Forbidden value (" + this.max + ") on element max.");
         }
         output.writeVarShort(this.max);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicLatencyStatsMessage(input);
      }
      
      public function deserializeAs_BasicLatencyStatsMessage(input:ICustomDataInput) : void
      {
         this._latencyFunc(input);
         this._sampleCountFunc(input);
         this._maxFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicLatencyStatsMessage(tree);
      }
      
      public function deserializeAsyncAs_BasicLatencyStatsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._latencyFunc);
         tree.addChild(this._sampleCountFunc);
         tree.addChild(this._maxFunc);
      }
      
      private function _latencyFunc(input:ICustomDataInput) : void
      {
         this.latency = input.readUnsignedShort();
         if(this.latency < 0 || this.latency > 65535)
         {
            throw new Error("Forbidden value (" + this.latency + ") on element of BasicLatencyStatsMessage.latency.");
         }
      }
      
      private function _sampleCountFunc(input:ICustomDataInput) : void
      {
         this.sampleCount = input.readVarUhShort();
         if(this.sampleCount < 0)
         {
            throw new Error("Forbidden value (" + this.sampleCount + ") on element of BasicLatencyStatsMessage.sampleCount.");
         }
      }
      
      private function _maxFunc(input:ICustomDataInput) : void
      {
         this.max = input.readVarUhShort();
         if(this.max < 0)
         {
            throw new Error("Forbidden value (" + this.max + ") on element of BasicLatencyStatsMessage.max.");
         }
      }
   }
}
