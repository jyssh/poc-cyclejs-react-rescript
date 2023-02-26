%%raw(`import xs from 'xstream';`)
open CycleJs
open CycleJs.React.Vdom
open DomApi

let main = (sources: CycleJs.sourceStreams) => {
  let incS = sources.react->React.select("inc")->React.events_click
  let countS = incS->Stream.fold((acc, _) => acc + 1, 0)
  let vdomS =
    countS->Stream.map(i =>
      div({}, [h1_({}, `Counter: ${i->Js.Int.toString}`), button_({sel: "inc"}, "Increment")])
    )

  {react: vdomS}
}

let _ = CycleJs.run(main, {react: CycleJs.React.makeDOMDriver(Document.v->Document.getElementById("app"))})