package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceModificationNameAndTagValidMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3189;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceName:String = "";
      
      public var allianceTag:String = "";
      
      public function AllianceModificationNameAndTagValidMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3189;
      }
      
      public function initAllianceModificationNameAndTagValidMessage(allianceName:String = "", allianceTag:String = "") : AllianceModificationNameAndTagValidMessage
      {
         this.allianceName = allianceName;
         this.allianceTag = allianceTag;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceName = "";
         this.allianceTag = "";
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
         this.serializeAs_AllianceModificationNameAndTagValidMessage(output);
      }
      
      public function serializeAs_AllianceModificationNameAndTagValidMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.allianceName);
         output.writeUTF(this.allianceTag);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceModificationNameAndTagValidMessage(input);
      }
      
      public function deserializeAs_AllianceModificationNameAndTagValidMessage(input:ICustomDataInput) : void
      {
         this._allianceNameFunc(input);
         this._allianceTagFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceModificationNameAndTagValidMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceModificationNameAndTagValidMessage(tree:FuncTree) : void
      {
         tree.addChild(this._allianceNameFunc);
         tree.addChild(this._allianceTagFunc);
      }
      
      private function _allianceNameFunc(input:ICustomDataInput) : void
      {
         this.allianceName = input.readUTF();
      }
      
      private function _allianceTagFunc(input:ICustomDataInput) : void
      {
         this.allianceTag = input.readUTF();
      }
   }
}
