package com.ankamagames.dofus.network.types.game.character.guild.note
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PlayerNote implements INetworkType
   {
      
      public static const protocolId:uint = 1670;
       
      
      public var content:String = "";
      
      public var lastEditDate:Number = 0;
      
      public function PlayerNote()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1670;
      }
      
      public function initPlayerNote(content:String = "", lastEditDate:Number = 0) : PlayerNote
      {
         this.content = content;
         this.lastEditDate = lastEditDate;
         return this;
      }
      
      public function reset() : void
      {
         this.content = "";
         this.lastEditDate = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PlayerNote(output);
      }
      
      public function serializeAs_PlayerNote(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.content);
         if(this.lastEditDate < -9007199254740992 || this.lastEditDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.lastEditDate + ") on element lastEditDate.");
         }
         output.writeDouble(this.lastEditDate);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PlayerNote(input);
      }
      
      public function deserializeAs_PlayerNote(input:ICustomDataInput) : void
      {
         this._contentFunc(input);
         this._lastEditDateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PlayerNote(tree);
      }
      
      public function deserializeAsyncAs_PlayerNote(tree:FuncTree) : void
      {
         tree.addChild(this._contentFunc);
         tree.addChild(this._lastEditDateFunc);
      }
      
      private function _contentFunc(input:ICustomDataInput) : void
      {
         this.content = input.readUTF();
      }
      
      private function _lastEditDateFunc(input:ICustomDataInput) : void
      {
         this.lastEditDate = input.readDouble();
         if(this.lastEditDate < -9007199254740992 || this.lastEditDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.lastEditDate + ") on element of PlayerNote.lastEditDate.");
         }
      }
   }
}
