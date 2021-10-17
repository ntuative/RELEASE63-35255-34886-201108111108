package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.ElementTypeHolder;
    import com.sulake.habbo.roomevents.userdefinedroomevents.Element;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class TriggerConfs implements ElementTypeHolder 
    {

        private var var_4957:Array = new Array();

        public function TriggerConfs()
        {
            this.var_4957.push(new AvatarSaysSomething());
            this.var_4957.push(new AvatarEntersStuff());
            this.var_4957.push(new AvatarExitsStuff());
            this.var_4957.push(new TriggerOnce());
            this.var_4957.push(new StuffIsUsed());
            this.var_4957.push(new TriggerPeriodically());
            this.var_4957.push(new AvatarEntersRoom());
            this.var_4957.push(new GameStarts());
            this.var_4957.push(new GameEnds());
            this.var_4957.push(new ScoreAchieved());
            this.var_4957.push(new AvatarCaught());
            this.var_4957.push(new StuffCaught());
        }

        public function get confs():Array
        {
            return (this.var_4957);
        }

        public function getByCode(param1:int):TriggerConf
        {
            var _loc2_:TriggerConf;
            for each (_loc2_ in this.var_4957)
            {
                if (_loc2_.code == param1)
                {
                    return (_loc2_);
                };
            };
            return (null);
        }

        public function getElementByCode(param1:int):Element
        {
            return (this.getByCode(param1));
        }

        public function acceptTriggerable(param1:Triggerable):Boolean
        {
            return (!((param1 as TriggerDefinition) == null));
        }

        public function getKey():String
        {
            return ("trigger");
        }


    }
}