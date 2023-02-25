module Document = {
  @send external getElementById: (Dom.document, string) => Dom.element = "getElementById"
  @val external v: Dom.document = "document"
}
