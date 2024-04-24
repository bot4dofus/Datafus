package com.ankamagames.dofus.network.messages.game.almanach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AlmanachCalendarDateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3125;
       
      
      private var _isInitialized:Boolean = false;
      
      public var date:int = 0;
      
      public function AlmanachCalendarDateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3125;
      }
      
      public function initAlmanachCalendarDateMessage(date:int = 0) : AlmanachCalendarDateMessage
      {
         this.date = date;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.date = 0;
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
         this.serializeAs_AlmanachCalendarDateMessage(output);
      }
      
      public function serializeAs_AlmanachCalendarDateMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.date);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlmanachCalendarDateMessage(input);
      }
      
      public function deserializeAs_AlmanachCalendarDateMessage(input:ICustomDataInput) : void
      {
         this._dateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlmanachCalendarDateMessage(tree);
      }
      
      public function deserializeAsyncAs_AlmanachCalendarDateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._dateFunc);
      }
      
      private function _dateFunc(input:ICustomDataInput) : void
      {
         this.date = input.readInt();
      }
   }
}
