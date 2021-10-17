package com.sulake.habbo.help.tutorial
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class TutorialClothesChangeView implements ITutorialUIView 
    {

        private var var_4014:TutorialUI;
        private var var_4028:IWindowContainer;

        public function TutorialClothesChangeView(param1:IItemListWindow, param2:TutorialUI):void
        {
            this.var_4014 = param2;
            var _loc3_:IWindowContainer = (param2.buildXmlWindow("tutorial_change_clothes") as IWindowContainer);
            if (_loc3_ == null)
            {
                return;
            };
            _loc3_.procedure = this.windowProcedure;
            param1.addListItem((_loc3_ as IWindow));
            this.var_4014.prepareForTutorial();
        }

        public function get view():IWindowContainer
        {
            return (null);
        }

        public function get id():String
        {
            return (TutorialUI.var_1408);
        }

        public function dispose():void
        {
            this.var_4014 = null;
            if (this.var_4028)
            {
                this.var_4028.dispose();
                this.var_4028 = null;
            };
        }

        private function windowProcedure(param1:WindowEvent, param2:IWindow):void
        {
            switch (param2.name)
            {
                case "button_cancel":
                    if (param1.type == WindowMouseEvent.var_650)
                    {
                        this.var_4014.showView(TutorialUI.var_1407);
                    };
                    return;
            };
        }


    }
}