// Butchered Tongue: A Visual Novel
// By: Abdullah Abdeldayem
// ------------------------------------------------------------------- //
@import "chodash"
@import "objects/PolyFont.ck"
@import "objects/Scene.ck"
@import "objects/TitleScene.ck"
@import "objects/Character.ck"
// ------------------------------------------------------------------- //
// Scene 1
class Scene1 extends Scene
{
    // So I can zoom
    GGen world --> this;

    // Man
    Character man(); 
    man --> world;
    man.mat.color(@(0, 0, 0));
    man.plane.sca(@(0.5, 1, 1));

    // Tree
    Character trunk(); 
    trunk --> world;
    trunk.mat.color(@(0.55, 0.5, 0.45));
    trunk.plane.sca(@(0.4, 2, 1));
    trunk.pos(@(2, 0.5, 0));

    Character leaves(); leaves --> world;
    leaves.mat.color(@(0.65, 0.7, 0.6));
    leaves.plane.sca(@(1.6, 1.6, 1));
    leaves.pos(@(2, 2, 0));

    // Zooming
    1.0 => float zoom;
    0 => int presses;

    // Task: Press key to zoom in repeatedly on the Man to enter the memory
    fun void update()
    {

        if (GWindow.keyDown(GWindow.KEY_SPACE))
        {
            zoom * 1.2 => zoom;
            Tween.scale(world, zoom, 1::second);
            presses++;
            
            if (presses % 2) man.say("Blah agweaiofn asfno", 3);
            else man.say("Yadda yoobaasdf blahblah", 2);

            if (presses == 5) 1 => finished;
        }
    }
}
// ------------------------------------------------------------------- //
// Scene 2
class Scene2 extends Scene
{

}
// ------------------------------------------------------------------- //
// Window Setup
GG.camera().orthographic();
GWindow.fullscreen();
GG.scene().backgroundColor(@(0.95, 0.95, 0.95));
GText.defaultFont(me.dir() + "./fonts/e.ttf");
// ------------------------------------------------------------------- //
// Scene Setup
Scene @ scenes[0];

TitleScene act1("ACT I: First Exposure");
scenes << act1;

Scene1 scene1;
scenes << scene1;

Scene2 scene2;
//scenes << scene2;

TitleScene act2("ACT II: Two Tongued");
scenes << act2;

TitleScene act3("ACT III: Butchered Tongue");
scenes << act3;

TitleScene credits("Credits");
scenes << credits;


// ------------------------------------------------------------------- //
// Main Loop
0 => int counter;

scenes[counter].enter();

while(true)
{
    GG.nextFrame() => now;
    Tween.update();

    scenes[counter].update();

    if(scenes[counter].finished)
    {
        scenes[counter].exit();
        counter++;
        if(counter == scenes.size()) me.exit();
        else scenes[counter].enter();
    }
}