package com.sulake.habbo.communication.messages.parser.poll
{
    import com.sulake.core.communication.messages.IMessageParser;
    import flash.utils.Dictionary;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PollContentsParser implements IMessageParser 
    {

        private var _id:int = -1;
        private var var_3778:String = "";
        private var var_3779:String = "";
        private var var_3780:int = 0;
        private var var_3781:Array = null;


        public function get id():int
        {
            return (this._id);
        }

        public function get startMessage():String
        {
            return (this.var_3778);
        }

        public function get endMessage():String
        {
            return (this.var_3779);
        }

        public function get numQuestions():int
        {
            return (this.var_3780);
        }

        public function get questionArray():Array
        {
            return (this.var_3781);
        }

        public function flush():Boolean
        {
            this._id = -1;
            this.var_3778 = "";
            this.var_3779 = "";
            this.var_3780 = 0;
            this.var_3781 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc3_:Dictionary;
            var _loc4_:int;
            var _loc5_:Array;
            var _loc6_:int;
            this._id = param1.readInteger();
            this.var_3778 = param1.readString();
            this.var_3779 = param1.readString();
            this.var_3780 = param1.readInteger();
            this.var_3781 = new Array();
            var _loc2_:int;
            while (_loc2_ < this.var_3780)
            {
                _loc3_ = new Dictionary();
                this.var_3781.push(_loc3_);
                _loc3_["id"] = param1.readInteger();
                _loc3_["number"] = param1.readInteger();
                _loc3_["type"] = param1.readInteger();
                _loc3_["content"] = param1.readString();
                if (((_loc3_["type"] == 1) || (_loc3_["type"] == 2)))
                {
                    _loc4_ = param1.readInteger();
                    _loc5_ = new Array();
                    _loc3_["selections"] = _loc5_;
                    _loc3_["selection_count"] = _loc4_;
                    _loc3_["selection_min"] = param1.readInteger();
                    _loc3_["selection_max"] = param1.readInteger();
                    _loc6_ = 0;
                    while (_loc6_ < _loc4_)
                    {
                        _loc5_.push(param1.readString());
                        _loc6_++;
                    };
                };
                _loc2_++;
            };
            return (true);
        }


    }
}