%%{
    machine html;

    RCData := (any+ >StartRCData >StartSlice %MarkPosition %EmitSlice)? :> (
        '<' @StartSlice @To_RCDataLessThanSign
    )?;

    RCDataLessThanSign := _SpecialEndTag @err(To_RCData);
}%%
