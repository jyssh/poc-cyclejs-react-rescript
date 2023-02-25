module Stream = {
  // NOTE:
  // Right now, I have unified xstream's Stream and its subtype MemoryStream into a single type.
  // imitate() is 'deprecated'. Rest of the API doesn't quite use MemoryStream in a distinct-type way.

  // Flapjax handles the switch
  // between MemoryStream (aka Behaviour) and Stream (aka EventStream)
  // elegantly via changes(): Behaviour -> EventStream
  // This also lets the Flapjax API neatly divide the associated functions
  // between Behaviour and EventStream without duplication.
  // https://www.flapjax-lang.org/docs

  type t<'a>

  @send external map: (t<'a>, 'a => 'b) => t<'b> = "map"
  @send external fold: (t<'a>, ('b, 'a) => 'b, 'b) => t<'b> = "fold"
}

module React = {
  module Vdom = {
    type t

    module AttrSet = {
      type t = {
        sel?: string,
        id?: string,
        name?: string,
        @as("aria-invalid") ariaInvalid?: string,
      }
    }

    /*
    // Good code, but involves needless function calls on attrset of every vnode in the tree.
    type attr =
      | Id(string)
      | Name(string)

    type attrset = {
      id?: string,
      name?: string,
      @as("aria-valid") ariaValid?: string,
    }

    let makeAttrSet = attrs => {
      attrs->Js.Array2.reduce((acc, curr) => {
        switch curr {
        | Id(id) => {...acc, id}
        | Name(name) => {...acc, name}
        }
      }, {})
    }

    Js.Console.log(makeAttrSet([Id("id"), Name("name")]))
 */

    @module("@cycle/react-dom")
    external div: (AttrSet.t, array<t>) => t = "div"
    @module("@cycle/react-dom")
    external div_: (AttrSet.t, string) => t = "div"

    @module("@cycle/react-dom")
    external h1: (AttrSet.t, array<t>) => t = "h1"
    @module("@cycle/react-dom")
    external h1_: (AttrSet.t, string) => t = "h1"

    @module("@cycle/react-dom")
    external button: (AttrSet.t, array<t>) => t = "button"
    @module("@cycle/react-dom")
    external button_: (AttrSet.t, string) => t = "button"
  }

  type reactEvent

  type driver = Stream.t<Vdom.t> => Stream.t<Vdom.t>

  @module("@cycle/react-dom") external makeDOMDriver: Dom.element => driver = "makeDOMDriver"

  // TODO: Turn string to polymorphic variant?
  @send external select: (Stream.t<Vdom.t>, string) => Stream.t<Vdom.t> = "select"

  // TODO: Turn string to polymorphic variant
  @send external events: (Stream.t<Vdom.t>, string) => Stream.t<reactEvent> = "events"
}

type drivers = {react: React.driver}

type sourceStreams = {react: Stream.t<React.Vdom.t>}

type sinkStreams = {react: Stream.t<React.Vdom.t>}

type main = sourceStreams => sinkStreams

type disposeFunction = unit => unit

@module("@cycle/run") external run: (main, drivers) => disposeFunction = "run"
