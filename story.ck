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










// ------------------------------------------------------------------- //
// Scene 2

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
scenes[counter] --> GG.scene();

while(true)
{
    GG.nextFrame() => now;

    scenes[counter].update();

    if(scenes[counter].finished)
    {
        scenes[counter].exit();
        scenes[counter] --< GG.scene();
        counter + 1 => counter;
        if(counter == scenes.size()) me.exit();
        scenes[counter].enter();
        scenes[counter] --> GG.scene();
    }
}