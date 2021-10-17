package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class AvatarSaysSomething implements TriggerConf 
    {


        public function get code():int
        {
            return (TriggerConfCodes.var_2444);
        }

        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
        }

        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }

        public function readIntParamsFromForm(param1:IWindowContainer):Array
        {
            var _loc2_:Array = new Array();
            _loc2_.push(((this.getMeRadio(param1).isSelected) ? 1 : 0));
            return (_loc2_);
        }

        public function readStringParamFromForm(param1:IWindowContainer):String
        {
            return (this.getInput(param1).text);
        }

        public function onInit(param1:IWindowContainer, param2:HabboUserDefinedRoomEvents):void
        {
            param1.findChildByName("me_txt").caption = param2.userName;
        }

        public function onEditStart(param1:IWindowContainer, param2:Triggerable):void
        {
            this.getInput(param1).text = param2.stringParam;
            if (((param2.intParams.length > 0) && (param2.intParams[0] == 1)))
            {
                this.getSelector(param1).setSelected(this.getMeRadio(param1));
            }
            else
            {
                this.getSelector(param1).setSelected(this.getAnyAvatarRadio(param1));
            };
        }

        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getInput(param1:IWindowContainer):ITextFieldWindow
        {
            return (ITextFieldWindow(param1.findChildByName("chat_txt")));
        }

        private function getAnyAvatarRadio(param1:IWindowContainer):IRadioButtonWindow
        {
            return (IRadioButtonWindow(param1.findChildByName("any_avatar_radio")));
        }

        private function getMeRadio(param1:IWindowContainer):IRadioButtonWindow
        {
            return (IRadioButtonWindow(param1.findChildByName("me_radio")));
        }

        private function getSelector(param1:IWindowContainer):ISelectorWindow
        {
            return (ISelectorWindow(param1.findChildByName("avatar_radio")));
        }


    }
}