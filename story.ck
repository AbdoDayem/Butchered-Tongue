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
    Character man(); man --> this;
    man.mat.color(@(0,0,0));
    man.pos(@(-1,0,0));

    fun void update()
    {
        if (GWindow.keyDown(GWindow.KEY_SPACE)) 1 => finished;
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

TitleScene credits("Thank you!");
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