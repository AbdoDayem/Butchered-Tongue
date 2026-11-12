// GGen that lets me create text with multiple fonts
// ------------------------------------------------------------------- //
public class PolyFont extends GGen
{
    GText chars[0];     // Characters in String
    string fonts[52];   // Fonts Paths
    0.6 => float space; // Space Between Chars
    20  => int wrap;    // Chars per line

    // Constructor
    // I named the font files a.ttf, b.ttf, etc so its easy.
    fun @construct()
    {
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" => string letters;
        for (0 => int i; i < 26; i++)
        {
            // Lower Case
            "fonts/" + letters.substring(i, 1) + ".ttf" => fonts[i];
            // Upper Case     
            "fonts/" + letters.substring(i, 1) + ".ttf" => fonts[i + 26];
        }
    }

    // Sets Text
    // tex  : Text to set to
    // lang : language selector
    //          0   :   English
    //          1   :   'A' Language
    //          2   :   'B' Language 
    fun void text(string tex, int lang)
    {
        // Remove Current Text
        for (0 => int i; i < chars.size(); i++) chars[i] --< this;
        chars.clear();

        for (0 => int i; i < tex.length(); i++)
        {
            // ASCII Shenanigans
            tex.charAt(i) => int c;

            // NOTE: a = 97, z = 122, A = 65, Z = 90
            // Lower Case
            if (c >= 97 && c <= 122)
            {
                GText char;
                if (!lang) char.text(tex.substring(i, 1));
                else if (lang == 1) char.text("a");
                else if (lang == 2) char.text("b");
                char.font(fonts[c - 97]);
                char.posX((i % wrap) * space);
                char.posY(-(i / wrap) $ int);
                char --> this;
                chars << char;
            } 
            // Upper Case
            else if (c >= 65 && c <= 90)
            {
                GText char;
                if (!lang) char.text(tex.substring(i, 1));
                else if (lang == 1) char.text("A");
                else if (lang == 2) char.text("B");
                char.font(fonts[c - 65]);
                char.posX((i % wrap) * space);
                char.posY(-(i / wrap) $ int);
                char --> this;
                chars << char;
            }
        }
    }

}