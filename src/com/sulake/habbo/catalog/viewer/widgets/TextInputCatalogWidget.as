package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.TextInputEvent;

    public class TextInputCatalogWidget extends CatalogWidget implements ICatalogWidget 
    {

        private var _inputText:ITextFieldWindow;

        public function TextInputCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            this._inputText = (_window.findChildByName("input_text") as ITextFieldWindow);
            if (this._inputText != null)
            {
                this._inputText.addEventListener(WindowKeyboardEvent.var_744, this.onKey);
            };
            return (true);
        }

        private function onKey(param1:WindowKeyboardEvent):void
        {
            if (this._inputText == null)
            {
                return;
            };
            events.dispatchEvent(new TextInputEvent(this._inputText.text));
        }


    }
}