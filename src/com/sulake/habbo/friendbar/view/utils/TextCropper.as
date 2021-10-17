package com.sulake.habbo.friendbar.view.utils
{
    import com.sulake.core.runtime.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import com.sulake.core.window.components.ITextWindow;

    public class TextCropper implements IDisposable 
    {

        private var _disposed:Boolean = false;
        private var var_3934:TextField;
        private var var_3935:TextFormat;
        private var var_3936:String = "...";
        private var var_3937:int = 20;

        public function TextCropper()
        {
            this.var_3934 = new TextField();
            this.var_3934.autoSize = TextFieldAutoSize.LEFT;
            this.var_3935 = this.var_3934.defaultTextFormat;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this.var_3934 = null;
                this._disposed = true;
            };
        }

        public function crop(param1:ITextWindow):void
        {
            var _loc3_:int;
            this.var_3935.font = param1.fontFace;
            this.var_3935.size = param1.fontSize;
            this.var_3935.bold = param1.bold;
            this.var_3935.italic = param1.italic;
            this.var_3934.setTextFormat(this.var_3935);
            this.var_3934.text = param1.getLineText(0);
            var _loc2_:int = this.var_3934.textWidth;
            if (_loc2_ > param1.width)
            {
                _loc3_ = int(this.var_3934.getCharIndexAtPoint((param1.width - this.var_3937), (this.var_3934.textHeight / 2)));
                param1.text = (param1.text.slice(0, _loc3_) + this.var_3936);
            };
        }


    }
}