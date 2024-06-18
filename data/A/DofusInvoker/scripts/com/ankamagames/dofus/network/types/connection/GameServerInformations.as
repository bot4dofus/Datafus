package com.ankamagames.dofus.network.types.connection
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameServerInformations implements INetworkType
   {
      
      public static const protocolId:uint = 4792;
       
      
      public var id:uint = 0;
      
      public var type:int = -1;
      
      public var isMonoAccount:Boolean = false;
      
      public var status:uint = 1;
      
      public var completion:uint = 0;
      
      public var isSelectable:Boolean = false;
      
      public var charactersCount:uint = 0;
      
      public var charactersSlots:uint = 0;
      
      public var date:Number = 0;
      
      public function GameServerInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 4792;
      }
      
      public function initGameServerInformations(id:uint = 0, type:int = -1, isMonoAccount:Boolean = false, status:uint = 1, completion:uint = 0, isSelectable:Boolean = false, charactersCount:uint = 0, charactersSlots:uint = 0, date:Number = 0) : GameServerInformations
      {
         this.id = id;
         this.type = type;
         this.isMonoAccount = isMonoAccount;
         this.status = status;
         this.completion = completion;
         this.isSelectable = isSelectable;
         this.charactersCount = charactersCount;
         this.charactersSlots = charactersSlots;
         this.date = date;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.type = -1;
         this.isMonoAccount = false;
         this.status = 1;
         this.completion = 0;
         this.isSelectable = false;
         this.charactersCount = 0;
         this.charactersSlots = 0;
         this.date = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameServerInformations(output);
      }
      
      public function serializeAs_GameServerInformations(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.isMonoAccount);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.isSelectable);
         output.writeByte(_box0);
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarShort(this.id);
         output.writeByte(this.type);
         output.writeByte(this.status);
         output.writeByte(this.completion);
         if(this.charactersCount < 0)
         {
            throw new Error("Forbidden value (" + this.charactersCount + ") on element charactersCount.");
         }
         output.writeByte(this.charactersCount);
         if(this.charactersSlots < 0)
         {
            throw new Error("Forbidden value (" + this.charactersSlots + ") on element charactersSlots.");
         }
         output.writeByte(this.charactersSlots);
         if(this.date < -9007199254740992 || this.date > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.date + ") on element date.");
         }
         output.writeDouble(this.date);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameServerInformations(input);
      }
      
      public function deserializeAs_GameServerInformations(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this._idFunc(input);
         this._typeFunc(input);
         this._statusFunc(input);
         this._completionFunc(input);
         this._charactersCountFunc(input);
         this._charactersSlotsFunc(input);
         this._dateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameServerInformations(tree);
      }
      
      public function deserializeAsyncAs_GameServerInformations(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._idFunc);
         tree.addChild(this._typeFunc);
         tree.addChild(this._statusFunc);
         tree.addChild(this._completionFunc);
         tree.addChild(this._charactersCountFunc);
         tree.addChild(this._charactersSlotsFunc);
         tree.addChild(this._dateFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.isMonoAccount = BooleanByteWrapper.getFlag(_box0,0);
         this.isSelectable = BooleanByteWrapper.getFlag(_box0,1);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhShort();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of GameServerInformations.id.");
         }
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readByte();
      }
      
      private function _statusFunc(input:ICustomDataInput) : void
      {
         this.status = input.readByte();
         if(this.status < 0)
         {
            throw new Error("Forbidden value (" + this.status + ") on element of GameServerInformations.status.");
         }
      }
      
      private function _completionFunc(input:ICustomDataInput) : void
      {
         this.completion = input.readByte();
         if(this.completion < 0)
         {
            throw new Error("Forbidden value (" + this.completion + ") on element of GameServerInformations.completion.");
         }
      }
      
      private function _charactersCountFunc(input:ICustomDataInput) : void
      {
         this.charactersCount = input.readByte();
         if(this.charactersCount < 0)
         {
            throw new Error("Forbidden value (" + this.charactersCount + ") on element of GameServerInformations.charactersCount.");
         }
      }
      
      private function _charactersSlotsFunc(input:ICustomDataInput) : void
      {
         this.charactersSlots = input.readByte();
         if(this.charactersSlots < 0)
         {
            throw new Error("Forbidden value (" + this.charactersSlots + ") on element of GameServerInformations.charactersSlots.");
         }
      }
      
      private function _dateFunc(input:ICustomDataInput) : void
      {
         this.date = input.readDouble();
         if(this.date < -9007199254740992 || this.date > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.date + ") on element of GameServerInformations.date.");
         }
      }
   }
}
