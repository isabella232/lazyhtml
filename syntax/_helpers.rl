%%{
    machine html;

    TAB = '\t';
    CR = '\r';
    LF = '\n';
    FF = '\f';

    TagNameSpace = TAB | CR | LF | FF | ' ';

    TagNameEnd = TagNameSpace | '/' | '>';

    _Quote = ('"' | "'");

    _StartQuote = _Quote @SaveQuote;

    _EndQuote = _Quote when IsMatchingQuote;

    _SafeText = (any+ >StartSafe >StartSlice %EmitSlice)?;

    _EndTagEnd = (
        TagNameSpace |
        '/' |
        '>'
    ) @Reconsume @To_EndTagNameContents;

    _SpecialEndTag = (
        '/' >StartAppropriateEndTag
        (alpha when FeedAppropriateEndTag)*
        _EndTagEnd when IsAppropriateEndTagFed >CreateEndTagToken >SetAppropriateEndTagName
    ) @err(AsRawSlice) @err(EmitSlice) @err(Reconsume);
}%%
