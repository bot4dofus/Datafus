package com.ankamagames.dofus.network.messages.game.chat.smiley
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class MoodSmileyResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4081;
       
      
      private var _isInitialized:Boolean = false;
      
      public var resultCode:uint = 1;
      
      public var smileyId:uint = 0;
      
      public function MoodSmileyResultMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4081;
      }
      
      public function initMoodSmileyResultMessage(resultCode:uint = 1, smileyId:uint = 0) : MoodSmileyResultMessage
      {
         this.resultCode = resultCode;
         this.smileyId = smileyId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.resultCode = 1;
         this.smileyId = 0;
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
         this.serializeAs_MoodSmileyResultMessage(output);
      }
      
      public function serializeAs_MoodSmileyResultMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.resultCode);
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element smileyId.");
         }
         output.writeVarShort(this.smileyId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_MoodSmileyResultMessage(input);
      }
      
      public function deserializeAs_MoodSmileyResultMessage(input:ICustomDataInput) : void
      {
         this._resultCodeFunc(input);
         this._smileyIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_MoodSmileyResultMessage(tree);
      }
      
      public function deserializeAsyncAs_MoodSmileyResultMessage(tree:FuncTree) : void
      {
         tree.addChild(this._resultCodeFunc);
         tree.addChild(this._smileyIdFunc);
      }
      
      private function _resultCodeFunc(input:ICustomDataInput) : void
      {
         this.resultCode = input.readByte();
         if(this.resultCode < 0)
         {
            throw new Error("Forbidden value (" + this.resultCode + ") on element of MoodSmileyResultMessage.resultCode.");
         }
      }
      
      private function _smileyIdFunc(input:ICustomDataInput) : void
      {
         this.smileyId = input.readVarUhShort();
         if(this.smileyId < 0)
         {
            throw new Error("Forbidden value (" + this.smileyId + ") on element of MoodSmileyResultMessage.smileyId.");
         }
      }
   }
}
