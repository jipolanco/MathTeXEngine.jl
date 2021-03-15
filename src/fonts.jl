using FreeTypeAbstraction

"""
    xheight(font::FTFont)

The height of the letter x in the given font, i.e. the height of the letters
without neither ascender nor descender.
"""
xheight(font::FTFont) = inkheight(TeXChar('x', font))

abstract type TeXFontSet end

struct NewCMFontSet <: TeXFontSet
    regular::FTFont
    italic::FTFont
    math::FTFont
end

function get_math_char(char::Char, fontset)
    if char in raw".;:!?()[]"
        TeXChar(char, fontset.regular)
    else
        TeXChar(char, fontset.italic)
    end
end

get_function_char(char::Char, fontset) = TeXChar(char, fontset.regular)
get_number_char(char::Char, fontset) = TeXChar(char, fontset.regular)

"""
    get_symbol_char(char, command, fontset)

Create a TeXChar for the character representing a symbol in the given
font set. The argument `command` contains the LaTeX command corresponding to the
character, to allow supporting non-unicode font sets.
"""
get_symbol_char(char::Char, command, fontset) = TeXChar(char, fontset.math)

const NewComputerModern = NewCMFontSet(
    FTFont("assets/fonts/NewCM10-regular.otf"),
    FTFont("assets/fonts/NewCM10-italic.otf"),
    FTFont("assets/fonts/NewCMMath-regular.otf")
)