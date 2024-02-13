" Vim syntax file
" Language:     hy
" License:      Same as VIM
" Authors:      Morten Linderud <mcfoxax@gmail.com>
"               Alejandro Gómez <alejandro@dialelo.com>
"               Sunjay Cauligi <scauligi@eng.ucsd.edu>
" URL:          http://github.com/hylang/vim-hy
"
" Modified version of the clojure syntax file: https://github.com/guns/vim-clojure-static/blob/master/syntax/clojure.vim
if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "hy"

syntax keyword hyAnaphoric ap-if ap-each ap-each-while ap-map ap-map-when
            \ ap-filter ap-reject ap-dotimes ap-first ap-last ap-reduce ap-pipe
            \ ap-compose

syntax keyword hyBuiltin
            \ and assoc block block-ret butlast chain chainc coll? constantly
            \ count cut dec del doc distinct doto drop-last filter flatten get
            \ is is-not is_not islice let list-n map of or quasiquote quote
            \ range reduce rest setv setx slice tee unquote unquote-splice xor zip

" Derived from vim's python syntax file
syntax keyword hyPythonBuiltin
            \ abs all any ascii bin bool breakpoint bytearray bytes callable chr
            \ classmethod compile complex delattr dict dir divmod enumerate eval
            \ exec filter float format frozenset getattr globals hasattr hash
            \ help hex id input int isinstance issubclass iter len list locals
            \ map max memoryview min next object oct open ord pow print property
            \ range repr reversed round set setattr slice sorted staticmethod
            \ str sum super tuple type vars zip --package-- __package__
            \ --import-- __import__ --all-- __all__ --doc-- __doc__ --name--
            \ __name__

syntax keyword hyBoolean True False

syntax keyword hyConstant None Ellipsis NotImplemented Inf NaN
            \ nil " Deprecated

syntax keyword hyException ArithmeticError AssertionError AttributeError
            \ BaseException DeprecationWarning EOFError EnvironmentError
            \ Exception FloatingPointError FutureWarning GeneratorExit IOError
            \ ImportError ImportWarning IndexError KeyError KeyboardInterrupt
            \ LookupError MemoryError NameError NotImplementedError OSError
            \ OverflowError PendingDeprecationWarning ReferenceError
            \ RuntimeError RuntimeWarning StopIteration SyntaxError
            \ SyntaxWarning SystemError SystemExit TypeError UnboundLocalError
            \ UnicodeDecodeError UnicodeEncodeError UnicodeError
            \ UnicodeTranslateError UnicodeWarning UserWarning VMSError
            \ ValueError Warning WindowsError ZeroDivisionError BufferError
            \ BytesWarning IndentationError ResourceWarning TabError

syntax keyword hyStatement
            \ return
            \ break continue
            \ do progn
            \ print
            \ yield yield-from
            \ with with* with/a
            \ with-gensyms
            \ global nonlocal
            \ not
            \ in not-in
            \ lambda fn

syntax keyword hyRepeat
            \ loop recur for for*
            \ while

syntax keyword hyConditional
            \ if lif else
            \ unless when
            \ cond branch ebranch case ecase
            \ match

syntax keyword hySpecial
            \ self

syntax keyword hyMisc
            \ eval
            \ eval-and-compile eval-when-compile do-mac
            \ apply kwapply

syntax keyword hyErrorHandling except try throw raise catch finally assert

syntax keyword hyInclude import require export

" Not used at this moment
"syntax keyword hyVariable

" Keywords are symbols:
"   static Pattern symbolPat = Pattern.compile("[:]?([\\D&&[^/]].*/)?([\\D&&[^/]][^/]*)");
" But they:
"   * Must not end in a : or /
"   * Must not have two adjacent colons except at the beginning
"   * Must not contain any reader metacharacters except for ' and #
syntax match hyKeyword "\v<:{1,2}%([^ \n\r\t()\[\]{}";@^`~\\%/]+/)*[^ \n\r\t()\[\]{}";@^`~\\%/]+:@<!>"

