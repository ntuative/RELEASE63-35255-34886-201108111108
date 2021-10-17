package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsDataMessageParser implements IMessageParser 
    {

        private var var_3848:RoomSettingsData;


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3848 = new RoomSettingsData();
            this.var_3848.roomId = param1.readInteger();
            this.var_3848.name = param1.readString();
            this.var_3848.description = param1.readString();
            this.var_3848.doorMode = param1.readInteger();
            this.var_3848.categoryId = param1.readInteger();
            this.var_3848.maximumVisitors = param1.readInteger();
            this.var_3848.maximumVisitorsLimit = param1.readInteger();
            this.var_3848.tags = [];
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3848.tags.push(param1.readString());
                _loc3_++;
            };
            this.var_3848.controllers = [];
            var _loc4_:int = param1.readInteger();
            var _loc5_:int;
            while (_loc5_ < _loc4_)
            {
                this.var_3848.controllers.push(new FlatControllerData(param1));
                _loc5_++;
            };
            this.var_3848.controllerCount = param1.readInteger();
            this.var_3848.allowPets = (param1.readInteger() == 1);
            this.var_3848.allowFoodConsume = (param1.readInteger() == 1);
            this.var_3848.allowWalkThrough = (param1.readInteger() == 1);
            this.var_3848.hideWalls = (param1.readInteger() == 1);
            this.var_3848.wallThickness = param1.readInteger();
            this.var_3848.floorThickness = param1.readInteger();
            return (true);
        }

        public function flush():Boolean
        {
            this.var_3848 = null;
            return (true);
        }

        public function get data():RoomSettingsData
        {
            return (this.var_3848);
        }


    }
}