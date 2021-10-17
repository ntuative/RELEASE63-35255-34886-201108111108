package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.ElementTypeHolder;
    import com.sulake.habbo.roomevents.userdefinedroomevents.Element;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class ConditionTypes implements ElementTypeHolder 
    {

        private var var_2840:Array = new Array();

        public function ConditionTypes()
        {
            this.var_2840.push(new ActorIsOnFurni());
            this.var_2840.push(new FurnisHaveAvatars());
            this.var_2840.push(new StatesMatch());
            this.var_2840.push(new TimeElapsedMore());
            this.var_2840.push(new TimeElapsedLess());
            this.var_2840.push(new UserCountIn());
            this.var_2840.push(new ActorIsInTeam());
            this.var_2840.push(new HasStackedFurnis());
            this.var_2840.push(new StuffTypeMatches());
            this.var_2840.push(new StuffsInFormation());
        }

        public function get types():Array
        {
            return (this.var_2840);
        }

        public function getByCode(param1:int):ConditionType
        {
            var _loc2_:ConditionType;
            for each (_loc2_ in this.var_2840)
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
            return (!((param1 as ConditionDefinition) == null));
        }

        public function getKey():String
        {
            return ("condition");
        }


    }
}