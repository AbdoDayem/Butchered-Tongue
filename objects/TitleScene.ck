public class TitleScene extends Scene
{
    int pressed;    // Space was pressed
    GText title;    // Title Scene


    fun @construct(string str)
    {
        title.text(str);
        title.pos(@(0, 0, 0));
        title.color(@(0, 0, 0));
        title.sca(0.7);
        title --> this;
    }

    fun void enter() 
    { 
        0 => finished; 
        0 => pressed;
    }

    fun void exit() 
    {

    }

    // Finish scene on space pressed and released
    fun void update()
    {
        if (GWindow.keyDown(GWindow.KEY_SPACE)) 1 => pressed;
        if (pressed && GWindow.keyUp(GWindow.KEY_SPACE)) 1 => finished;
    }
}