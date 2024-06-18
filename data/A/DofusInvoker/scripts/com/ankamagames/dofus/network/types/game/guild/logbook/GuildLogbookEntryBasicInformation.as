package com.ankamagames.dofus.network.types.game.guild.logbook
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GuildLogbookEntryBasicInformation implements INetworkType
   {
      
      public static const protocolId:uint = 8590;
       
      
      public var id:uint = 0;
      
      public var date:Number = 0;
      
      public function GuildLogbookEntryBasicInformation()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 8590;
      }
      
      public function initGuildLogbookEntryBasicInformation(id:uint = 0, date:Number = 0) : GuildLogbookEntryBasicInformation
      {
         this.id = id;
         this.date = date;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.date = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GuildLogbookEntryBasicInformation(output);
      }
      
      public function serializeAs_GuildLogbookEntryBasicInformation(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarInt(this.id);
         if(this.date < 0 || this.date > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.date + ") on element date.");
         }
         output.writeDouble(this.date);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildLogbookEntryBasicInformation(input);
      }
      
      public function deserializeAs_GuildLogbookEntryBasicInformation(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._dateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildLogbookEntryBasicInformation(tree);
      }
      
      public function deserializeAsyncAs_GuildLogbookEntryBasicInformation(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._dateFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of GuildLogbookEntryBasicInformation.id.");
         }
      }
      
      private function _dateFunc(input:ICustomDataInput) : void
      {
         this.date = input.readDouble();
         if(this.date < 0 || this.date > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.date + ") on element of GuildLogbookEntryBasicInformation.date.");
         }
      }
   }
}
