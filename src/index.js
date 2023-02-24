import { run } from '@cycle/run';
import { makeDOMDriver } from '@cycle/react-dom';
import { jsxFactory } from '@cycle/react-dom';

function main(sources) {
  const inc = Symbol();
  const inc$ = sources.react.select(inc).events('click');

  const count$ = inc$.fold(count => count + 1, 0);

  const vdom$ = count$.map(i =>
    <div>
      <h1>Hello world</h1>
    </div>
    // div([
    //   h1(`Counter: ${i}`),
    //   button(inc, 'Increment'),
    // ]),
  );

  return {
    react: vdom$,
  };
}

run(main, {
  react: makeDOMDriver(document.getElementById('app')),
});