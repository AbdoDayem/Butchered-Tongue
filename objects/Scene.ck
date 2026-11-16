public class Scene extends GGen
{
    int finished;   // Flag to signal end of scene

    // Instead of fading everything in the scene, im fading in and out a background colored plane
    GPlane cover --> this;
    cover.color(@(0.95, 0.95, 0.95));
    cover.sca(@(100, 100, 1));
    cover.posZ(2);

    fun void enter() 
    { 
        this --> GG.scene();
        0 => finished; 
        Tween.fade(cover, 0, 2::second);
    }

    fun void exit() 
    {
        Tween.fade(cover, 1, 2::second);

        // So next scene fade in doesnt start till fade out ends
        now + 1::second => time end;
        while (now < end) 
        {
            GG.nextFrame() => now;
            Tween.update();
        }
        
        this --< GG.scene();
    }

    fun void update()
    {
        
    }
}