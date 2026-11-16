public class Character extends GGen
{
    GPlane plane;            // Actual GGen
    FlatMaterial mat;        // Texture stuff

    // For my Drawings
    fun @construct(Texture tex)
    {
        mat.colorMap(tex);
        plane.material(mat);
        plane --> this;
    }

    // For Testing and Milestone
    fun @construct()
    {
        plane.material(mat);
        plane --> this;
    }

    fun void say()
    {

    }
}