package com.ankamagames.dofus.network.messages.report
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ReportResponseMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 188;
       
      
      private var _isInitialized:Boolean = false;
      
      public var success:Boolean = false;
      
      public function ReportResponseMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 188;
      }
      
      public function initReportResponseMessage(success:Boolean = false) : ReportResponseMessage
      {
         this.success = success;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.success = false;
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
         this.serializeAs_ReportResponseMessage(output);
      }
      
      public function serializeAs_ReportResponseMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.success);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ReportResponseMessage(input);
      }
      
      public function deserializeAs_ReportResponseMessage(input:ICustomDataInput) : void
      {
         this._successFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ReportResponseMessage(tree);
      }
      
      public function deserializeAsyncAs_ReportResponseMessage(tree:FuncTree) : void
      {
         tree.addChild(this._successFunc);
      }
      
      private function _successFunc(input:ICustomDataInput) : void
      {
         this.success = input.readBoolean();
      }
   }
}
