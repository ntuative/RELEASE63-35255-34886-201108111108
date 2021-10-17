package com.sulake.habbo.communication.messages.outgoing.poll
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PollAnswerComposer implements IMessageComposer 
    {

        private var _data:Array;

        public function PollAnswerComposer(param1:int, param2:int, param3:Array)
        {
            var _loc4_:int;
            super();
            this._data = [param1, param2];
            if ((param3[0] is String))
            {
                this._data.push(1);
                this._data.push(param3[0]);
            }
            else
            {
                this._data.push(param3.length);
                _loc4_ = 0;
                while (_loc4_ < param3.length)
                {
                    this._data.push(String(param3[_loc4_]));
                    _loc4_++;
                };
            };
        }

        public function getMessageArray():Array
        {
            return (this._data);
        }

        public function dispose():void
        {
            this._data = null;
        }


    }
}