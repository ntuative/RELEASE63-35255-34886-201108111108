package com.sulake.habbo.communication.messages.outgoing.room.engine
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.utils.Map;

    public class SetObjectDataMessageComposer implements IMessageComposer 
    {

        private var _data:Array = [];

        public function SetObjectDataMessageComposer(param1:int, param2:Map, param3:int=0, param4:int=0)
        {
            var _loc5_:String;
            super();
            this._data.push(param1);
            this._data.push((param2.length * 2));
            for each (_loc5_ in param2.getKeys())
            {
                this._data.push(_loc5_);
                this._data.push(param2.getValue(_loc5_));
            };
        }

        public function dispose():void
        {
            this._data = null;
        }

        public function getMessageArray():Array
        {
            return (this._data);
        }


    }
}