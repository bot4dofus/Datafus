package com.ankamagames.dofus.network.messages.report
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ReportRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6032;
       
      
      private var _isInitialized:Boolean = false;
      
      public var targetId:Number = 0;
      
      public var categories:Vector.<uint>;
      
      public var description:String = "";
      
      private var _categoriestree:FuncTree;
      
      public function ReportRequestMessage()
      {
         this.categories = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6032;
      }
      
      public function initReportRequestMessage(targetId:Number = 0, categories:Vector.<uint> = null, description:String = "") : ReportRequestMessage
      {
         this.targetId = targetId;
         this.categories = categories;
         this.description = description;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.targetId = 0;
         this.categories = new Vector.<uint>();
         this.description = "";
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
         this.serializeAs_ReportRequestMessage(output);
      }
      
      public function serializeAs_ReportRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         output.writeDouble(this.targetId);
         output.writeShort(this.categories.length);
         for(var _i2:uint = 0; _i2 < this.categories.length; _i2++)
         {
            output.writeByte(this.categories[_i2]);
         }
         output.writeUTF(this.description);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ReportRequestMessage(input);
      }
      
      public function deserializeAs_ReportRequestMessage(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         this._targetIdFunc(input);
         var _categoriesLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _categoriesLen; _i2++)
         {
            _val2 = input.readByte();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of categories.");
            }
            this.categories.push(_val2);
         }
         this._descriptionFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ReportRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ReportRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._targetIdFunc);
         this._categoriestree = tree.addChild(this._categoriestreeFunc);
         tree.addChild(this._descriptionFunc);
      }
      
      private function _targetIdFunc(input:ICustomDataInput) : void
      {
         this.targetId = input.readDouble();
         if(this.targetId < -9007199254740992 || this.targetId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of ReportRequestMessage.targetId.");
         }
      }
      
      private function _categoriestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._categoriestree.addChild(this._categoriesFunc);
         }
      }
      
      private function _categoriesFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readByte();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of categories.");
         }
         this.categories.push(_val);
      }
      
      private function _descriptionFunc(input:ICustomDataInput) : void
      {
         this.description = input.readUTF();
      }
   }
}
