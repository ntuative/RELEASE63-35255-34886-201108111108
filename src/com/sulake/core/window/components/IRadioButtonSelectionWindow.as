package com.sulake.core.window.components
{
    import com.sulake.core.window.IWindowContainer;

    public interface IRadioButtonSelectionWindow extends IWindowContainer 
    {

        function get selected():IRadioButtonWindow;
        function radioButtonSelection(param1:IRadioButtonWindow):void;

    }
}