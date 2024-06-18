package com.ankamagames.dofus.network.messages.game.alliance.application
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AlliancePlayerNoApplicationInformationMessage extends AlliancePlayerApplicationAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7142;
       
      
      public function AlliancePlayerNoApplicationInformationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return true;
      }
      
      override public function getMessageId() : uint
      {
         return 7142;
      }
      
      public function initAlliancePlayerNoApplicationInformationMessage() : AlliancePlayerNoApplicationInformationMessage
      {
         return this;
      }
      
      override public function reset() : void
      {
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
      }
      
      public function serializeAs_AlliancePlayerNoApplicationInformationMessage(output:ICustomDataOutput) : void
      {
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
      }
      
      public function deserializeAs_AlliancePlayerNoApplicationInformationMessage(input:ICustomDataInput) : void
      {
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
      }
      
      public function deserializeAsyncAs_AlliancePlayerNoApplicationInformationMessage(tree:FuncTree) : void
      {
      }
   }
}
