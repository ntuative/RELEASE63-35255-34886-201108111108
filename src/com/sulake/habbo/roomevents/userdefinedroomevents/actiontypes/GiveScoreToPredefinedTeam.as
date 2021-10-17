package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class GiveScoreToPredefinedTeam extends GiveScore 
    {


        override public function get code():int
        {
            return (ActionTypeCodes.var_2464);
        }

        override public function onEditStart(param1:IWindowContainer, param2:Triggerable):void
        {
            super.onEditStart(param1, param2);
            var _loc3_:int = param2.intParams[2];
            this.getTeamSelector(param1).setSelected(this.getTeamRadio(param1, _loc3_));
        }

        override public function readIntParamsFromForm(param1:IWindowContainer):Array
        {
            var _loc2_:Array = super.readIntParamsFromForm(param1);
            _loc2_.push(this.getTeamSelector(param1).getSelected().id);
            return (_loc2_);
        }

        private function getTeamRadio(param1:IWindowContainer, param2:int):IRadioButtonWindow
        {
            return (IRadioButtonWindow(param1.findChildByName((("team_" + param2) + "_radio"))));
        }

        private function getTeamSelector(param1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(param1.findChildByName("team_selector")));
        }


    }
}