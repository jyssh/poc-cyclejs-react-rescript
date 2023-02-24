import xs from 'xstream';
import { jsxFactory } from '@cycle/react-dom';
import { run } from '@cycle/run';
import { makeDOMDriver, div, h1, button } from '@cycle/react-dom';

function main(sources) {
  const inc = Symbol();
  const inc$ = sources.react.select(inc).events('click');

  const count$ = inc$.fold(count => count + 1, 0);

  const vdom$ = count$.map(i =>
    <div>
      <h1>Counter : {i}</h1>
      <button sel={inc}>Increment</button>
    </div>
  );

  return {
    react: vdom$,
  };
}

run(main, {
  react: makeDOMDriver(document.getElementById('app')),
});