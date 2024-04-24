package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ServerOptionalFeaturesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6599;
       
      
      private var _isInitialized:Boolean = false;
      
      public var features:Vector.<uint>;
      
      private var _featurestree:FuncTree;
      
      public function ServerOptionalFeaturesMessage()
      {
         this.features = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6599;
      }
      
      public function initServerOptionalFeaturesMessage(features:Vector.<uint> = null) : ServerOptionalFeaturesMessage
      {
         this.features = features;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.features = new Vector.<uint>();
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
         this.serializeAs_ServerOptionalFeaturesMessage(output);
      }
      
      public function serializeAs_ServerOptionalFeaturesMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.features.length);
         for(var _i1:uint = 0; _i1 < this.features.length; _i1++)
         {
            if(this.features[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.features[_i1] + ") on element 1 (starting at 1) of features.");
            }
            output.writeInt(this.features[_i1]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ServerOptionalFeaturesMessage(input);
      }
      
      public function deserializeAs_ServerOptionalFeaturesMessage(input:ICustomDataInput) : void
      {
         var _val1:uint = 0;
         var _featuresLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _featuresLen; _i1++)
         {
            _val1 = input.readInt();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of features.");
            }
            this.features.push(_val1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ServerOptionalFeaturesMessage(tree);
      }
      
      public function deserializeAsyncAs_ServerOptionalFeaturesMessage(tree:FuncTree) : void
      {
         this._featurestree = tree.addChild(this._featurestreeFunc);
      }
      
      private function _featurestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._featurestree.addChild(this._featuresFunc);
         }
      }
      
      private function _featuresFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of features.");
         }
         this.features.push(_val);
      }
   }
}