syntax match hyStringEscape "\v\\%([\\abfnrtv'"]|[0-3]\o{2}|\o{1,2}|x\x{2}|u\x{4}|U\x{8}|N\{[^}]*\})" contained

syntax region hyString start=/"/ skip=/\\\\\|\\"/ end=/"/ contains=hyStringEscape
syntax region hyString start="#\[\[" skip=/\\\\\|\\"/ end="\]\]" contains=hyStringEscape

syntax match hyCharacter "\\."
syntax match hyCharacter "\\o\%([0-3]\o\{2\}\|\o\{1,2\}\)"
syntax match hyCharacter "\\u\x\{4\}"
syntax match hyCharacter "\\space"
syntax match hyCharacter "\\tab"
syntax match hyCharacter "\\newline"
syntax match hyCharacter "\\return"
syntax match hyCharacter "\\backspace"
syntax match hyCharacter "\\formfeed"

syntax match hySymbol "\v%([a-zA-Z!$&*_+=|<.>?-]|[^\x00-\x7F])+%(:?%([a-zA-Z0-9!#$%&*_+=|'<.>/?-]|[^\x00-\x7F]))*[#:]@<!"

" Highlight forms that start with `def`, so that users can have highlighting
" for any custom def-* macros
syntax match hyDefine /\v[(]@<=def(ault)@!\S+/

syntax match hyOpNoInplace "\M\<\(=\|!=\|.\|,\|->\|->>\|as->\)\>"
syntax match hyOpInplace "\M\<\(!\|%\|&\|*\|**\|+\|-\|/\|//\|<\|<<\|>\|>>\|^\||\)=\?\>"

" Number highlighting taken from vim's syntax/python.vim,
" but modified to allow leading 0
syntax match hyNumber "\<0[oO]\%(_\=\o\)\+\>"
syntax match hyNumber "\<0[xX]\%(_\=\x\)\+\>"
syntax match hyNumber "\<0[bB]\%(_\=[01]\)\+\>"
syntax match hyNumber "\<\%([0-9]\%(_\=\d\)*\|0\+\%(_\=0\)*\)\>"
syntax match hyNumber "\<\d\%(_\=\d\)*[jJ]\>"
syntax match hyNumber "\<\d\%(_\=\d\)*[eE][+-]\=\d\%(_\=\d\)*[jJ]\=\>"
syntax match hyNumber
            \ "\<\d\%(_\=\d\)*\.\%([eE][+-]\=\d\%(_\=\d\)*\)\=[jJ]\=\%(\W\|$\)\@="
syntax match hyNumber
            \ "\%(^\|\W\)\zs\%(\d\%(_\=\d\)*\)\=\.\d\%(_\=\d\)*\%([eE][+-]\=\d\%(_\=\d\)*\)\=[jJ]\=\>"

syntax match hyQuote "'"
syntax match hyQuote "`"
syntax match hyUnquote "\~"
syntax match hyUnquote "\~@"
syntax match hyTagMacro "\v#[^:[][[:keyword:].]*"
syntax match hyDispatch "\v#[\^/]"
syntax match hyDispatch "\v#_>"
syntax match hyUnpack "\v#\*{1,2}"
syntax match hyKeywordMacro "\v#[=+!-]:\k*" contains=hyKeywordMacroKeyword
syntax match hyKeywordMacroKeyword "\v:\k*" contained
" hy permits no more than 20 params.
syntax match hyAnonArg "%\(20\|1\d\|[1-9]\|&\)\?"

syntax match   hyRegexpEscape  "\v\\%(\\|[tnrfae]|c\u|0[0-3]?\o{1,2}|x%(\x{2}|\{\x{1,6}\})|u\x{4})" contained display
syntax region  hyRegexpQuoted  start=/\v\<@!\\Q/ms=e+1 skip=/\v\\\\|\\"/ end=/\\E/me=s-1 end=/"/me=s-1 contained
syntax region  hyRegexpQuote   start=/\v\<@!\\Q/       skip=/\v\\\\|\\"/ end=/\\E/       end=/"/me=s-1 contains=hyRegexpQuoted keepend contained
syntax cluster hyRegexpEscapes contains=hyRegexpEscape,hyRegexpQuote

syntax match hyRegexpPosixCharClass "\v\\[pP]\{%(ASCII|Alnum|Alpha|Blank|Cntrl|Digit|Graph|Lower|Print|Punct|Space|Upper|XDigit)\}" contained display
syntax match hyRegexpJavaCharClass "\v\\[pP]\{java%(Alphabetic|Defined|Digit|ISOControl|IdentifierIgnorable|Ideographic|JavaIdentifierPart|JavaIdentifierStart|Letter|LetterOrDigit|LowerCase|Mirrored|SpaceChar|TitleCase|UnicodeIdentifierPart|UnicodeIdentifierStart|UpperCase|Whitespace)\}" contained display
syntax match hyRegexpUnicodeCharClass "\v\\[pP]\{\cIs%(alnum|alphabetic|assigned|blank|control|digit|graph|hex_digit|hexdigit|ideographic|letter|lowercase|noncharacter_code_point|noncharactercodepoint|print|punctuation|titlecase|uppercase|white_space|whitespace|word)\}" contained display
syntax match hyRegexpUnicodeCharClass "\v\\[pP]%(C|L|M|N|P|S|Z)" contained display
syntax match hyRegexpUnicodeCharClass "\v\\[pP]\{%(Is|gc\=|general_category\=)?%(C[cfnos]|L[CDlmotu]|M[cen]|N[dlo]|P[cdefios]|S[ckmo]|Z[lps])\}" contained display
syntax match hyRegexpUnicodeCharClass "\v\\[pP]\{\c%(Is|sc\=|script\=)%(arab|arabic|armenian|armi|armn|avestan|avst|bali|balinese|bamu|bamum|batak|batk|beng|bengali|bopo|bopomofo|brah|brahmi|brai|braille|bugi|buginese|buhd|buhid|canadian_aboriginal|cans|cari|carian|cham|cher|cherokee|common|copt|coptic|cprt|cuneiform|cypriot|cyrillic|cyrl|deseret|deva|devanagari|dsrt|egyp|egyptian_hieroglyphs|ethi|ethiopic|geor|georgian|glag|glagolitic|goth|gothic|greek|grek|gujarati|gujr|gurmukhi|guru|han|hang|hangul|hani|hano|hanunoo|hebr|hebrew|hira|hiragana|imperial_aramaic|inherited|inscriptional_pahlavi|inscriptional_parthian|ital|java|javanese|kaithi|kali|kana|kannada|katakana|kayah_li|khar|kharoshthi|khmer|khmr|knda|kthi|lana|lao|laoo|latin|latn|lepc|lepcha|limb|limbu|linb|linear_b|lisu|lyci|lycian|lydi|lydian|malayalam|mand|mandaic|meetei_mayek|mlym|mong|mongolian|mtei|myanmar|mymr|new_tai_lue|nko|nkoo|ogam|ogham|ol_chiki|olck|old_italic|old_persian|old_south_arabian|old_turkic|oriya|orkh|orya|osma|osmanya|phag|phags_pa|phli|phnx|phoenician|prti|rejang|rjng|runic|runr|samaritan|samr|sarb|saur|saurashtra|shavian|shaw|sinh|sinhala|sund|sundanese|sylo|syloti_nagri|syrc|syriac|tagalog|tagb|tagbanwa|tai_le|tai_tham|tai_viet|tale|talu|tamil|taml|tavt|telu|telugu|tfng|tglg|thaa|thaana|thai|tibetan|tibt|tifinagh|ugar|ugaritic|unknown|vai|vaii|xpeo|xsux|yi|yiii|zinh|zyyy|zzzz)\}" contained display
syntax match hyRegexpUnicodeCharClass "\v\\[pP]\{\c%(In|blk\=|block\=)%(aegean numbers|aegean_numbers|aegeannumbers|alchemical symbols|alchemical_symbols|alchemicalsymbols|alphabetic presentation forms|alphabetic_presentation_forms|alphabeticpresentationforms|ancient greek musical notation|ancient greek numbers|ancient symbols|ancient_greek_musical_notation|ancient_greek_numbers|ancient_symbols|ancientgreekmusicalnotation|ancientgreeknumbers|ancientsymbols|arabic|arabic presentation forms-a|arabic presentation forms-b|arabic supplement|arabic_presentation_forms_a|arabic_presentation_forms_b|arabic_supplement|arabicpresentationforms-a|arabicpresentationforms-b|arabicsupplement|armenian|arrows|avestan|balinese|bamum|bamum supplement|bamum_supplement|bamumsupplement|basic latin|basic_latin|basiclatin|batak|bengali|block elements|block_elements|blockelements|bopomofo|bopomofo extended|bopomofo_extended|bopomofoextended|box drawing|box_drawing|boxdrawing|brahmi|braille patterns|braille_patterns|braillepatterns|buginese|buhid|byzantine musical symbols|byzantine_musical_symbols|byzantinemusicalsymbols|carian|cham|cherokee|cjk compatibility|cjk compatibility forms|cjk compatibility ideographs|cjk compatibility ideographs supplement|cjk radicals supplement|cjk strokes|cjk symbols and punctuation|cjk unified ideographs|cjk unified ideographs extension a|cjk unified ideographs extension b|cjk unified ideographs extension c|cjk unified ideographs extension d|cjk_compatibility|cjk_compatibility_forms|cjk_compatibility_ideographs|cjk_compatibility_ideographs_supplement|cjk_radicals_supplement|cjk_strokes|cjk_symbols_and_punctuation|cjk_unified_ideographs|cjk_unified_ideographs_extension_a|cjk_unified_ideographs_extension_b|cjk_unified_ideographs_extension_c|cjk_unified_ideographs_extension_d|cjkcompatibility|cjkcompatibilityforms|cjkcompatibilityideographs|cjkcompatibilityideographssupplement|cjkradicalssupplement|cjkstrokes|cjksymbolsandpunctuation|cjkunifiedideographs|cjkunifiedideographsextensiona|cjkunifiedideographsextensionb|cjkunifiedideographsextensionc|cjkunifiedideographsextensiond|combining diacritical marks|combining diacritical marks for symbols|combining diacritical marks supplement|combining half marks|combining marks for symbols|combining_diacritical_marks|combining_diacritical_marks_supplement|combining_half_marks|combining_marks_for_symbols|combiningdiacriticalmarks|combiningdiacriticalmarksforsymbols|combiningdiacriticalmarkssupplement|combininghalfmarks|combiningmarksforsymbols|common indic number forms|common_indic_number_forms|commonindicnumberforms|control pictures|control_pictures|controlpictures|coptic|counting rod numerals|counting_rod_numerals|countingrodnumerals|cuneiform|cuneiform numbers and punctuation|cuneiform_numbers_and_punctuation|cuneiformnumbersandpunctuation|currency symbols|currency_symbols|currencysymbols|cypriot syllabary|cypriot_syllabary|cypriotsyllabary|cyrillic|cyrillic extended-a|cyrillic extended-b|cyrillic supplement|cyrillic supplementary|cyrillic_extended_a|cyrillic_extended_b|cyrillic_supplementary|cyrillicextended-a|cyrillicextended-b|cyrillicsupplement|cyrillicsupplementary|deseret|devanagari|devanagari extended|devanagari_extended|devanagariextended|dingbats|domino tiles|domino_tiles|dominotiles|egyptian hieroglyphs|egyptian_hieroglyphs|egyptianhieroglyphs|emoticons|enclosed alphanumeric supplement|enclosed alphanumerics|enclosed cjk letters and months|enclosed ideographic supplement|enclosed_alphanumeric_supplement|enclosed_alphanumerics|enclosed_cjk_letters_and_months|enclosed_ideographic_supplement|enclosedalphanumerics|enclosedalphanumericsupplement|enclosedcjklettersandmonths|enclosedideographicsupplement|ethiopic|ethiopic extended|ethiopic extended-a|ethiopic supplement|ethiopic_extended|ethiopic_extended_a|ethiopic_supplement|ethiopicextended|ethiopicextended-a|ethiopicsupplement|general punctuation|general_punctuation|generalpunctuation|geometric shapes|geometric_shapes|geometricshapes|georgian|georgian supplement|georgian_supplement|georgiansupplement|glagolitic|gothic|greek|greek and coptic|greek extended|greek_extended|greekandcoptic|greekextended|gujarati|gurmukhi|halfwidth and fullwidth forms|halfwidth_and_fullwidth_forms|halfwidthandfullwidthforms|hangul compatibility jamo|hangul jamo|hangul jamo extended-a|hangul jamo extended-b|hangul syllables|hangul_compatibility_jamo|hangul_jamo|hangul_jamo_extended_a|hangul_jamo_extended_b|hangul_syllables|hangulcompatibilityjamo|hanguljamo|hanguljamoextended-a|hanguljamoextended-b|hangulsyllables|hanunoo|hebrew|high private use surrogates|high surrogates|high_private_use_surrogates|high_surrogates|highprivateusesurrogates|highsurrogates|hiragana|ideographic description characters|ideographic_description_characters|ideographicdescriptioncharacters|imperial aramaic|imperial_aramaic|imperialaramaic|inscriptional pahlavi|inscriptional parthian|inscriptional_pahlavi|inscriptional_parthian|inscriptionalpahlavi|inscriptionalparthian|ipa extensions|ipa_extensions|ipaextensions|javanese|kaithi|kana supplement|kana_supplement|kanasupplement|kanbun|kangxi radicals|kangxi_radicals|kangxiradicals|kannada|katakana|katakana phonetic extensions|katakana_phonetic_extensions|katakanaphoneticextensions|kayah li|kayah_li|kayahli|kharoshthi|khmer|khmer symbols|khmer_symbols|khmersymbols|lao|latin extended additional|latin extended-a|latin extended-b|latin extended-c|latin extended-d|latin-1 supplement|latin-1supplement|latin_1_supplement|latin_extended_a|latin_extended_additional|latin_extended_b|latin_extended_c|latin_extended_d|latinextended-a|latinextended-b|latinextended-c|latinextended-d|latinextendedadditional|lepcha|letterlike symbols|letterlike_symbols|letterlikesymbols|limbu|linear b ideograms|linear b syllabary|linear_b_ideograms|linear_b_syllabary|linearbideograms|linearbsyllabary|lisu|low surrogates|low_surrogates|lowsurrogates|lycian|lydian|mahjong tiles|mahjong_tiles|mahjongtiles|malayalam|mandaic|mathematical alphanumeric symbols|mathematical operators|mathematical_alphanumeric_symbols|mathematical_operators|mathematicalalphanumericsymbols|mathematicaloperators|meetei mayek|meetei_mayek|meeteimayek|miscellaneous mathematical symbols-a|miscellaneous mathematical symbols-b|miscellaneous symbols|miscellaneous symbols and arrows|miscellaneous symbols and pictographs|miscellaneous technical|miscellaneous_mathematical_symbols_a|miscellaneous_mathematical_symbols_b|miscellaneous_symbols|miscellaneous_symbols_and_arrows|miscellaneous_symbols_and_pictographs|miscellaneous_technical|miscellaneousmathematicalsymbols-a|miscellaneousmathematicalsymbols-b|miscellaneoussymbols|miscellaneoussymbolsandarrows|miscellaneoussymbolsandpictographs|miscellaneoustechnical|modifier tone letters|modifier_tone_letters|modifiertoneletters|mongolian|musical symbols|musical_symbols|musicalsymbols|myanmar|myanmar extended-a|myanmar_extended_a|myanmarextended-a|new tai lue|new_tai_lue|newtailue|nko|number forms|number_forms|numberforms|ogham|ol chiki|ol_chiki|olchiki|old italic|old persian|old south arabian|old turkic|old_italic|old_persian|old_south_arabian|old_turkic|olditalic|oldpersian|oldsoutharabian|oldturkic|optical character recognition|optical_character_recognition|opticalcharacterrecognition|oriya|osmanya|phags-pa|phags_pa|phaistos disc|phaistos_disc|phaistosdisc|phoenician|phonetic extensions|phonetic extensions supplement|phonetic_extensions|phonetic_extensions_supplement|phoneticextensions|phoneticextensionssupplement|playing cards|playing_cards|playingcards|private use area|private_use_area|privateusearea|rejang|rumi numeral symbols|rumi_numeral_symbols|ruminumeralsymbols|runic|samaritan|saurashtra|shavian|sinhala|small form variants|small_form_variants|smallformvariants|spacing modifier letters|spacing_modifier_letters|spacingmodifierletters|specials|sundanese|superscripts and subscripts|superscripts_and_subscripts|superscriptsandsubscripts|supplemental arrows-a|supplemental arrows-b|supplemental mathematical operators|supplemental punctuation|supplemental_arrows_a|supplemental_arrows_b|supplemental_mathematical_operators|supplemental_punctuation|supplementalarrows-a|supplementalarrows-b|supplementalmathematicaloperators|supplementalpunctuation|supplementary private use area-a|supplementary private use area-b|supplementary_private_use_area_a|supplementary_private_use_area_b|supplementaryprivateusearea-a|supplementaryprivateusearea-b|surrogates_area|syloti nagri|syloti_nagri|sylotinagri|syriac|tagalog|tagbanwa|tags|tai le|tai tham|tai viet|tai xuan jing symbols|tai_le|tai_tham|tai_viet|tai_xuan_jing_symbols|taile|taitham|taiviet|taixuanjingsymbols|tamil|telugu|thaana|thai|tibetan|tifinagh|transport and map symbols|transport_and_map_symbols|transportandmapsymbols|ugaritic|unified canadian aboriginal syllabics|unified canadian aboriginal syllabics extended|unified_canadian_aboriginal_syllabics|unified_canadian_aboriginal_syllabics_extended|unifiedcanadianaboriginalsyllabics|unifiedcanadianaboriginalsyllabicsextended|vai|variation selectors|variation selectors supplement|variation_selectors|variation_selectors_supplement|variationselectors|variationselectorssupplement|vedic extensions|vedic_extensions|vedicextensions|vertical forms|vertical_forms|verticalforms|yi radicals|yi syllables|yi_radicals|yi_syllables|yijing hexagram symbols|yijing_hexagram_symbols|yijinghexagramsymbols|yiradicals|yisyllables)\}" contained display

syntax match   hyRegexpPredefinedCharClass "\v%(\\[dDsSwW]|\.)" contained display
syntax cluster hyRegexpCharPropertyClasses contains=hyRegexpPosixCharClass,hyRegexpJavaCharClass,hyRegexpUnicodeCharClass
syntax cluster hyRegexpCharClasses         contains=hyRegexpPredefinedCharClass,hyRegexpCharClass,@hyRegexpCharPropertyClasses
syntax region  hyRegexpCharClass           start="\\\@<!\[" end="\\\@<!\]" contained contains=hyRegexpPredefinedCharClass,@hyRegexpCharPropertyClasses
syntax match   hyRegexpBoundary            "\\[bBAGZz]"   contained display
syntax match   hyRegexpBoundary            "[$^]"         contained display
syntax match   hyRegexpQuantifier          "[?*+][?+]\="  contained display
syntax match   hyRegexpQuantifier          "\v\{\d+%(,|,\d+)?}\??" contained display
syntax match   hyRegexpOr                  "|" contained display
syntax match   hyRegexpBackRef             "\v\\%([1-9]\d*|k\<[a-zA-z]+\>)" contained display

" Mode modifiers, mode-modified spans, lookaround, regular and atomic
" grouping, and named-capturing.
syntax match hyRegexpMod "\v\(@<=\?:"                        contained display
syntax match hyRegexpMod "\v\(@<=\?[xdsmiuU]*-?[xdsmiuU]+:?" contained display
syntax match hyRegexpMod "\v\(@<=\?%(\<?[=!]|\>)"            contained display
syntax match hyRegexpMod "\v\(@<=\?\<[a-zA-Z]+\>"            contained display

syntax region hyRegexpGroup start="\\\@<!(" matchgroup=hyRegexpGroup end="\\\@<!)" contained contains=hyRegexpMod,hyRegexpQuantifier,hyRegexpBoundary,hyRegexpEscape,@hyRegexpCharClasses
syntax region hyRegexp start=/\#"/ skip=/\\\\\|\\"/ end=/"/ contains=@hyRegexpCharClasses,hyRegexpEscape,hyRegexpQuote,hyRegexpBoundary,hyRegexpQuantifier,hyRegexpOr,hyRegexpBackRef,hyRegexpGroup keepend

syntax keyword hyCommentTodo contained FIXME XXX TODO FIXME: XXX: TODO:

syntax match hyComment ";.*$" contains=hyCommentTodo,@Spell
syntax match hyComment "\%^#!.*$"

syntax region hySexp   matchgroup=hyParen    start="("  end=")"  contains=TOP,@Spell
syntax region hyVector matchgroup=hyParen    start="\[" end="\]" contains=TOP,@Spell
syntax region hyMap    matchgroup=hyParen    start="{"  end="}"  contains=TOP,@Spell
syntax region hySet    matchgroup=hyParen    start="#{" end="}"  contains=TOP,@Spell
syntax region hyTuple  matchgroup=hyParen    start="#(" end=")"  contains=TOP,@Spell

" Highlight superfluous closing parens, brackets and braces.
syntax match hyError "]\|}\|)"

syntax sync fromstart

highlight default link hyConstant     Constant
highlight default link hyBoolean      Boolean
highlight default link hyCharacter    Character
highlight default link hyKeyword      Keyword
highlight default link hyNumber       Number
highlight default link hyString       String
highlight default link hyStringEscape Special

highlight default link hyRegexp                    Constant
highlight default link hyRegexpEscape              Character
highlight default link hyRegexpCharClass           SpecialChar
highlight default link hyRegexpPosixCharClass      hyRegexpCharClass
highlight default link hyRegexpJavaCharClass       hyRegexpCharClass
highlight default link hyRegexpUnicodeCharClass    hyRegexpCharClass
highlight default link hyRegexpPredefinedCharClass hyRegexpCharClass
highlight default link hyRegexpBoundary            SpecialChar
highlight default link hyRegexpQuantifier          SpecialChar
highlight default link hyRegexpMod                 SpecialChar
highlight default link hyRegexpOr                  SpecialChar
highlight default link hyRegexpBackRef             SpecialChar
highlight default link hyRegexpGroup               hyRegexp
highlight default link hyRegexpQuoted              hyString
highlight default link hyRegexpQuote               hyRegexpBoundary

highlight default link hyVariable      Identifier
highlight default link hyConditional   Conditional
highlight default link hyDefine        Define
highlight default link hyAsync         Define
highlight default link hyErrorHandling Exception
highlight default link hyException     Type
highlight default link hyBuiltin       Function
highlight default link hyPythonBuiltin Function
highlight default link hyAnaphoric     Macro
highlight default link hyTagMacro      Macro
highlight default link hyKeywordMacro  Macro
highlight default link hyKeywordMacroKeyword Identifier
highlight default link hyRepeat        Repeat
highlight default link hyOpNoInplace   Operator
highlight default link hyOpInplace     Operator
highlight default link hyStatement     Statement
highlight default link hyMisc          PreProc
highlight default link hyInclude       Include

highlight default link hySpecial   Special
highlight default link hyVarArg    Special
highlight default link hyQuote     SpecialChar
highlight default link hyUnquote   SpecialChar
highlight default link hyMeta      SpecialChar
highlight default link hyDeref     SpecialChar
highlight default link hyAnonArg   SpecialChar
highlight default link hyDispatch  SpecialChar
highlight default link hyUnpack    SpecialChar

highlight default link hyComment     Comment
highlight default link hyCommentTodo Todo

highlight default link hyError     Error

highlight default link hyParen     Delimiter


" Conceal
if !has('conceal') || &enc != 'utf-8' || get(g:, 'hy_enable_conceal', 0) != 1
	finish
endif

syn match hyAsync contained "/a" conceal cchar=a

syn match hyDefine contained "fn" conceal cchar=λ
syn match hyDefine "fn/a" contains=hyDefine,hyAsync
syn keyword hyDefine fn conceal cchar=λ

syntax keyword hyDefine lambda conceal cchar=λ

syn match hyDefine contained "defn" conceal cchar=ƒ
syn match hyDefine "defn/a" contains=hyDefine,hyAsync
syn keyword hyDefine defn conceal cchar=ƒ

syntax keyword hyMacro and conceal cchar=∧
syntax keyword hyMacro or  conceal cchar=∨
syntax keyword hyMacro not conceal cchar=¬

syntax keyword hyFunc <=
syntax match hyFunc "<=" conceal cchar=≤
syntax keyword hyFunc >= conceal cchar=≥
syntax keyword hyFunc != conceal cchar=≠

syntax keyword hyFunc * conceal cchar=∙
syntax keyword hyFunc math.sqrt conceal cchar=√

syntax keyword hyMacro ->  conceal cchar=⊳
syntax keyword hyMacro ->> conceal cchar=‣

syntax keyword hyConstant None    conceal cchar=∅
syntax keyword hyConstant math.pi conceal cchar=π
syntax keyword hyConstant sum     conceal cchar=∑

syntax match hyRepeat contained "l" conceal cchar=l
syntax match hyRepeat contained "s" conceal cchar=s
syntax match hyRepeat contained "d" conceal cchar=d
syntax match hyRepeat contained "g" conceal cchar=g
syntax match hyRepeat contained "for" conceal cchar=∀
syntax match hyRepeat "for/a" contains=hyRepeat,hyAsync
syntax match hyRepeat "lfor" contains=hyRepeat,hyRepeat
syntax match hyRepeat "sfor" contains=hyRepeat,hyRepeat
syntax match hyRepeat "dfor" contains=hyRepeat,hyRepeat
syntax match hyRepeat "gfor" contains=hyRepeat,hyRepeat
syntax match hyRepeat "cfor" contains=hyRepeat,hyRepeat
syntax keyword hyRepeat for conceal cchar=∀

syntax keyword hyMacro  some   conceal cchar=∃
syntax keyword hyMacro  in     conceal cchar=∈
syntax keyword hyMacro  not-in conceal cchar=∉

syntax keyword hyVariable alpha   conceal cchar=α
syntax keyword hyVariable beta    conceal cchar=β
syntax keyword hyVariable gamma   conceal cchar=γ
syntax keyword hyVariable delta   conceal cchar=δ
syntax keyword hyVariable epsilon conceal cchar=ε

syntax match hyAnonVarName "x" conceal cchar=x contained
let s:idxchars = ['₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉']
for s:idx in range(0, 9)
	execute 'syntax match hyAnonVarIndex "' . s:idx . '" conceal cchar=' . s:idxchars[s:idx] . ' contained'
endfor
if get(g:, "hy_conceal_fancy", 0) == 1
	syntax match hyAnonVar "\<x[0-9]\+\>" contains=hyAnonVarName,hyAnonVarIndex
	syntax keyword hyAnonVar xi conceal cchar=ξ
	syntax match hyTagMacro "#%" conceal cchar=ξ
else
	syntax match hyAnonVarIndex "i" conceal cchar=¡ contained
	syntax match hyTagMacro contained "#" conceal cchar=x
	syntax match hyAnonArg contained "%" conceal cchar=¡
    syntax match hyTagMacro "#%" contains=hyTagMacro,hyAnonArg
	syntax match hyAnonVar "\<x[0-9i]\+\>" contains=hyAnonVarName,hyAnonVarIndex
endif

" hi! link Conceal Define

setlocal conceallevel=2

" vim:sts=4:sw=4:ts=4:et:smc=20000
