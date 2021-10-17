package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import flash.utils.getTimer;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IssueInfoMessageParser implements IMessageParser 
    {

        private var var_3736:IssueMessageData;


        public function get issueData():IssueMessageData
        {
            return (this.var_3736);
        }

        public function flush():Boolean
        {
            this.var_3736 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc18_:String;
            var _loc19_:int;
            var _loc20_:int;
            var _loc21_:String;
            var _loc22_:int;
            var _loc23_:String;
            var _loc2_:int = param1.readInteger();
            var _loc3_:int = param1.readInteger();
            var _loc4_:int = param1.readInteger();
            var _loc5_:int = param1.readInteger();
            var _loc6_:int = (getTimer() - param1.readInteger());
            var _loc7_:int = param1.readInteger();
            var _loc8_:int = param1.readInteger();
            var _loc9_:String = param1.readString();
            var _loc10_:int = param1.readInteger();
            var _loc11_:String = param1.readString();
            var _loc12_:int = param1.readInteger();
            var _loc13_:String = param1.readString();
            var _loc14_:String = param1.readString();
            var _loc15_:int = param1.readInteger();
            var _loc16_:String = param1.readString();
            var _loc17_:int = param1.readInteger();
            if (_loc17_ == 0)
            {
                _loc18_ = param1.readString();
                _loc19_ = param1.readInteger();
                _loc20_ = param1.readInteger();
            }
            else
            {
                if (_loc17_ == 1)
                {
                    _loc21_ = param1.readString();
                    _loc22_ = param1.readInteger();
                    _loc23_ = param1.readString();
                };
            };
            this.var_3736 = new IssueMessageData(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc13_, _loc14_, _loc15_, _loc16_, _loc17_, _loc21_, _loc22_, _loc23_, _loc18_, _loc19_, _loc20_);
            return (true);
        }


    }
}