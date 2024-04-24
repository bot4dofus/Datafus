package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AlliancePartialListMessage extends AllianceListMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9332;
       
      
      private var _isInitialized:Boolean = false;
      
      public function AlliancePartialListMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9332;
      }
      
      public function initAlliancePartialListMessage(alliances:Vector.<AllianceFactSheetInformation> = null) : AlliancePartialListMessage
      {
         super.initAllianceListMessage(alliances);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
         this.serializeAs_AlliancePartialListMessage(output);
      }
      
      public function serializeAs_AlliancePartialListMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AllianceListMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlliancePartialListMessage(input);
      }
      
      public function deserializeAs_AlliancePartialListMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlliancePartialListMessage(tree);
      }
      
      public function deserializeAsyncAs_AlliancePartialListMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
