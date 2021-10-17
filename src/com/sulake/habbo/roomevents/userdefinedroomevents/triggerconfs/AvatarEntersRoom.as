package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ISelectorWindow;

    public class AvatarEntersRoom implements TriggerConf 
    {

        private var _cont:IWindowContainer;


        public function get code():int
        {
            return (TriggerConfCodes.var_2452);
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
            return (new Array());
        }

        public function readStringParamFromForm(param1:IWindowContainer):String
        {
            var _loc2_:String = this.getInput().text;
            return ((this.getCertainAvatarRadio().isSelected) ? _loc2_ : "");
        }

        public function onInit(param1:IWindowContainer, param2:HabboUserDefinedRoomEvents):void
        {
            this._cont = param1;
            this.getCertainAvatarRadio().addEventListener(WindowEvent.var_575, this.onCertainAvatarSelect);
            this.getCertainAvatarRadio().addEventListener(WindowEvent.var_577, this.onCertainAvatarUnselect);
        }

        public function onEditStart(param1:IWindowContainer, param2:Triggerable):void
        {
            if (param2.stringParam != "")
            {
                this.getSelector().setSelected(this.getCertainAvatarRadio());
                this.getInput().text = param2.stringParam;
                this.getInput().visible = true;
            }
            else
            {
                this.getSelector().setSelected(this.getAnyAvatarRadio());
                this.getInput().text = "";
                this.getInput().visible = false;
            };
        }

        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }

        private function getInput():ITextFieldWindow
        {
            return (ITextFieldWindow(this._cont.findChildByName("avatar_name_txt")));
        }

        private function getCertainAvatarRadio():IRadioButtonWindow
        {
            return (IRadioButtonWindow(this._cont.findChildByName("certain_avatar_radio")));
        }

        private function getAnyAvatarRadio():IRadioButtonWindow
        {
            return (IRadioButtonWindow(this._cont.findChildByName("any_avatar_radio")));
        }

        private function getSelector():ISelectorWindow
        {
            return (ISelectorWindow(this._cont.findChildByName("avatar_radio")));
        }

        private function onCertainAvatarSelect(param1:WindowEvent):void
        {
            this.getInput().visible = true;
        }

        private function onCertainAvatarUnselect(param1:WindowEvent):void
        {
            this.getInput().text = "";
            this.getInput().visible = false;
        }


    }
}