package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvatarEffectActivatedMessageParser implements IMessageParser 
    {

        private var _type:int;
        private var var_3424:int;


        public function flush():Boolean
        {
            this._type = 0;
            this.var_3424 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._type = param1.readInteger();
            this.var_3424 = param1.readInteger();
            return (true);
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get duration():int
        {
            return (this.var_3424);
        }


    }
}