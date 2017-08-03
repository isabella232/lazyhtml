%%{
    machine html;

    Data := (any+ >CreateCharacter >AllowEntities >StartSlice %EmitSlice)? :> (
        '<' @StartSlice @To_TagOpen
    )?;

    TagOpen := (
        (
            '!' @To_MarkupDeclarationOpen |
            '/' @To_EndTagOpen |
            alpha @CreateStartTagToken @StartSlice @To_StartTagName |
            '?' @Reconsume @To_BogusComment
        ) >1 |
        any >0 @CreateCharacter @EmitSlice @Reconsume @To_Data
    ) @eof(CreateCharacter) @eof(EmitSlice);

    _BogusComment = any* >StartSlice %MarkPosition %EndComment %EmitToken %UnmarkPosition :> ('>' @To_Data)?;

    BogusComment := _BogusComment;

    MarkupDeclarationOpen := (
        (
            '--' @To_Comment |
            /DOCTYPE/i @To_DocType |
            '[' when IsCDataAllowed 'CDATA[' @CreateCDataStart @EmitToken @To_CDataSection
        ) @1 |
        _BogusComment $0
    );
}%%
